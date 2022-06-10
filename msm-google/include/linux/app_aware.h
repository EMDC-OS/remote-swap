#ifndef _LINUX_APP_AWARE_H
#define _LINUX_APP_AWARE_H

#include <linux/types.h>
#include <linux/printk.h>
#include <linux/mm_types.h>


#define ZRAM_TYPE   0
#define NBD_TYPE    1
#define COLD_PAGE_THRESHOLD 5



struct cold_page_sender_work {
	struct work_struct work;
	struct task_struct *task;	
};
struct prefetch_work {
	struct work_struct work;
	int target_table;
};
struct perapp_cluster {
	struct swap_cluster_info index; /* Current cluster index */
	unsigned int next; /* Likely next allocation offset */
};
struct swap_trace_entry {
        pid_t tgid; 
        unsigned long va;
		bool to_nbd;
		bool swapped;
};

extern bool which_table;
extern bool switch_start;
extern atomic_t st_index0;
extern atomic_t st_index1;
extern struct swap_trace_entry swap_trace_table0[40000];
extern struct swap_trace_entry swap_trace_table1[40000];
extern struct perapp_cluster pac[10];


extern atomic_t sent_cold_page;
extern atomic_t faulted_cold_page;


extern int swapcache_flush;
extern int swapcache_flush_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);


extern int workingset_status;
extern int workingset_status_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int anon_uid_scan;
extern int anon_uid_scan_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int find_lru_index_mode;
extern int find_lru_index;
extern int find_lru_index_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int lru_scan_private;
extern int lru_scan_private_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int lru_scan;
extern int lru_scan_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int ksg_pid;
extern int ksg_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int backgrounded_uid;

extern int swap_counter_dump;
extern int swap_counter_dump_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int app_switch_start;
extern int app_switch_start_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int app_switch_fin;
extern int app_switch_fin_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int get_id_from_uid(int uid);

extern int foreground_uid;
extern int foreground_pid;
extern int swapin_vma_tracking;
extern int swapin_anon_tracking;
extern int prefetch_on;





#endif /* _LINUX_APP_AWARE_H */
