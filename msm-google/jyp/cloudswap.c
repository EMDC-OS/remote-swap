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
#include <linux/wait.h>
#include <linux/freezer.h>
#include <linux/blkdev.h>
#include <linux/time.h>


#include <asm/io.h>
#include <asm/mmu_context.h>
#include <asm/pgalloc.h>
#include <linux/uaccess.h>
#include <asm/tlb.h>
#include <asm/tlbflush.h>
#include <asm/pgtable.h>
#include <asm/delay.h>


#ifdef CONFIG_APP_AWARE
#include <linux/kernel.h>
#include <linux/app_aware.h>
#endif

#ifdef CONFIG_APP_AWARE


int cloudswap_on;
int cloudswap_fault;
int target_tgid;


static int cloud_fault_target_page(pid_t tgid, unsigned long va){


	struct task_struct  *task = NULL;
	struct mm_struct *mm = NULL;
	struct vm_area_struct *vma = NULL;
	pgd_t *pgd;
	pud_t *pud;
	pmd_t *pmd;
	pte_t *pte;
	int ret;

	rcu_read_lock();
	task = find_task_by_vpid(tgid);
	rcu_read_unlock();


	if(!task)     
    {
	//	printk(KERN_ERR "[REMOTE %s] task is NULL \n", __func__);
        return 0;
    }
    
					
//	trace_printk("miss handling start %d %llx\n", tgid, va);
        
	if(task->mm && task->mm->mmap) 
    {

	mm = task->mm ;
	vma = find_vma(mm,va);
	pgd = pgd_offset(mm, va);
	if (!pgd_none(*pgd) && !pgd_bad(*pgd)) {
		pud = pud_offset(pgd, va);
		if (!pud_none(*pud) && !pud_bad(*pud)) {
			pmd = pmd_offset(pud, va);
			if (!pmd_none(*pmd) && !pmd_bad(*pmd)) {
				pte = pte_offset_map(pmd, va);
				if(pte_present(*pte))
				{

	//				trace_printk("miss handling pte present %d %llx\n", tgid, va);

					return 0;
				}
                if(is_swap_pte(*pte))    
                {
                    swp_entry_t entry = pte_to_swp_entry(*pte); 
					
	//				trace_printk("miss handling swap pte %d %llx, type %d\n", tgid, va, swp_type(entry));
					if(non_swap_entry(entry))
                    {
                       return 0;
                    }
                    if(__swp_swapcount(entry) != 1) {
                        return 0;
                    }
                    else                    // page is swapped and swap entry.
                    {
						if(swp_type(entry) == ZRAM_TYPE)   
						{
							                                  
							unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
							if (!down_read_trylock(&mm->mmap_sem)) {
retry:
								down_read(&mm->mmap_sem);
							} else {
								/*
								 * The above down_read_trylock() might have succeeded in which
								 * case, we'll have missed the might_sleep() from down_read().
								 */
								might_sleep();
							}
							cloudswap_fault=1;
							ret = handle_mm_fault(vma, va, flags);
							cloudswap_fault=0;

							if (ret & VM_FAULT_RETRY) {
								/*
								 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
								 * starvation.
								 */
								if (flags & FAULT_FLAG_ALLOW_RETRY) {
									flags &= ~FAULT_FLAG_ALLOW_RETRY;
									flags |= FAULT_FLAG_TRIED;
									goto retry;
								}
							}
							up_read(&mm->mmap_sem);
						}
					}

				}
				pte_unmap(pte);
			}
		}
	}       


	}
	return 0;
}


static int _cloud_send_target_page(unsigned int id, pte_t *pte, pmd_t *pmd, unsigned long vpage, struct mm_struct *mm, bool is_after){

				
	pte_t *orig_pte;
	spinlock_t *ptl;
	swp_entry_t entry = pte_to_swp_entry(*pte);
	struct page *cache_page;
    struct page *page; 


	struct address_space *mapping;
	swp_entry_t new_entry;
	pte_t new_pte;
	int ret;
	cache_page = find_get_page(swap_address_space(entry), swp_offset(entry));
	if(cache_page){
		/*
		 * Continue for now, but should delete swap cache and resume
		 *
		*/
		return 0;
	}
	page = alloc_pages(GFP_KERNEL, 0);
	//SetPageUnevictable(page);
					
	//trace_printk(KERN_ERR "[REMOTE %s] alloc page %llx\n", __func__,page_to_pfn(page));

	new_entry = get_swap_page_of_id(id+(__NR_APPIDS+1)*is_after);
	new_pte = swp_entry_and_appid_nbd_to_pte(new_entry,id);
	//if Prefetch target, type==NBD_TYPE && counter(id)==id
	lock_page(page);
	__SetPageSwapBacked(page);
	ClearPageUptodate(page);

	set_page_private(page, entry.val);
	swap_readpage(page, true);
	if (!page) {
		/*
		 * Back out if somebody else faulted in this pte
		 * while we released the pte lock.
		*/
		orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);
		goto unlock;
	}

	lock_page(page);
	add_to_swap_cache(page, new_entry,
			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
	
	set_page_dirty(page);
	mapping = page_mapping(page);
	page->mapping = mapping;
	
	
	write_one_page(page);
	delete_from_swap_cache(page);
	
	orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);

	if (unlikely(!pte_same(*pte, *orig_pte))){
		/*
		 * Back out if somebody else faulted in this pte
		 * while we released the pte lock.
		*/
		printk(KERN_ERR "[REMOTE %s] somebody faulted\n", __func__);
		swap_free(new_entry);
		ret=0;
		goto unlock;
	}
	
	set_pte(orig_pte, new_pte);
	if(mm && mm->owner)
		trace_printk("target sent id %d: cluster %d, type %d %d %llx %llx\n",id,id+(__NR_APPIDS+1)*is_after,swp_type(new_entry),mm->owner->tgid, vpage, swp_offset(new_entry));
	swap_free(entry);
	ret=1;
unlock:
	pte_unmap_unlock(orig_pte, ptl);
//	printk(KERN_ERR "[REMOTE %s] free page %llx\n", __func__,(unsigned long)page_address(page));
	page->mapping = NULL;
	//free_page((unsigned long)(page_address(page)));								
	__free_page(page);



	return ret;
}





unsigned int global_id;

static int cloud_send_target_page(pid_t tgid, unsigned long va){

       

	struct task_struct  *task = NULL;
	struct mm_struct *mm = NULL;
	pgd_t *pgd;
	pud_t *pud;
	pmd_t *pmd;
	pte_t *pte;
	struct page *cache_page;
									
	rcu_read_lock();
	task = find_task_by_vpid(tgid);
	rcu_read_unlock();

	if(!task)     
    {
		//printk(KERN_ERR "[REMOTE %s] task is NULL \n", __func__);
        return 0;
    }


	if(task->mm && task->mm->mmap) 
    {


	mm = task->mm ;
	pgd = pgd_offset(mm, va);
	if (!pgd_none(*pgd) && !pgd_bad(*pgd)) {
		pud = pud_offset(pgd, va);
		if (!pud_none(*pud) && !pud_bad(*pud)) {
			pmd = pmd_offset(pud, va);
			if (!pmd_none(*pmd) && !pmd_bad(*pmd)) {
				pte = pte_offset_map(pmd, va);
				if(!pte || pte_none(*pte))
				{
					return 0;
				}
                if(is_swap_pte(*pte))    
                {
                    swp_entry_t entry = pte_to_swp_entry(*pte); 
					if(non_swap_entry(entry))
                    {
                       return 0;
                    }
                    if(__swp_swapcount(entry) != 1) {
				
                        return 0;
                    }
                    else                    // page is swapped and swap entry.
                    {
						if(swp_type(entry) == ZRAM_TYPE )   
						{
							cache_page = find_get_page(swap_address_space(entry), swp_offset(entry)); 
							if(!cache_page)       // can't find the page from cache
							{

								unsigned int id=(global_id++)%15;
								if(_cloud_send_target_page(id, pte, pmd, va, mm, 0)){
									
									pte_unmap(pte);
									return 1;

								}
								else
									trace_printk("[REMOTE %s] _send_target_page_failed\n", __func__);

						

							}
						}
					}
				}
				pte_unmap(pte);
			}
		}
	}      


	}
	return 0;
}


static int _cloud_send_target_page_to_flash(pte_t *pte, pmd_t *pmd, unsigned long vpage, struct mm_struct *mm){

				
	pte_t *orig_pte;
	spinlock_t *ptl;
	swp_entry_t entry = pte_to_swp_entry(*pte);
	struct page *cache_page;
    struct page *page; 


	struct address_space *mapping;
	swp_entry_t new_entry;
	pte_t new_pte;
	int ret;
	cache_page = find_get_page(swap_address_space(entry), swp_offset(entry));
	if(cache_page){
						
		/*
		 * Continue for now, but should delete swap cache and resume
		 *
		*/
		return 0;
	}
	page = alloc_pages(GFP_KERNEL, 0);
	//SetPageUnevictable(page);
					
	//trace_printk(KERN_ERR "[REMOTE %s] alloc page %llx\n", __func__,page_to_pfn(page));

	new_entry = get_swap_page_of_type(FLASH_TYPE);
	new_pte = swp_entry_to_pte(new_entry);
	lock_page(page);
	__SetPageSwapBacked(page);
	ClearPageUptodate(page);

	set_page_private(page, entry.val);
	swap_readpage(page, true);
	if (!page) {
		/*
		 * Back out if somebody else faulted in this pte
		 * while we released the pte lock.
		*/
		orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);
		goto unlock;
	}

	lock_page(page);
	add_to_swap_cache(page, new_entry,
			__GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN);
	
	set_page_dirty(page);
	mapping = page_mapping(page);
	page->mapping = mapping;
	
	
	write_one_page(page);
	delete_from_swap_cache(page);
	
	orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);

	if (unlikely(!pte_same(*pte, *orig_pte))){
		/*
		 * Back out if somebody else faulted in this pte
		 * while we released the pte lock.
		*/
		printk(KERN_ERR "[REMOTE %s] somebody faulted\n", __func__);
		swap_free(new_entry);
		ret=0;
		goto unlock;
	}
	
	set_pte(orig_pte, new_pte);
	if(mm && mm->owner)
		trace_printk("flash sent %d %llx type %d %llx\n",mm->owner->tgid, vpage, swp_type(new_entry), swp_offset(new_entry));
	swap_free(entry);
	ret=1;
unlock:
	pte_unmap_unlock(orig_pte, ptl);
//	printk(KERN_ERR "[REMOTE %s] free page %llx\n", __func__,(unsigned long)page_address(page));
	page->mapping = NULL;
	//free_page((unsigned long)(page_address(page)));								
	__free_page(page);



	return ret;
}




static int cloud_send_target_page_to_flash(pid_t tgid, unsigned long va){

       

	struct task_struct  *task = NULL;
	struct mm_struct *mm = NULL;
	pgd_t *pgd;
	pud_t *pud;
	pmd_t *pmd;
	pte_t *pte;
	struct page *cache_page;
									
	rcu_read_lock();
	task = find_task_by_vpid(tgid);
	rcu_read_unlock();


	//trace_printk("%d %llx\n",tgid,va);
	if(!task)     
    {
		//printk(KERN_ERR "[REMOTE %s] task is NULL \n", __func__);
        return 0;
    }


	if(task->mm && task->mm->mmap) 
    {

					
	trace_printk("%d %llx\n",tgid,va);

	mm = task->mm ;
	pgd = pgd_offset(mm, va);
	if (!pgd_none(*pgd) && !pgd_bad(*pgd)) {
		pud = pud_offset(pgd, va);
		if (!pud_none(*pud) && !pud_bad(*pud)) {
			pmd = pmd_offset(pud, va);
			if (!pmd_none(*pmd) && !pmd_bad(*pmd)) {
				pte = pte_offset_map(pmd, va);
				if(!pte || pte_none(*pte))
				{
					return 0;
				}
                if(is_swap_pte(*pte))    
                {
						
                    swp_entry_t entry = pte_to_swp_entry(*pte); 
					trace_printk("swap_pte %d %llx\n",tgid,va);
					if(non_swap_entry(entry))
                    {
	
			
                       return 0;
                    }
                    if(__swp_swapcount(entry) != 1) {
						
						trace_printk("swpcount %d %llx\n",tgid,va);
				
                        return 0;
                    }
                    else                    // page is swapped and swap entry.
                    {
						if(swp_type(entry) == ZRAM_TYPE )   
						{
							cache_page = find_get_page(swap_address_space(entry), swp_offset(entry)); 
							if(!cache_page)       // can't find the page from cache
							{

								if(_cloud_send_target_page_to_flash(pte, pmd, va, mm)){
									
									pte_unmap(pte);
									return 1;

								}
								else
									trace_printk("[REMOTE %s] _send_target_page_failed\n", __func__);


							}
						}
					}
				}
				pte_unmap(pte);
			}
		}
	}      


	}
	return 0;
}


static void cs_flash_work(struct work_struct *work){

	struct cs_work *tew;
	pid_t tgid;
	unsigned long va;
	tew=container_of(work, struct cs_work, work);
	tgid=tew->tgid;
	va=tew->va;
		
	cloud_send_target_page_to_flash(tgid, va);

	kfree(tew);
}


void cs_flash_handler(pid_t tgid, unsigned long va)
{

	struct cs_work *tew;

	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;
	INIT_WORK(&tew->work, cs_flash_work);
	tew->tgid=tgid;
	tew->va=va;

	schedule_work(&tew->work); 
}


static void cs_nbd_work(struct work_struct *work){

	struct cs_work *tew;
	pid_t tgid;
	unsigned long va;
	tew=container_of(work, struct cs_work, work);
	tgid=tew->tgid;
	va=tew->va;
		
	cloud_send_target_page(tgid, va);

	kfree(tew);
}


void cs_nbd_handler(pid_t tgid, unsigned long va)
{

	struct cs_work *tew;

	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;
	INIT_WORK(&tew->work, cs_nbd_work);
	tew->tgid=tgid;
	tew->va=va;

	schedule_work(&tew->work); 
}


static void cs_memory_work(struct work_struct *work){

	struct cs_work *tew;
	pid_t tgid;
	unsigned long va;
	tew=container_of(work, struct cs_work, work);
	tgid=tew->tgid;
	va=tew->va;
		
	cloud_fault_target_page(tgid, va);

	kfree(tew);
}


void cs_memory_handler(pid_t tgid, unsigned long va)
{

	struct cs_work *tew;

	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;
	INIT_WORK(&tew->work, cs_memory_work);
	tew->tgid=tgid;
	tew->va=va;

	schedule_work(&tew->work); 
}



/* APIs for pages in ZRAM */


unsigned long send_to_flash;

int send_to_flash_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{
	int rc = proc_doulongvec_minmax(table,write,buffer,length,ppos);

	if(rc)
		return rc;
	if(write){
		cs_flash_handler(target_tgid, send_to_flash);
	}

	return 0;
}


unsigned long send_to_nbd;

int send_to_nbd_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{
	int rc = proc_doulongvec_minmax(table,write,buffer,length,ppos);

	if(rc)
		return rc;
	if(write){
		cs_nbd_handler(target_tgid, send_to_nbd);
	}

	return 0;
}


unsigned long send_to_memory;

int send_to_memory_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{
	int rc = proc_doulongvec_minmax(table,write,buffer,length,ppos);

	if(rc)
		return rc;
	if(write){
		cs_memory_handler(target_tgid, send_to_memory);
	}

	return 0;
}

int fault_all_zram_page;

int fault_all_zram_page_handler(struct ctl_table *table, int write,
	void __user *buffer, size_t *length, loff_t *ppos) {

        int rc;

	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
	if (rc)
		return rc;

	if (write) {
	
		pid_t pid = fault_all_zram_page;
		struct task_struct *task = find_task_by_vpid(pid);
        unsigned long vpage;
        int idx;
	int ret;
                
        struct vm_area_struct *vma;
        if (!task) {
                printk("task %d not found", pid);
                return 1;
        }
        if (task->mm && task->mm->mmap) {
                for (vma = task->mm->mmap; vma; vma = vma->vm_next) {
                        for (vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx++) {
                                pgd_t *pgd;
                                pud_t *pud;
                                pmd_t *pmd;
                                pte_t *pte;
                                struct mm_struct *mm = task->mm;

                                // page table walk
                                pgd = pgd_offset(mm, vpage);
                                if (pgd_none(*pgd)) continue;

                                pud = pud_offset(pgd, vpage);
                                if (pud_none(*pud)) continue;

                                pmd = pmd_offset(pud, vpage);
                                if (pmd_none(*pmd)) continue;

                                pte = pte_offset_kernel(pmd, vpage);
                                
								if(pte_present(*pte))
				{

	//				trace_printk("miss handling pte present %d %llx\n", tgid, va);

					continue;
				}
                if(is_swap_pte(*pte))    
                {
                    swp_entry_t entry = pte_to_swp_entry(*pte); 
					
	//				trace_printk("miss handling swap pte %d %llx \n", pid, vpage);
					if(non_swap_entry(entry))
                    {
                       continue;
                    }
                    else                    // page is swapped and swap entry.
                    {
						if(swp_type(entry) == ZRAM_TYPE)   
						{
							                                  
							unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
							if (!down_read_trylock(&mm->mmap_sem)) {
retry:
								down_read(&mm->mmap_sem);
							} else {
								/*
								 * The above down_read_trylock() might have succeeded in which
								 * case, we'll have missed the might_sleep() from down_read().
								 */
								might_sleep();
							}

							cloudswap_fault=1;
							ret = handle_mm_fault(vma, vpage, flags);
							cloudswap_fault=0;

							if (ret & VM_FAULT_RETRY) {
								/*
								 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
								 * starvation.
								 */
								if (flags & FAULT_FLAG_ALLOW_RETRY) {
									flags &= ~FAULT_FLAG_ALLOW_RETRY;
									flags |= FAULT_FLAG_TRIED;
									goto retry;
								}
							}
							up_read(&mm->mmap_sem);
						}
					}

				}



	                        }
                }
        }




        }

	return 0;
}




#endif
