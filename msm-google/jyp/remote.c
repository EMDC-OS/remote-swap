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

#define MANAGER_PERIOD (10*HZ)
#define ALARM_PERIOD (150*HZ)
#define SYSTEMWIDE_COLD_PERIOD (600*HZ)

#define TRUE 1
#define FALSE 0


bool switch_start;
bool switch_after;
bool miss_handling;
bool zram_full;


struct per_app_swap_trace *past[__NR_APPIDS]; //__NR_APPIDS

int cold_page_threshold;
int stop_background_io;
int prefetch_batch_size;
int prefetch_percentage;
int current_app_state;

int backgrounded_uid;
int nbd_client_pid;

//for debugging
atomic_t sent_cold_page;
atomic_t sent_sys_cold_page;
atomic_t faulted_cold_page;
atomic_t faulted_sys_cold_page;
atomic_t excepted_page;
atomic_t nbd_direct_page;


//for debugging (at every launch)
atomic_t switch_app_cold_page;
atomic_t after_app_cold_page;
atomic_t switch_sys_cold_page;
atomic_t after_sys_cold_page;
atomic_t switch_prefetch_hit;
atomic_t switch_prefetch_fault;
atomic_t after_prefetch_hit;
atomic_t after_prefetch_fault;
atomic_t prefetch_miss;
atomic_t unprefetched_prefetch_miss;
atomic_t direct_fault;
atomic_t switch_exception_fault;
atomic_t after_exception_fault;


int prefetch_on;
int launchtime_before;
int sys_cold_handler_off;

struct task_struct *preempted_cold_task;

struct perapp_cluster pac[2*__NR_APPIDS+1]; // 2 * __NR_APPIDS + 1
struct task_struct *send_target_manager_thread;
struct task_struct *send_target_alarm_thread;
struct task_struct *sys_cold_counter_thread;
static DECLARE_WAIT_QUEUE_HEAD(send_target_manager_wait);
//static DECLARE_WAIT_QUEUE_HEAD(send_target_alarm_wait);

DEFINE_SPINLOCK(stm_wait_cond_lock);
DEFINE_SPINLOCK(which_table_lock);
DEFINE_SPINLOCK(switch_start_lock);

bool stm_wait_cond;

unsigned int get_id_from_uid(int uid){

	switch(uid){
		case MAPS_UID: return MAPS_ID;
		case YT_UID: return YT_ID;
		case IG_UID: return IG_ID;
		case TW_UID: return TW_ID;
		case CC_UID: return CC_ID;
		case AB_UID: return AB_ID;
		case FB_UID: return FB_ID;
		case CR_UID: return CR_ID;
		case MAIL_UID: return MAIL_ID;
		case CH_UID: return CH_ID;
		case IV_UID: return IV_ID;
		case CN_UID: return CN_ID;
//		case SP_UID: return SP_ID;
//		case MX_UID: return MX_ID;
//		case KT_UID: return KT_ID;
//		case PG_UID: return PG_ID;
//		case DB_UID: return DB_ID;
//		case TWCH_UID: return TWCH_ID;
//		case WV_UID: return WV_ID;
//		case GL_UID: return GL_ID;
		case -1: return COLD_ID;
		default:
			panic("[REMOTE %s] unregistered UID %d\n", __func__,uid);
			return -1;
	}

}

bool is_system_uid(int uid){
	switch(uid){
		case MAPS_UID: return 0;
		case YT_UID: return 0;
		case IG_UID: return 0;
		case TW_UID: return 0;
		case CC_UID: return 0;
		case AB_UID: return 0;
		case FB_UID: return 0;
		case CR_UID: return 0;
		case MAIL_UID: return 0;
		case CH_UID: return 0;
		case IV_UID: return 0;
		case CN_UID: return 0;
//		case SP_UID: return 0;
//		case MX_UID: return 0;
//		case KT_UID: return 0;
//		case PG_UID: return 0;
//		case DB_UID: return 0;
//		case TWCH_UID: return 0;
//		case WV_UID: return 0;
//		case GL_UID: return 0;
		default:
			return 1;
		
	}
}

void wake_up_send_target_manager(void)
{

	unsigned long flags;

	spin_lock_irqsave(&stm_wait_cond_lock,flags);
	stm_wait_cond = TRUE;
	spin_unlock_irqrestore(&stm_wait_cond_lock,flags);



	wake_up_interruptible(&send_target_manager_wait);
	return;
}



static int _send_target_page(unsigned int id, pte_t *pte, pmd_t *pmd, unsigned long vpage, struct mm_struct *mm, bool is_after){



				
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
		trace_printk("target sent id %d: cluster %d, %d %llx %llx\n",id,id+(__NR_APPIDS+1)*is_after,mm->owner->tgid, vpage, swp_offset(new_entry));
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
				if(!mm)
					return ;
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
						continue;
					}
					if(swp_type(entry) == NBD_TYPE)
						continue;
					counter = pte_to_swp_counter_zram(*pte);
					if(__swp_swapcount(entry) != 1 || counter <= cold_page_threshold) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{
	

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
							//delete_from_swap_cache(cache_page);
						//	trace_printk(KERN_ERR "[REMOTE %s] delete cache page and cold send \n", __func__);
							continue;
						}
						page = alloc_pages(GFP_KERNEL, 0);
						//SetPageUnevictable(page);
						
	
						//trace_printk(KERN_ERR "[REMOTE %s] alloc page %llx\n", __func__,page_to_pfn(page));

						new_entry = get_swap_page_of_id(COLD_ID); // cold page

						new_pte = swp_entry_and_appid_nbd_to_pte(new_entry,COLD_ID);
						//if COLD, type==NBD_TYPE && counter(id)==COLD_ID (cold id)


						
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
						ret=add_to_swap_cache(page, new_entry,
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
							goto unlock;
						}
						
						//trace_printk("cold page uid %d tgid %d \"%s\" %lx offset %llx\n",task->cred->uid.val,task->tgid,task->comm,vpage,swp_offset(new_entry));	
						set_pte(orig_pte, new_pte);
						swap_free(entry);
						cnt++;
unlock:
						pte_unmap_unlock(orig_pte, ptl);
//						printk(KERN_ERR "[REMOTE %s] free page %llx\n", __func__,(unsigned long)page_address(page));
	
						page->mapping = NULL;
						//free_page((unsigned long)(page_address(page)));
						__free_page(page);
						if(switch_start || stop_background_io){
							trace_printk(KERN_ERR "[REMOTE %s] switch started during cold work. preempted! \n", __func__);
							atomic_add(cnt, &sent_cold_page);
							kfree(tew);
							preempted_cold_task = task ;
							return;
						}
						
					}
				}
			}
		}
	}
						
	atomic_add(cnt,&sent_cold_page);

	trace_printk("remote: total sent cold page: %d\n", sent_cold_page);
	trace_printk("remote: total faulted cold page: %d\n", faulted_cold_page);
	kfree(tew);

	if(task == preempted_cold_task)
		preempted_cold_task = NULL;

}



/*
 * Send Cold Pages to NBD (System-wide)
 *
 */
static void sys_cold_page_sender_work(struct work_struct *work)
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
					if(non_swap_entry(entry))
					{
						continue;
					}
					if(swp_type(entry) == NBD_TYPE)
						continue;
					
					counter = pte_to_swp_counter_zram(*pte);
					if(__swp_swapcount(entry) != 1 || counter <= SYS_COLD_PAGE_THRESHOLD) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{
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
							//delete_from_swap_cache(cache_page);
						//	trace_printk(KERN_ERR "[REMOTE %s] delete cache page and cold send \n", __func__);
							continue;
						}
						page = alloc_pages(GFP_KERNEL, 0);
						//SetPageUnevictable(page);
						
	
						//trace_printk(KERN_ERR "[REMOTE %s] alloc page %llx\n", __func__,page_to_pfn(page));

						new_entry = get_swap_page_of_id(COLD_ID); // cold page

						new_pte = swp_entry_and_appid_nbd_to_pte(new_entry,SYS_COLD_ID);
						//if COLD, type==NBD_TYPE && counter(id)==COLD_ID (cold id)


						
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
						ret=add_to_swap_cache(page, new_entry,
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
							goto unlock;
						}
						
						
						//trace_printk("sys cold page uid %d tgid %d \"%s\" %lx offset %llx\n",task->cred->uid.val, task->tgid, task->comm, vpage, swp_offset(new_entry));	
						set_pte(orig_pte, new_pte);
						swap_free(entry);
						cnt++;
unlock:
						pte_unmap_unlock(orig_pte, ptl);
//						printk(KERN_ERR "[REMOTE %s] free page %llx\n", __func__,(unsigned long)page_address(page));
	
						page->mapping = NULL;
						//free_page((unsigned long)(page_address(page)));
						__free_page(page);

						if(switch_start || stop_background_io){
							trace_printk(KERN_ERR "[REMOTE %s] switch started during system cold work. preempted! \n", __func__);
							atomic_add(cnt, &sent_cold_page);
							atomic_add(cnt, &sent_sys_cold_page);
							kfree(tew);
							return;
						}
						
					}
				}
			}
		}
	}
						
	atomic_add(cnt,&sent_cold_page);
	atomic_add(cnt,&sent_sys_cold_page);

	trace_printk("remote: tgid %d system cold page %d out\n",task->tgid,cnt);
	//trace_printk("remote: total sent cold page: %d\n", sent_cold_page);
	//trace_printk("remote: total faulted cold page: %d\n", faulted_cold_page);
	kfree(tew);

	//preempted_cold_task = NULL;

}








static int fault_target_page(pid_t tgid, unsigned long va){


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
						if(swp_type(entry) == NBD_TYPE)   
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

							ret = handle_mm_fault(vma, va, flags);

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




static struct page *prefetch_target_page(int id, pid_t tgid, unsigned long va){


	struct task_struct  *task = NULL;
	struct mm_struct *mm = NULL;
	struct vm_area_struct *vma = NULL;
	pgd_t *pgd;
	pud_t *pud;
	pmd_t *pmd;
	pte_t *pte;
	struct page *page;
	bool page_allocated;
	gfp_t gfp_mask = GFP_HIGHUSER_MOVABLE;

	//trace_printk("prefetch_target_page %d %llx\n",tgid,va);
	rcu_read_lock();
	task = find_task_by_vpid(tgid);
	rcu_read_unlock();

	if(!task)     
    {
	//	printk(KERN_ERR "[REMOTE %s] task is NULL \n", __func__);
        return 0;
    }
    
        
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
						if(swp_type(entry) == NBD_TYPE)   
						{
							page = __read_swap_cache_async(entry, gfp_mask, vma,
									va, &page_allocated);
							if (!page){
								pte_unmap(pte);
								return 0;
							}

							if (page_allocated) {
								swap_readpage(page, false);
								SetPageReadahead(page);
	
								//trace_printk("prefetch done id %d: %d %lx %lx\n", id, tgid, va, swp_offset(entry) );
							}
							else
								trace_printk("page not allocated\n");
								
							put_page(page);
						}
					}
			
				}
				pte_unmap(pte);
			}
		}
	}       



	}


	return page;
}

struct blk_plug plugs[150];

static void prefetch_work(struct work_struct *work)
{

	struct prefetch_work *tew;
	int max_idx_l;
	int max_idx_e;
	int after_idx_e;
	int after_idx_l;
	struct swap_trace_entry *swap_trace_table_l;
	struct swap_trace_entry *swap_trace_table_e;
	pid_t tgid;
	unsigned long va;
//	struct blk_plug plug;
	int plug_id=0;
//	struct blk_plug plug_after;
	int i;
	int cnt=0;
	unsigned int id;
	int target_table;
	struct page* last_page;
	struct page* wait_page;
	tew = container_of(work, struct prefetch_work, work);
	target_table = tew->target_table;
	id = tew->id;

//	trace_printk("1!!\n");
	if(target_table){
		max_idx_e = atomic_read(&past[id]->st_index0);
		swap_trace_table_e = past[id]->swap_trace_table0;
		max_idx_l = atomic_read(&past[id]->st_index1);
		swap_trace_table_l = past[id]->swap_trace_table1;
		after_idx_e = atomic_read(&past[id]->after_index0);
		after_idx_l = atomic_read(&past[id]->after_index1);
	}
	else{
		max_idx_e = atomic_read(&past[id]->st_index1);
		swap_trace_table_e = past[id]->swap_trace_table1;
		max_idx_l = atomic_read(&past[id]->st_index0);
		swap_trace_table_l = past[id]->swap_trace_table0;
		after_idx_e = atomic_read(&past[id]->after_index1);
		after_idx_l = atomic_read(&past[id]->after_index0);
	}


	trace_printk("prefetch work: foreground %d, maxidx %d, afteridx %d\n",foreground_uid,max_idx_l,after_idx_l);

	cnt=0;
	last_page=0;
	wait_page=0;
	
	
	blk_start_plug(&plugs[plug_id]);
//	printk(KERN_ERR"blk start %d\n",plug_id);
	//trace_printk("blk start %d\n",plug_id);
	for( i = 0 ; i <= max_idx_l ; i++ ){
		
		
		if(swap_trace_table_l[i].to_nbd && swap_trace_table_l[i].swapped){
//			trace_printk("prefetch table %d %d %d\n",target_table, i, cnt);
			tgid = swap_trace_table_l[i].tgid;
			va = swap_trace_table_l[i].va;
			last_page=prefetch_target_page(id,tgid,va);
			if(last_page){
				wait_page=last_page;
				cnt++;
			}
		}
			
	//	printk(KERN_ERR"i, cnt: %d / %d, %d\n",i,max_idx_l,cnt);
		
		if(( cnt == prefetch_batch_size || i == max_idx_l ) && wait_page){
	
	//		printk(KERN_ERR"blk finish %d\n",plug_id);
			blk_finish_plug(&plugs[plug_id]);
			
	//		trace_printk("blk finish %d\n",plug_id);
			//printk(KERN_ERR"refcount %d",wait_page->_refcount);
				
			get_page(wait_page);
			//trace_printk("wait start %d\n",plug_id);
			wait_on_page_locked(wait_page);
			//trace_printk("wait finished %d\n",plug_id);
			put_page(wait_page);
			
			if(cnt==prefetch_batch_size){
				plug_id++;
	//			printk(KERN_ERR"blk start %d\n",plug_id);
			//	trace_printk("blk start %d\n",plug_id);
				cnt=0;
				blk_start_plug(&plugs[plug_id]);
				wait_page=0;
			}
		}
	}
	if(max_idx_l==-1 || wait_page==0){
			
	//	printk(KERN_ERR"blk finish %d\n",plug_id);
		blk_finish_plug(&plugs[plug_id]);
//		trace_printk("blk finish %d\n",plug_id);
	}


//after


	cnt=0;
	last_page=0;
	wait_page=0;
	
	
	blk_start_plug(&plugs[plug_id]);
	//trace_printk("blk start %d\n",plug_id);
	for( i = max_idx_l + 1 ; i <= after_idx_l ; i++ ){
		
		
		if(swap_trace_table_l[i].to_nbd && swap_trace_table_l[i].swapped){
			tgid = swap_trace_table_l[i].tgid;
			va = swap_trace_table_l[i].va;
			last_page=prefetch_target_page(id,tgid,va);
			if(last_page){
				wait_page=last_page;
				cnt++;
			}
		}
		
		if(( cnt == prefetch_batch_size || i == after_idx_l ) && wait_page){
	
			blk_finish_plug(&plugs[plug_id]);
			
			get_page(wait_page);
			//trace_printk("wait start %d\n",plug_id);
			wait_on_page_locked(wait_page);
			//trace_printk("wait finished %d\n",plug_id);
			put_page(wait_page);
			
			if(cnt==prefetch_batch_size){
				plug_id++;
				//trace_printk("blk start %d\n",plug_id);
				cnt=0;
				blk_start_plug(&plugs[plug_id]);
				wait_page=0;
			}
		}
	}
	if(after_idx_l<=max_idx_l || wait_page==0){
			
		blk_finish_plug(&plugs[plug_id]);
	}







//	blk_finish_plug(&plug);
	


/*
	i=0;
	cnt=0;
	last_page=0;
	wait_page=0;
	plug_id=0;
	blk_start_plug(&plug);

	for( i = 0 ; i <= max_idx_l ; i++ ){
		//trace_printk("prefetch table %d: %d %llx, %d %d\n",target_table,swap_trace_table_l[i].tgid,swap_trace_table_l[i].va,swap_trace_table_l[i].to_nbd,swap_trace_table_l[i].swapped);
		if(swap_trace_table_l[i].to_nbd && swap_trace_table_l[i].swapped){
			tgid = swap_trace_table_l[i].tgid;
			va = swap_trace_table_l[i].va;
			prefetch_target_page(id,tgid,va);
		}
	}
	blk_finish_plug(&plug);
*/

	//printk(KERN_ERR "4!!\n");
/*
	blk_start_plug(&plug_after);
	for( i = max_idx_l + 1; i <= after_idx_l; i++ ){
		if(swap_trace_table_l[i].to_nbd && swap_trace_table_l[i].swapped){
			tgid = swap_trace_table_l[i].tgid;
			va = swap_trace_table_l[i].va;
			prefetch_target_page(id,tgid,va);
		}
	}

	blk_finish_plug(&plug_after);
*/
	
	lru_add_drain();

	kfree(tew);
}

void print_debug_vars(int id){

	trace_printk("switch app cold fault id %d: %d\n", id, atomic_read(&switch_app_cold_page));
	trace_printk("after app cold fault id %d: %d\n", id, atomic_read(&after_app_cold_page));
	trace_printk("switch sys cold fault id %d: %d\n", id, atomic_read(&switch_sys_cold_page));
	trace_printk("after sys cold fault id %d: %d\n", id, atomic_read(&after_sys_cold_page));
	trace_printk("switch prefetch hit id %d: %d\n", id, atomic_read(&switch_prefetch_hit));
	trace_printk("switch prefetch fault id %d: %d\n", id, atomic_read(&switch_prefetch_fault));
	trace_printk("after prefetch hit id %d: %d\n", id, atomic_read(&after_prefetch_hit));
	trace_printk("after prefetch fault id %d: %d\n", id, atomic_read(&after_prefetch_fault));
	trace_printk("prefetch miss id %d: %d\n", id, atomic_read(&prefetch_miss));
	trace_printk("unprefetched prefetch miss id %d: %d\n", id, atomic_read(&unprefetched_prefetch_miss));
	trace_printk("direct fault id %d: %d\n", id, atomic_read(&direct_fault));
	trace_printk("switch Exception fault id %d: %d\n", id, atomic_read(&switch_exception_fault));
	trace_printk("after Exception fault id %d: %d\n", id, atomic_read(&after_exception_fault));

}


static void miss_page_work(struct work_struct *work)
{

	struct miss_page_work *tew;
	int max_idx_l;
	int max_idx_e;
	int after_idx_l;
	int after_idx_e;
	struct swap_trace_entry *swap_trace_table_l;
	struct swap_trace_entry *swap_trace_table_e;
	pid_t tgid;
	unsigned long va;
	int i;
	unsigned int id;
	int target_table;
	tew = container_of(work, struct miss_page_work, work);
	target_table = tew->target_table;
	id = tew->id;
	
	if(target_table){
		max_idx_e = atomic_read(&past[id]->st_index0);
		swap_trace_table_e = past[id]->swap_trace_table0;
		max_idx_l = atomic_read(&past[id]->st_index1);
		swap_trace_table_l = past[id]->swap_trace_table1;
		after_idx_e = atomic_read(&past[id]->after_index0);
		after_idx_l = atomic_read(&past[id]->after_index1);
	}
	else{
		max_idx_e = atomic_read(&past[id]->st_index1);
		swap_trace_table_e = past[id]->swap_trace_table1;
		max_idx_l = atomic_read(&past[id]->st_index0);
		swap_trace_table_l = past[id]->swap_trace_table0;
		after_idx_e = atomic_read(&past[id]->after_index1);
		after_idx_l = atomic_read(&past[id]->after_index0);
	}

	trace_printk("miss work: foreground %d, maxidx %d, afteridx %d\n",foreground_uid,max_idx_l,after_idx_l);
//	blk_start_plug(&plug);
	for( i = 0 ; i <= after_idx_l ; i++ ){
		if(swap_trace_table_l[i].to_nbd && swap_trace_table_l[i].swapped ) // && swapped
		{
			tgid = swap_trace_table_l[i].tgid;
			va = swap_trace_table_l[i].va;
			fault_target_page(tgid,va);
		}
	}


//	blk_finish_plug(&plug);
	lru_add_drain();

	print_debug_vars(id);

	miss_handling = 0;
	kfree(tew);
}





void prefetch_handler(unsigned int id, int target_table)
{

	struct prefetch_work *tew;

		
	trace_printk("prefetch handler start! target(id,table): %d,%d\n",id,target_table);


	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;

	INIT_WORK(&tew->work, prefetch_work);
	tew->id=id;
	tew->target_table=target_table;
	//tew->task = p;

	schedule_work_on(1,&tew->work); // cpu 1
}

void sys_cold_page_sender_handler(struct task_struct *p)
{

	struct cold_page_sender_work *tew;

	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;

	INIT_WORK(&tew->work, sys_cold_page_sender_work);
	tew->task = p;

	schedule_work_on(0,&tew->work); // cpu 0 


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

void miss_page_handler(unsigned int id, int target_table)
{

	struct miss_page_work *tew;
	trace_printk("miss page handler start! target(id,table): %d,%d\n",id,target_table);

	tew = kmalloc(sizeof(*tew), GFP_KERNEL);
	if (!tew)
		return;

	INIT_WORK(&tew->work, miss_page_work);
	tew->id = id;
	tew->target_table=target_table;

	schedule_work_on(1,&tew->work); // cpu 1 


}




int ksg_pid;

int ksg_handler(struct ctl_table *table, int write,
                        void __user *buffer, size_t *length, loff_t *ppos)
{
    int rc = proc_dointvec_minmax(table, write, buffer, length, ppos);

	unsigned int id;

    printk("ksg: zram_to_nbd_handler start");
    if(rc)
        return rc;
    if(write)
    {
        /* for check declaration, check printk in dmesg */
        //printk("@@@@@@@@@@@@@ zram_to_nbd pid = %d  @@@@@@@@@@\n", zram_to_nbd);
        pid_t                   pid = (pid_t)ksg_pid;   // get target pid through sysctl
        struct task_struct      *task; // get target_process' struct task_struct
		struct vm_area_struct   *vma;
        unsigned long           vpage;
		
	
		rcu_read_lock();
		task = find_task_by_vpid(pid);
		rcu_read_unlock();
		
		if(foreground_uid)
			id = get_id_from_uid(foreground_uid);
        
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
                        if(__swp_swapcount(entry) != 1) {
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
								
									struct page *page = alloc_pages(GFP_KERNEL, 0); // read page from ZRAM to here && write this page to NBD, == alloc_page(GFP_KERNEL)
        
									swp_entry_t new_entry;
                                    pte_t new_pte;
									int ret;

										new_entry = get_swap_page_of_id(id);
									
                                    new_pte = swp_entry_to_pte(new_entry);
                                    
									//SetPageUnevictable(page);
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
									swap_readpage(page, true);
									
						
									lock_page(page);
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
                                    delete_from_swap_cache(page);

                                   
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
	
									swap_free(entry);
								
									unlock_page(page);
                                    pte_unmap_unlock(orig_pte, ptl);
	
									page->mapping = NULL;
									//free_pages((unsigned long)(page_address(page)), 0);
						
									__free_page(page);

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
					
					if(__swp_swapcount(entry) != 1) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{
						pte_t new_pte;
						u64 counter;
						orig_pte=pte_offset_map_lock(mm,pmd,vpage,&ptl);
						counter=pte_to_swp_counter_zram(*pte);
					
						if(counter<15)
							counter++;

						new_pte = swp_entry_and_counter_zram_to_pte(entry,counter);
						set_pte(orig_pte, new_pte);
						pte_unmap_unlock(orig_pte, ptl);

						if(counter > cold_page_threshold)
							flag = 1;

					}
				}
			}
		}
	}

	return flag;
}

int app_switch_start;

static inline long myclock()
{
        struct timeval my_time;
        do_gettimeofday(&my_time);

        return my_time.tv_usec;

}

void init_debug_vars(void){

	atomic_set(&switch_app_cold_page, 0);
	atomic_set(&after_app_cold_page, 0);
	atomic_set(&switch_sys_cold_page, 0);
	atomic_set(&after_sys_cold_page, 0);
	atomic_set(&switch_prefetch_hit, 0);
	atomic_set(&switch_prefetch_fault, 0);
	atomic_set(&after_prefetch_hit, 0);
	atomic_set(&after_prefetch_fault, 0);
	atomic_set(&prefetch_miss, 0);
	atomic_set(&unprefetched_prefetch_miss, 0);
	atomic_set(&direct_fault, 0);
	atomic_set(&switch_exception_fault, 0);
	atomic_set(&after_exception_fault, 0);

}


int app_switch_start_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{
	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	unsigned int id;
	unsigned long flags;
	int target_table;

	long st, et;

	if(rc)
		return rc;
	if(write){

		trace_printk("###########switch start! foreground %d#############\n",foreground_uid);

		st = myclock();

		init_debug_vars();

		if(!foreground_uid)
			return 0;

		id = get_id_from_uid(foreground_uid);
		
		spin_lock_irqsave(&which_table_lock,flags);
		target_table = past[id]->which_table;
		spin_unlock_irqrestore(&which_table_lock,flags);
		
		if(foreground_uid && prefetch_on)
			prefetch_handler(id,target_table);

		
		spin_lock_irqsave(&which_table_lock,flags);

		if(!past[id]->which_table && atomic_read(&past[id]->st_index0)==-1)
			past[id]->which_table=0;
		else if(past[id]->which_table && atomic_read(&past[id]->st_index1)==-1)
			past[id]->which_table=1;
		else
			past[id]->which_table=!past[id]->which_table;
		spin_unlock_irqrestore(&which_table_lock,flags);
		
		if(past[id]->which_table)
			atomic_set(&past[id]->st_index1,-1);
		else
			atomic_set(&past[id]->st_index0,-1);


		spin_lock_irqsave(&switch_start_lock,flags);
		switch_start = 1;
		spin_unlock_irqrestore(&switch_start_lock,flags);


		et = myclock();

		trace_printk("foreground %d switch start , total_time = %ldus\n",foreground_uid, et - st);

	}

	return 0;
}

int update_to_nbd_flag(unsigned int id){


	/*
	 * find both table and keep the flag on
	 * 
	 */

	int idx_e; //ealier
	int idx_l; //latter
	int max_idx_e;
	int max_idx_l;
	int after_idx_e;
	int after_idx_l;
	int cnt=0;
	struct swap_trace_entry *swap_trace_table_e;
	struct swap_trace_entry *swap_trace_table_l;
	int percentage;
	int target_percentage;

	//define st_idx_ptr_e = which_table ? &st_index0 : &st_index1
	//define stt_e = which_table ? swap_trace_table0 : swap_trace_table1
	//define st_idx_ptr_l = which_table ? &st_index1 : &st_index0
	//define stt_l = which_table ? swap_trace_table1 : swap_trace_table0
	
	if(past[id]->which_table){
		max_idx_e = atomic_read(&past[id]->st_index0);
		swap_trace_table_e = past[id]->swap_trace_table0;
		max_idx_l = atomic_read(&past[id]->st_index1);
		swap_trace_table_l = past[id]->swap_trace_table1;
		after_idx_e = atomic_read(&past[id]->after_index0);
		after_idx_l = atomic_read(&past[id]->after_index1);
	}
	else{
		max_idx_e = atomic_read(&past[id]->st_index1);
		swap_trace_table_e = past[id]->swap_trace_table1;
		max_idx_l = atomic_read(&past[id]->st_index0);
		swap_trace_table_l = past[id]->swap_trace_table0;
		after_idx_e = atomic_read(&past[id]->after_index1);
		after_idx_l = atomic_read(&past[id]->after_index0);
	}

	target_percentage = (launchtime_before * 18 * 100 / (18 * launchtime_before + max_idx_l));

	if(target_percentage>100)
		target_percentage=100;

	if(prefetch_percentage)
		target_percentage=prefetch_percentage;
	
	percentage = 100 - target_percentage;


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

	/* AND version!*/
	
		
	idx_l = max_idx_l + 1;
	while(idx_l <= after_idx_l){
		idx_e = max_idx_e + 1;
		while(idx_e <= after_idx_e){
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

	trace_printk("appid %d: table %d is latter, percentage %d, total target %d max idx e, l -> %d %d, after %d %d\n",id, past[id]->which_table,target_percentage,cnt,max_idx_e,max_idx_l,after_idx_e - max_idx_e, after_idx_l - max_idx_l);
/*
	while(idx_l <= max_idx_l){
		if( swap_trace_table_l[idx_l].to_nbd )
			trace_printk("%d: tgid %d va %llx is target\n",idx_l,swap_trace_table_l[idx_l].tgid,swap_trace_table_l[idx_l].va);
		idx_l++;
	}

*/

	return 0;
}

int app_switch_fin;

int app_switch_fin_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{


	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	unsigned long flags;
	unsigned int id;
	if(rc)
		return rc;
	if(write){
	
		struct task_struct *p;
		/*
		 * Switch finished
		 */
		spin_lock_irqsave(&switch_start_lock,flags);
		switch_start = 0;
		spin_unlock_irqrestore(&switch_start_lock,flags);

		/*
		 * Update to_nbd flag of st
		 */

		if(!cloudswap_on){


		


		if(foreground_uid) 
		{
			id = get_id_from_uid(foreground_uid);
			if(atomic_read(&past[id]->st_index0)!=-1 || atomic_read(&past[id]->st_index1)!=-1)
			{
				update_to_nbd_flag(id); //<--app_number or uid
				past[id]->st_should_check = 1 ; // --> per app, and keep in list
			}
		}

		/*
		 * Cold page handling
		 */
	
		if(backgrounded_uid){
			rcu_read_lock();
			for_each_process(p){
				if(!p)
					continue;
				if(p->tgid == nbd_client_pid)
					continue;
				if(backgrounded_uid && p->cred->uid.val == backgrounded_uid){
					printk("backgrounded_uid %d",backgrounded_uid);
					if(task_swap_counter_inc(p))
						cold_page_sender_handler(p);
					/* for preempted task */
					if(preempted_cold_task){
						trace_printk("preempted cold task recheck\n");
						cold_page_sender_handler(preempted_cold_task);
					}
				}
			}
			rcu_read_unlock();
		}

		if(foreground_uid){
			id = get_id_from_uid(foreground_uid);
			miss_handling = 1;
			miss_page_handler(id,!past[id]->which_table); //--> forcing pagefault and ((madvise))
		}
		wake_up_send_target_manager();

		backgrounded_uid = foreground_uid;


		}
	}
	return 0;
}

int app_switch_after_1;

int app_switch_after_1_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{


	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	unsigned long flags;
	unsigned int id;
	if(rc)
		return rc;
	if(write){
	
		/*
		 * Switch finished
		 */

		spin_lock_irqsave(&switch_start_lock,flags);
		switch_start = 0;
		spin_unlock_irqrestore(&switch_start_lock,flags);


		/* for after page dump */

		if(foreground_uid){
			id = get_id_from_uid(foreground_uid);
			trace_printk("foreground %d switch after start\n",foreground_uid);

			if(past[id]->which_table)
				atomic_set(&past[id]->after_index1,atomic_read(&past[id]->st_index1));
			else
				atomic_set(&past[id]->after_index0,atomic_read(&past[id]->st_index0));
			
			spin_lock_irqsave(&switch_start_lock,flags);
			switch_after = 1;
			spin_unlock_irqrestore(&switch_start_lock,flags);
		

		}



	}
	return 0;


}

int app_switch_after_2;

int app_switch_after_2_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{


	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	unsigned long flags;
	unsigned int id;
	if(rc)
		return rc;
	if(write){
	
		struct task_struct *p;
		/*
		 * Switch finished
		 */

		trace_printk("foreground %d switch after end\n",foreground_uid);
		spin_lock_irqsave(&switch_start_lock,flags);
		switch_after = 0;
		spin_unlock_irqrestore(&switch_start_lock,flags);


		/*
		 * Update to_nbd flag of st
		 */

		if(!cloudswap_on){


		if(foreground_uid) 
		{
			id = get_id_from_uid(foreground_uid);
			if(atomic_read(&past[id]->st_index0)!=-1 || atomic_read(&past[id]->st_index1)!=-1)
			{
				update_to_nbd_flag(id); //<--app_number or uid
				past[id]->st_should_check = 1 ; // --> per app, and keep in list
			}
		}


		/*
		 * Cold page handling
		 */
	
		if(backgrounded_uid){
			rcu_read_lock();
			for_each_process(p){
				if(!p)
					continue;
				if(p->tgid == nbd_client_pid)
					continue;

				/*
				 * Temporary for app group
				 */
				if(backgrounded_uid==CC_UID && p->cred->uid.val >= 99000){
					trace_printk("backgrounded_uid %d\n",p->cred->uid.val);
					if(task_swap_counter_inc(p))
						cold_page_sender_handler(p);
				}

				if(backgrounded_uid==CH_UID && p->cred->uid.val >=90000 && p->cred->uid.val<99000){
					trace_printk("backgrounded_uid %d\n",p->cred->uid.val);
					if(task_swap_counter_inc(p))
						cold_page_sender_handler(p);
				}

				/*********
				 *********/

				if(backgrounded_uid && p->cred->uid.val == backgrounded_uid){
					trace_printk("backgrounded_uid %d\n",backgrounded_uid);
					if(task_swap_counter_inc(p))
						cold_page_sender_handler(p);
					/* for preempted task */
					if(preempted_cold_task){
						trace_printk("preempted cold task recheck\n");
						cold_page_sender_handler(preempted_cold_task);
					}
				}
			}
			rcu_read_unlock();
		}

		if(foreground_uid){
			id = get_id_from_uid(foreground_uid);
			miss_handling = 1;
			miss_page_handler(id,!past[id]->which_table); //--> forcing pagefault and ((madvise))
		}


		wake_up_send_target_manager();

		backgrounded_uid = foreground_uid;


		}
	}
	return 0;

}


int app_trace_status;

int app_trace_status_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos)
{


	int rc = proc_dointvec_minmax(table,write,buffer,length,ppos);
	if(rc)
		return rc;
	if(write){

		if(app_trace_status)
			trace_printk("app_trace_status==%d\n",app_trace_status);


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
    struct task_struct      *task;
	rcu_read_lock();
	task = find_task_by_vpid(pid);
	rcu_read_unlock();
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
					if(non_swap_entry(entry) || swp_type(entry) == NBD_TYPE)
					{
						//pte_unmap_unlock(pte, ptl);
						continue;
					}
					
					if(__swp_swapcount(entry) != 1) {
						continue;
					}
					else                    // page is swapped and swap entry.
					{
						u64 counter;
						counter=pte_to_swp_counter_zram(*pte);

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
	trace_printk("remote: total excepted page: %d\n", excepted_page);
	trace_printk("remote: sent system page: %d\n", sent_sys_cold_page);
	trace_printk("remote: total faulted system page: %d\n", faulted_sys_cold_page);
	trace_printk("remote: ZRAM remain: %d KB / 2097148 KB\n", zram_remain()*4);
	trace_printk("remote: total direct page: %d\n", nbd_direct_page);
	}
	return 0;
}

/*void cold_page_sender_wq_init(void)
{
	struct workqueue_struct *cold_page_sender_wq = create_workqueue("cold_page_sender_wq");
}*/


static int target_manager_should_run(void)
{

	

	return stm_wait_cond  && !switch_start ; // should run in background
}

static int send_target_page(unsigned int id, pid_t tgid, unsigned long va, bool is_after){

       

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

								if(_send_target_page(id, pte, pmd, va, mm, is_after)){
									
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

static int send_target_alarm(void *arg)
{
	while (!kthread_should_stop()) {

	
	//	trace_printk(KERN_ERR "[REMOTE %s] target alarm started!\n", __func__);
			
		wake_up_send_target_manager();
			
		
		schedule_timeout_interruptible(ALARM_PERIOD);
	
		
	}

	return 0;
}


static int send_target_manager(void *arg)
{

	int i;
	int max_idx_l;
	int max_idx_e;
	int after_idx_l;
	int after_idx_e;
	int target_table;
	pid_t tgid;
	unsigned long va;
	unsigned long flags;
	unsigned long flags2;
	struct swap_trace_entry *swap_trace_table_l;
	struct swap_trace_entry *swap_trace_table_e;
	set_user_nice(current, MAX_NICE);
	

		
	//trace_printk(KERN_ERR "[REMOTE %s] target manager started\n", __func__);
	while (!kthread_should_stop()) {
		
		
		bool target_flag=0;
		unsigned int id;

		for(id = 0 ; id < __NR_APPIDS ; id++)
		{
			if(!past[id]->st_should_check)
				continue;

			spin_lock_irqsave(&switch_start_lock,flags);
			if(!switch_start){
				if(!spin_trylock_irqsave(&which_table_lock,flags2)){	
					spin_unlock_irqrestore(&switch_start_lock,flags);
					goto sleep;
				}
		
				target_table = past[id]->which_table;
				//trace_printk("send target manager - id, which_table : %d, %d\n",id,past[id]->which_table);
				spin_unlock_irqrestore(&which_table_lock,flags2);
	
			}
			else{
				spin_unlock_irqrestore(&switch_start_lock,flags);
				continue;
			}
			spin_unlock_irqrestore(&switch_start_lock,flags);
	
	if(target_table){
		max_idx_e = atomic_read(&past[id]->st_index0);
		swap_trace_table_e = past[id]->swap_trace_table0;
		max_idx_l = atomic_read(&past[id]->st_index1);
		swap_trace_table_l = past[id]->swap_trace_table1;
		after_idx_e = atomic_read(&past[id]->after_index0);
		after_idx_l = atomic_read(&past[id]->after_index1);
	}
	else{
		max_idx_e = atomic_read(&past[id]->st_index1);
		swap_trace_table_e = past[id]->swap_trace_table1;
		max_idx_l = atomic_read(&past[id]->st_index0);
		swap_trace_table_l = past[id]->swap_trace_table0;
		after_idx_e = atomic_read(&past[id]->after_index1);
		after_idx_l = atomic_read(&past[id]->after_index0);
	}
	/*
			if(target_table){
				max_idx_l = atomic_read(&past[id]->st_index1);
				swap_trace_table_l = past[id]->swap_trace_table1;
			}
			else{
				max_idx_l = atomic_read(&past[id]->st_index0);
				swap_trace_table_l = past[id]->swap_trace_table0;
			}
	*/
			for( i = 0 ; i < after_idx_l +1 ; i++ ){
				if(switch_start || stop_background_io){
					target_flag = 0;
					//trace_printk(KERN_ERR "[REMOTE %s] switch started during sent\n", __func__);
					goto sleep;
				}
				if(swap_trace_table_l[i].to_nbd && !swap_trace_table_l[i].swapped){
						
					target_flag=1;
					tgid = swap_trace_table_l[i].tgid;
					va = swap_trace_table_l[i].va;
					if(send_target_page(id/* ID */,tgid,va,i>max_idx_l)){
						swap_trace_table_l[i].swapped=1;
					}
				}
			}

			/***for direct page***/

			


		}
sleep:
		if(target_flag==0) /*Nothing to be sent*/
		{
			//trace_printk(KERN_ERR "[REMOTE %s] target manager slept\n", __func__);
			spin_lock_irqsave(&stm_wait_cond_lock,flags);
			stm_wait_cond = FALSE;
			spin_unlock_irqrestore(&stm_wait_cond_lock,flags);
		}

		if (target_manager_should_run())
			schedule_timeout_interruptible(MANAGER_PERIOD);
		else{
			
			wait_event_freezable(send_target_manager_wait,
				target_manager_should_run() || kthread_should_stop());
		
			//trace_printk(KERN_ERR "[REMOTE %s] target manager wake up\n", __func__);
		
		}
		
		cond_resched();
	}

	return 0;
}



static __init int send_target_managers_init(void)
{
	send_target_manager_thread = kthread_run(send_target_manager, NULL, "send_target_manager");
	send_target_alarm_thread = kthread_run(send_target_alarm, NULL, "send_target_alarm");
	if (unlikely(WARN_ON(IS_ERR(send_target_manager_thread)))) {
		pr_err("[REMOTE %s] kthread_create failed\n", __func__);
		return -ENOMEM;
	}
	if (unlikely(WARN_ON(IS_ERR(send_target_alarm_thread)))) {
		pr_err("[REMOTE %s] kthread_create failed\n", __func__);
		return -ENOMEM;
	}

	return 0;
}



static int sys_cold_manager(void *arg)
{
		
	struct task_struct *p;
	//int remain;
	int thresh;
	while (!kthread_should_stop()) {
		
		
		schedule_timeout_interruptible(SYSTEMWIDE_COLD_PERIOD);
	
		
		while (sys_cold_handler_off)	
			schedule_timeout_interruptible(SYSTEMWIDE_COLD_PERIOD);
		
		
		//trace_printk(KERN_ERR "[REMOTE %s] sys_cold_manager wake up\n", __func__);

		rcu_read_lock();
		for_each_process(p){
			if(!p)
				continue;
			if(p->tgid == nbd_client_pid || p->tgid == 1)
				continue;


			//for app group
			if(p->cred->uid.val>=99000 || p->cred->uid.val==90000)
				continue;

			if(is_system_uid(p->cred->uid.val)){
				task_swap_counter_inc(p);
				//if ZRAM full	
				

				
				thresh = ZRAM_PAGES*0.5;
				//trace_printk(KERN_ERR "[REMOTE %s] sys_cold_manager tgid %d, %d < %d?\n", __func__, p->tgid,zram_remain(),thresh);

				//if(zram_full)
				if(zram_remain() < thresh){
					sys_cold_page_sender_handler(p);
				}
		
			}
		}
		rcu_read_unlock();
		zram_full=0;
			
		//trace_printk(KERN_ERR "[REMOTE %s] sys_cold_manager slept\n", __func__);
	//	schedule_timeout_interruptible(SYSTEMWIDE_COLD_PERIOD);
	}

	return 0;
}

/*********ASAP***********/

int anon_page_dump;
int anon_page_dump_clear_af;

static void _anon_page_dump(pid_t pid) {
        struct task_struct *task = find_task_by_vpid(pid);
        unsigned long vpage;
        int accessed, idx, coldcnt=0, cnt=0;
        struct vm_area_struct *vma;
        if (!task) {
                printk("task %d not found", pid);
                return;
        }
        if (task->mm && task->mm->mmap) {
                for (vma = task->mm->mmap; vma; vma = vma->vm_next) {
                        for (vpage = vma->vm_start, idx = 0; vpage < vma->vm_end; vpage += PAGE_SIZE, idx++) {
                                pgd_t *pgd;
                                pud_t *pud;
                                pmd_t *pmd;
                                pte_t *pte;
                                pte_t entry;
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

                                if (pte_present(*pte)) {
                                        accessed = pte_young(*pte);
                                        if (anon_page_dump_clear_af) {
                                                entry = pte_mkold(*pte);
                                        set_pte_at(mm, vpage, pte, entry);
                                        }
                                }
                                else
                                        accessed = 2; //swapped!
                                if(vma->vm_file){
                                        if(vma->vm_file->f_inode){
                                        //trace_printk("FILE_PAGE_DUMP %s %lu %d %d\n",task->comm, vma->vm_file->f_inode->i_ino, idx, accessed);
                                        }
                                }else{
                                    trace_printk("ANON_PAGE_DUMP %s %d %llx %d\n",task->comm, task->tgid, vpage, accessed);
									if(accessed==1)
										cnt++;
									else
										coldcnt++;
                                }
                        }
                }
				trace_printk("total %s %d accessed: %d cold: %d\n",task->comm, task->tgid , cnt, coldcnt);
        }
}





int anon_page_dump_sysctl_handler(struct ctl_table *table, int write,
	void __user *buffer, size_t *length, loff_t *ppos) {

        int rc;

	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
	if (rc)
		return rc;

	if (write) {
                printk("anon_page_dump start for %d", anon_page_dump);
                _anon_page_dump(anon_page_dump);
                printk("anon_page_dump end for %d", anon_page_dump);
        }

	return 0;
}








static __init int sys_cold_counter_init(void)
{
	sys_cold_counter_thread = kthread_run(sys_cold_manager, NULL, "sys_cold_manager");
	if (unlikely(WARN_ON(IS_ERR(sys_cold_counter_thread)))) {
		pr_err("[REMOTE %s] kthread_create failed\n", __func__);
		return -ENOMEM;
	}

	return 0;
}


static void cluster_set_null_1(struct swap_cluster_info *info)
{
	info->flags = CLUSTER_FLAG_NEXT_NULL;
	info->data = 0;
}

void init_past(struct per_app_swap_trace *past){

	int i;
	atomic_set(&past->st_index0,-1);
	atomic_set(&past->st_index1,-1);
	atomic_set(&past->after_index0,-1);
	atomic_set(&past->after_index1,-1);
	past->st_should_check = 0;
	past->which_table = 0;
	for(i=0;i<NUM_STT_ENTRIES;i++){
		past->swap_trace_table0[i].tgid=0;
		past->swap_trace_table0[i].va=0;
		past->swap_trace_table0[i].to_nbd=0;
		past->swap_trace_table0[i].swapped=0;

		past->swap_trace_table1[i].tgid=0;
		past->swap_trace_table1[i].va=0;
		past->swap_trace_table1[i].to_nbd=0;
		past->swap_trace_table1[i].swapped=0;
	}
}

static int __init remote_swap_init(void)
{

	int error;
	int i;
	int __nr_appids = __NR_APPIDS;
	printk(KERN_ERR "[REMOTE %s] INIT remote swap max %d apps\n", __func__,__nr_appids);
			
	cold_page_threshold = 2;

	//per_app structs init
	for(i=0;i<__nr_appids*2 + 1;i++){
		struct perapp_cluster *cluster;
		cluster=&pac[i];
		cluster_set_null_1(&cluster->index);
	}
	for(i=0;i<__nr_appids;i++){
		past[i]=(struct per_app_swap_trace *)vmalloc(sizeof(struct per_app_swap_trace));
		init_past(past[i]);
	}

	prefetch_percentage = 0;

	preempted_cold_task = NULL;

	error = send_target_managers_init();
	if(unlikely(error))
		return error;

	error = sys_cold_counter_init();
	if(unlikely(error))
		return error;

	return 0;
}

static void __exit remote_swap_exit(void){

	int i;
	int __nr_appids = __NR_APPIDS;
	for(i=0;i<__nr_appids*2 + 1;i++){
		struct perapp_cluster *cluster;
		cluster=&pac[i];
		cluster_set_null_1(&cluster->index);
	}
	for(i=0;i<__nr_appids;i++){
		vfree(past[i]);
	}
	kthread_stop(send_target_manager_thread);
	return ;

}


module_init(remote_swap_init)
module_exit(remote_swap_exit)

#endif

