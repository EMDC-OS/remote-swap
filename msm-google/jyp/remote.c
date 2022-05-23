#include <linux/kernel_stat.h>
#include <linux/mm.h>
#include <linux/sched/mm.h>
#include <linux/sched/signal.h>
#include <linux/sched/task.h>
#include <linux/hugetlb.h>
#include <linux/mman.h>
#include <linux/swap.h>
#include <linux/highmem.h>
#include <linux/pagemap.h>
#include <linux/memremap.h>
#include <linux/ksm.h>
#include <linux/rmap.h>
#include <linux/export.h>
#include <linux/delayacct.h>
#include <linux/init.h>
#include <linux/pfn_t.h>
#include <linux/writeback.h>
#include <linux/memcontrol.h>
#include <linux/mmu_notifier.h>
#include <linux/kallsyms.h>
#include <linux/swapops.h>
#include <linux/elf.h>
#include <linux/gfp.h>
#include <linux/migrate.h>
#include <linux/string.h>
#include <linux/debugfs.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/workqueue.h>


#include <asm/io.h>
#include <asm/mmu_context.h>
#include <asm/pgalloc.h>
#include <linux/uaccess.h>
#include <asm/tlb.h>
#include <asm/tlbflush.h>
#include <asm/pgtable.h>


#ifdef CONFIG_APP_AWARE
#include <linux/kernel.h>
#include <linux/app_aware.h>
#endif

#ifdef CONFIG_APP_AWARE



bool which_table;
bool switch_start;
atomic_t st_index0;
atomic_t st_index1;
struct swap_trace_entry swap_trace_table0[40000];
struct swap_trace_entry swap_trace_table1[40000];
int backgrounded_uid;
atomic_t sent_cold_page;
atomic_t faulted_cold_page;


struct cold_page_sender_work {
	struct work_struct work;
	struct task_struct *task;	
};


/*
 * Send Cold Pages to NBD
 *
 */


static void cold_page_sender_work(struct work_struct *work)
{

	struct cold_page_sender_work *tew;

	struct vm_area_struct   *vma;
	unsigned long           vpage;
    struct page *page;   
	struct task_struct *task;
	int cnt = 0;

	tew = container_of(work, struct cold_page_sender_work, work);
	task = tew->task;

	if(!task)     
    {
		printk(KERN_ERR "[REMOTE %s] task is NULL \n", __func__);
        return ;
    }
    
        
	page = alloc_pages(GFP_KERNEL, 0);
	SetPageUnevictable(page);
	if(task->mm && task->mm->mmap) 
    {
		for(vma = task->mm->mmap; vma; vma = vma->vm_next) 
		{
			int idx = 0;
			for(vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx ++)
			{
                    // walk page table start
				pgd_t *pgd;
				pud_t *pud;
				pmd_t *pmd;
				pte_t *pte;
				pte_t *orig_pte;
				spinlock_t *ptl;
				u64 counter;
				struct mm_struct *mm = task->mm;
				struct page *cache_page;
				pgd = pgd_offset(mm, vpage);
				if(pgd_none(*pgd))
					continue;
				pud = pud_offset(pgd, vpage);
				if(pud_none(*pud))
					continue;
				pmd = pmd_offset(pud, vpage);
				if(pmd_none(*pmd))
					continue;
				pte = pte_offset_kernel(pmd, vpage);
				if(!pte || pte_none(*pte))
				{
					continue;
				}
				// walk page table end
                
				if(is_swap_pte(*pte))       // if the pte is swapped (swp_entry)
				{
					swp_entry_t entry = pte_to_swp_entry(*pte);
					counter = pte_to_swp_counter(*pte);
					if(non_swap_entry(entry))
					{
						continue;
					}
					
					if(swp_swapcount(entry) != 1 || counter <= COLD_PAGE_THRESHOLD) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{

						struct address_space *mapping;
						swp_entry_t temp_entry;
						swp_entry_t new_entry;
						pte_t new_pte;
						int ret;
						cache_page = find_get_page(swap_address_space(entry), swp_offset(entry));
						if(cache_page){
							/*
							 * Continue for now, but should delete swap cache and resume
							 *
							 */
							continue;
						}
						new_entry = get_swap_page_of_type(NBD_TYPE);
						new_pte = swp_entry_and_counter_to_pte(new_entry,1);
						//if COLD, type==1 && counter==1
						orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);


						
						lock_page(page);
						__SetPageSwapBacked(page);
						ClearPageUptodate(page);
						
						set_page_private(page, entry.val);
					
						ksg_swap_readpage(page, true);
						ret=add_to_swap_cache(page, new_entry,
								__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
						
						temp_entry.val=page_private(page);
						set_page_dirty(page);
						mapping = page_mapping(page);
						page->mapping = mapping;
						
						write_one_page(page);
						temp_entry.val=page_private(page);
						__delete_from_swap_cache(page);
						set_pte(orig_pte, new_pte);
						unlock_page(page);
						pte_unmap_unlock(orig_pte, ptl);
						cnt++;

						
					}
				}
			}
		}
	}
						
	atomic_add(cnt,&sent_cold_page);

	trace_printk("remote: total sent cold page: %d\n", sent_cold_page);
	trace_printk("remote: total faulted cold page: %d\n", faulted_cold_page);
	free_pages((unsigned long)(page_address(page)), 0);
	kfree(tew);

}





void cold_page_sender_handler(struct task_struct *p)
{

	struct cold_page_sender_work *tew;

	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;

	INIT_WORK(&tew->work, cold_page_sender_work);
	tew->task = p;

	schedule_work_on(0,&tew->work); // cpu 0 


}

int ksg_pid;

int ksg_handler(struct ctl_table *table, int write,
                        void __user *buffer, size_t *length, loff_t *ppos)
{
    int rc = proc_dointvec_minmax(table, write, buffer, length, ppos);

    printk("ksg: zram_to_nbd_handler start");
    if(rc)
        return rc;
    if(write)
    {
        /* for check declaration, check printk in dmesg */
        //printk("@@@@@@@@@@@@@ zram_to_nbd pid = %d  @@@@@@@@@@\n", zram_to_nbd);
        pid_t                   pid = (pid_t)ksg_pid;   // get target pid through sysctl
        struct task_struct      *task = find_task_by_vpid(pid); // get target_process' struct task_struct
        struct vm_area_struct   *vma;
        unsigned long           vpage;
        struct page *page = alloc_pages(GFP_KERNEL, 0); // read page from ZRAM to here && write this page to NBD, == alloc_page(GFP_KERNEL)
        SetPageUnevictable(page);
        //if(page)
        //{
        //  printk("ksg: Successful allocate page\n");  // for check page alloc
        //}

        if(!task)       // can't get target process's task_struct
        {
            printk("No Target Proc %d\n", pid);
            //free_pages((unsigned long)(page_address(page)), 0);
            return 0;
        }
        if(task->mm && task->mm->mmap)  // if target_proc is well mmaped
        {
		
			flush_tlb_mm(task->mm);
            //printk("ksg: before 1st for");
            //spin_lock(&mm->page_table_lock);
            for(vma = task->mm->mmap; vma; vma = vma->vm_next)  //
            {
                int idx = 0;
                //printk("ksg: before 2nd for");
                for(vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx ++)
                {
                    // walk page table start
                    pgd_t *pgd;
                    pud_t *pud;
                    pmd_t *pmd;
                    pte_t *pte;
					pte_t *orig_pte;
                    spinlock_t *ptl;
                    struct mm_struct *mm = task->mm;
					struct page *cache_page;
                    pgd = pgd_offset(mm, vpage);
                    if(pgd_none(*pgd))
                        continue;
                    pud = pud_offset(pgd, vpage);
                    if(pud_none(*pud))
                        continue;
                    pmd = pmd_offset(pud, vpage);
                    if(pmd_none(*pmd))
                        continue;
                    pte = pte_offset_kernel(pmd, vpage);
                    //pte = pte_offset_map_lock(mm, pmd,
                    //                      vpage, &ptl);
                    if(!pte || pte_none(*pte))
                    {
                        //pte_unmap_unlock(pte, ptl);
                        continue;
                    }
                    // walk page table end
                    if(is_swap_pte(*pte))       // if the pte is swapped (swp_entry)
                    {
                        swp_entry_t entry = pte_to_swp_entry(*pte); // target swap entry
                        if(non_swap_entry(entry))
                        {
                            continue;
                        }
                        if(swp_swapcount(entry) != 1) {
                            continue;
                        }
                        else                    // page is swapped and swap entry.
                        {
                            if(swp_type(entry) == ZRAM_TYPE)    // swap entry is in ZRAM (type == 0)
                            {
						
                                cache_page = find_get_page(swap_address_space(entry), swp_offset(entry));     // find page from cache first
                                //if(cache_page)
                                //{
                                    //printk("ksg: find page from cache!!\n");
                                //  continue;
                                //}
                                if(!cache_page)       // can't find the page from cache
                                {

                                    struct address_space *mapping;
                                   
									swp_entry_t temp_entry;


									swp_entry_t new_entry = get_swap_page_of_type(NBD_TYPE);
                                    pte_t new_pte = swp_entry_to_pte(new_entry);
                                    
									int ret;
									orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);
                                    //struct page *test_page;
                                    /*struct writeback_control wbc = {
                                        .sync_mode = WB_SYNC_ALL,
                                        .nr_to_write = SWAP_CLUSTER_MAX,
                                        .range_start = 0,
                                        .range_end = LLONG_MAX,
                                        .for_reclaim = 1,
                                    };*/
                                    //pte_t *vmf_pte;       // is that pte has approached?
                                    //spinlock_t *vmf_ptl;

                                    //printk("ksg: zram entry type = %d, nbd entry type = %d\n",sis->type, sis_nbd->type);
		

                                    lock_page(page);

									__SetPageSwapBacked(page);
									ClearPageUptodate(page);
									
									set_page_private(page, entry.val);
									ksg_swap_readpage(page, true);
									
                                    ret=add_to_swap_cache(page, new_entry,
                                    __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
									

									if(ret<0)
										printk("add to swap cache error %d\n",ret);

								

									temp_entry.val=page_private(page);
                                    set_page_dirty(page);
                                    //if(nbd_entry.val != page->private)
                                    //  printk("ksg: page private didn't set well");
                                    mapping = page_mapping(page);
                                    page->mapping = mapping;
                                    
									write_one_page(page);
									
									
									temp_entry.val=page_private(page);
                                    __delete_from_swap_cache(page);

                                   
                                    if(!is_swap_pte(*orig_pte))
                                        printk("ksg: already swapin not swap entry");

									/*
                                    if(!pte_same(*vmf_pte, *pte))
                                    {
                                        printk("ksg: pte is same!!!");
                                        set_pte_at(mm, vpage, pte, nbd_pte);
                                        pte_unmap_unlock(vmf_pte, vmf_ptl);
                                    }*/
                                    set_pte(orig_pte, new_pte);

									unlock_page(page);
                                    pte_unmap_unlock(orig_pte, ptl);

                                }
                            }
                            else// swap entry is not in ZRAM
                            {
                                //printk("ksg: swap entry is not in ZRAM\n");
                                //pte_unmap_unlock(pte, ptl);
                                continue;
                            }
                        }
                    }
                    //pte_unmap_unlock(pte, ptl);
                }
                //printk("ksg: after 2nd for");
            }
            //spin_unlock(&mm->page_table_lock);
        }
        printk("ksg: before free");
        free_pages((unsigned long)(page_address(page)), 0);
        printk("ksg: zram_to_nbd_handler end");
    }
    return 0;
}

EXPORT_SYMBOL(ksg_handler);



/*
 *  Increase counters of whole swap entries.
 *	An argument is *task.
 *
 *
 */
int task_swap_counter_inc(struct task_struct *task)
{


	struct vm_area_struct   *vma;
	unsigned long           vpage;
	bool flag = 0;
	
	if(!task)       // can't get target process's task_struct
    {
        return 0;
    }
    
	if(task->mm && task->mm->mmap)  // if target_proc is well mmaped
    {
		for(vma = task->mm->mmap; vma; vma = vma->vm_next)  //
		{
			int idx = 0;
			for(vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx ++)
			{
                    // walk page table start
				pgd_t *pgd;
				pud_t *pud;
				pmd_t *pmd;
				pte_t *pte;
				pte_t *orig_pte;
				spinlock_t *ptl;
				struct mm_struct *mm = task->mm;
				pgd = pgd_offset(mm, vpage);
				if(pgd_none(*pgd))
					continue;
				pud = pud_offset(pgd, vpage);
				if(pud_none(*pud))
					continue;
				pmd = pmd_offset(pud, vpage);
				if(pmd_none(*pmd))
					continue;
				pte = pte_offset_kernel(pmd, vpage);
				if(!pte || pte_none(*pte))
				{
					continue;
				}
				// walk page table end
                
				if(is_swap_pte(*pte))       // if the pte is swapped (swp_entry)
				{
					swp_entry_t entry = pte_to_swp_entry(*pte);
					if(non_swap_entry(entry) || swp_type(entry) == NBD_TYPE)
					{
						//pte_unmap_unlock(pte, ptl);
						continue;
					}
					
					if(swp_swapcount(entry) != 1) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{
						pte_t new_pte;
						u64 counter;
						orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);
						counter=pte_to_swp_counter(*pte);
						
						counter++;

						new_pte = swp_entry_and_counter_to_pte(entry,counter);
						set_pte(orig_pte, new_pte);
						pte_unmap_unlock(orig_pte, ptl);

						if(counter > COLD_PAGE_THRESHOLD)
							flag = 1;

					}
				}
			}
		}
	}

	return flag;
}

int app_switch_start;

int app_switch_start_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{

	
	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	if(rc)
		return rc;
	if(write){


		if(!foreground_uid)
			return 0;

		if(!which_table && atomic_read(&st_index0)==-1)
			which_table=0;
		else if(which_table && atomic_read(&st_index1)==-1)
			which_table=1;
		else
			which_table=!which_table;
		
		if(which_table)
			atomic_set(&st_index1,-1);
		else
			atomic_set(&st_index0,-1);
		switch_start = 1;





	}

	return 0;
}

int update_to_nbd_flag(int percentage){


	/*
	 * find both table and keep the flag on
	 * 
	 */

	int idx_e; //ealier
	int idx_l; //latter
	int max_idx_e;
	int max_idx_l;
	int cnt=0;
	struct swap_trace_entry *swap_trace_table_e;
	struct swap_trace_entry *swap_trace_table_l;

	//define st_idx_ptr_e = which_table ? &st_index0 : &st_index1
	//define stt_e = which_table ? swap_trace_table0 : swap_trace_table1
	//define st_idx_ptr_l = which_table ? &st_index1 : &st_index0
	//define stt_l = which_table ? swap_trace_table1 : swap_trace_table0
	
	if(which_table){
		max_idx_e = atomic_read(&st_index0);
		swap_trace_table_e = swap_trace_table0;
		max_idx_l = atomic_read(&st_index1);
		swap_trace_table_l = swap_trace_table1;
	}
	else{
		max_idx_e = atomic_read(&st_index1);
		swap_trace_table_e = swap_trace_table1;
		max_idx_l = atomic_read(&st_index0);
		swap_trace_table_l = swap_trace_table0;
	}

	idx_e = max_idx_e * percentage/100;
	idx_l = max_idx_l * percentage/100;



	while(idx_l <= max_idx_l){
		idx_e = max_idx_e * percentage/100;
		while(idx_e <= max_idx_e){
			if( swap_trace_table_e[idx_e].va == swap_trace_table_l[idx_l].va &&
				swap_trace_table_e[idx_e].tgid == swap_trace_table_l[idx_l].tgid){
				swap_trace_table_l[idx_l].to_nbd = 1;
				cnt++;
				break;
			}
			idx_e++;
		}
		idx_l++;
	}

	
	// for dump
	

	idx_l = max_idx_l * percentage/100;
	trace_printk("table %d is latter, total target %d max idx e, l -> %d %d\n", which_table,cnt,max_idx_e,max_idx_l);
	while(idx_l <= max_idx_l){
		if( swap_trace_table_l[idx_l].to_nbd )
			trace_printk("%d: tgid %d va %llx is target\n",idx_l,swap_trace_table_l[idx_l].tgid,swap_trace_table_l[idx_l].va);
		idx_l++;
	}

	return 0;
}

int app_switch_fin;

int app_switch_fin_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{


	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	if(rc)
		return rc;
	if(write){
	
		struct task_struct *p;
	
		/*
		 * Switch finished
		 */
		switch_start = 0;

		/*
		 * Update to_nbd flag of st_0
		 */

		
		if(foreground_uid && atomic_read(&st_index0)!=-1 && atomic_read(&st_index1)!=-1)
			update_to_nbd_flag(50); //<--app_number or uid


		/*
		 * Cold page handling
		 */
	
		if(backgrounded_uid){
			rcu_read_lock();
			for_each_process(p){
				if(!p)
					continue;
				if(backgrounded_uid&&p->cred->uid.val == backgrounded_uid){
					printk("backgrounded_uid %d",backgrounded_uid);
					if(task_swap_counter_inc(p))
						cold_page_sender_handler(p);
				}
			}
			rcu_read_unlock();
		}

		backgrounded_uid = foreground_uid;
	}
	return 0;
}






int swap_counter_dump;
int swap_counter_dump_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)

{

	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	int num[7]={0};
	if(rc)
		return rc;
	if(write){
	struct vm_area_struct   *vma;
	unsigned long           vpage;
	pid_t                   pid = (pid_t)swap_counter_dump;
    struct task_struct      *task = find_task_by_vpid(pid);
	if(!task)       // can't get target process's task_struct
    {
        return 0;
    }
    
	if(task->mm && task->mm->mmap)  // if target_proc is well mmaped
    {
		for(vma = task->mm->mmap; vma; vma = vma->vm_next)  //
		{
			int idx = 0;
			for(vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx ++)
			{
                    // walk page table start
				pgd_t *pgd;
				pud_t *pud;
				pmd_t *pmd;
				pte_t *pte;
				struct mm_struct *mm = task->mm;
				pgd = pgd_offset(mm, vpage);
				if(pgd_none(*pgd))
					continue;
				pud = pud_offset(pgd, vpage);
				if(pud_none(*pud))
					continue;
				pmd = pmd_offset(pud, vpage);
				if(pmd_none(*pmd))
					continue;
				pte = pte_offset_kernel(pmd, vpage);
				if(!pte || pte_none(*pte))
				{
					continue;
				}
				// walk page table end
                
				if(is_swap_pte(*pte))       // if the pte is swapped (swp_entry)
				{
					swp_entry_t entry = pte_to_swp_entry(*pte);
					if(non_swap_entry(entry))
					{
						//pte_unmap_unlock(pte, ptl);
						continue;
					}
					
					if(swp_swapcount(entry) != 1) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{
						u64 counter;
						counter=pte_to_swp_counter(*pte);

						if(counter<6){
							num[counter]++;
						}
						else
							num[6]++;
					}
				}
			}
		}
	}

	trace_printk("pid %d: counter 0 = %d\n",pid,num[0]);
	trace_printk("pid %d: counter 1 = %d\n",pid,num[1]);
	trace_printk("pid %d: counter 2 = %d\n",pid,num[2]);
	trace_printk("pid %d: counter 3 = %d\n",pid,num[3]);
	trace_printk("pid %d: counter 4 = %d\n",pid,num[4]);
	trace_printk("pid %d: counter 5 = %d\n",pid,num[5]);
	trace_printk("pid %d: counter >5 = %d\n",pid,num[6]);

	trace_printk("remote: total sent cold page: %d\n", sent_cold_page);
	trace_printk("remote: total faulted cold page: %d\n", faulted_cold_page);
	}
	return 0;
}

/*void cold_page_sender_wq_init(void)
{
	struct workqueue_struct *cold_page_sender_wq = create_workqueue("cold_page_sender_wq");
}*/





static int __init remote_swap_init(void)
{

	printk(KERN_ERR "[REMOTE %s] INIT remote swap\n", __func__);
			
	atomic_set(&st_index0,-1);
	atomic_set(&st_index1,-1);



	return 0;
}

module_init(remote_swap_init)

#endif

