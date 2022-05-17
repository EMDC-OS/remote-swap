#include <linux/kernel_stat.h>
#include <linux/mm.h>
#include <linux/sched/mm.h>
#include <linux/sched/coredump.h>
#include <linux/sched/numa_balancing.h>
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
#include <linux/dma-debug.h>
#include <linux/debugfs.h>
#include <linux/userfaultfd_k.h>
#include <linux/dax.h>
#include <linux/oom.h>

#include <trace/events/kmem.h>

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

#define ZRAM_TYPE   0
#define NBD_TYPE    1
#define COLD_PAGE_THRESHOLD 5


int background_swapout;

int background_swapout_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{


        unsigned long vpage;
        int idx;
        struct vm_area_struct *vma;

		int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
		if(rc)
			return rc;
		if(write){
		//	int cnt;
		//	struct page *tmp_page = alloc_page(GFP_KERNEL);
			pid_t pid = (pid_t)lru_scan_private;
       	 	struct task_struct *task = find_task_by_vpid(pid);
       		
			if (!task) {
            	    printk("task %d not found", pid);
                	return 0;
       		}



        if (task->mm && task->mm->mmap) {
                for (vma = task->mm->mmap; vma; vma = vma->vm_next) {
                        for (vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx++) {
                                pgd_t *pgd;
                                pud_t *pud;
                                pmd_t *pmd;
                                pte_t *pte;
								//struct page *page;
                                struct mm_struct *mm = task->mm;
                                // page table walk
                                pgd = pgd_offset(mm, vpage);
                                if (pgd_none(*pgd)) continue;
                                pud = pud_offset(pgd, vpage);
                                if (pud_none(*pud)) continue;
                                pmd = pmd_offset(pud, vpage);
                                if (pmd_none(*pmd)) continue;
                                pte = pte_offset_kernel(pmd, vpage);
                                if (!pte || pte_none(*pte)) continue;
                                	if (!pte_present(*pte)) {
									//	entry = pte_to_swp_entry(*pte);
								//		if(non_swap_entry(entry))
								//			continue;
										//read page
									
										// lock and swap_readpage from ZRAM
										
										
										//write page


									}
								}
                        }
                }
        }




		//free page


	return 0;


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
 * Send Cold Pages to NBD
 *
 */
int cold_page_sender(struct task_struct *task)
{

	struct vm_area_struct   *vma;
	unsigned long           vpage;
    struct page *page;   

	if(!task)       // can't get target process's task_struct
    {
        return 0;
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
                        new_pte = swp_entry_to_pte(new_entry);
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
						//if(!is_swap_pte(*orig_pte))
						//	printk("ksg: already swapin not swap entry");
						set_pte(orig_pte, new_pte);
						unlock_page(page);
						pte_unmap_unlock(orig_pte, ptl);

					}
				}
			}
		}
	}

    
	free_pages((unsigned long)(page_address(page)), 0);
	return 0;
}


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

					}
				}
			}
		}
	}

	return 0;
}




int backgrounded_uid;

int backgrounded_uid_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{

	
	struct task_struct *p;
	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	if(rc)
		return rc;
	if(write){
		rcu_read_lock();
		for_each_process(p){

			if(!p)
				continue;

			if(p->cred->uid.val==backgrounded_uid){
				task_swap_counter_inc(p);
				cold_page_sender(p);
			}


		}
		rcu_read_unlock();
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

	printk("pid %d: counter 0 = %d",pid,num[0]);
	printk("pid %d: counter 1 = %d",pid,num[1]);
	printk("pid %d: counter 2 = %d",pid,num[2]);
	printk("pid %d: counter 3 = %d",pid,num[3]);
	printk("pid %d: counter 4 = %d",pid,num[4]);
	printk("pid %d: counter 5 = %d",pid,num[5]);
	printk("pid %d: counter >5 = %d",pid,num[6]);

	}
	return 0;
}




#endif

