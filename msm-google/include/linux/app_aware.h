#ifndef _LINUX_APP_AWARE_H
#define _LINUX_APP_AWARE_H

#include <linux/types.h>
#include <linux/printk.h>
#include <linux/mm_types.h>


#define ZRAM_TYPE   0
#define NBD_TYPE    1
#define COLD_PAGE_THRESHOLD 5
#define NUM_STT_ENTRIES 20000

/******************************
 * APPLICATION UID DEFINITION *
 ******************************/
#define MAPS_UID 10135
#define YT_UID 10126
#define IG_UID 10127
#define TW_UID 10133
#define CC_UID 10128
#define AB_UID 10122
#define CR_UID 10159
#define MAIL_UID 10136
#define CH_UID 10124 


struct prefetch_work {
	struct work_struct work;
	unsigned int id;
	int target_table;
};
struct cold_page_sender_work {
	struct work_struct work;
	struct task_struct *task;	
};
struct miss_page_work {
	struct work_struct work;
	unsigned int id;
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
// --> per app
struct per_app_swap_trace {
	atomic_t st_index0;
	atomic_t st_index1;
	struct swap_trace_entry swap_trace_table0[NUM_STT_ENTRIES];
	struct swap_trace_entry swap_trace_table1[NUM_STT_ENTRIES];
	bool st_should_check; // --> per app, and keep in list
	bool which_table; // --> per app
};

extern bool switch_start;
extern struct perapp_cluster pac[10];
extern struct per_app_swap_trace *past[9];

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

extern unsigned int get_id_from_uid(int uid);
extern void init_past(struct per_app_swap_trace *past);

extern int foreground_uid;
extern int foreground_pid;
extern int swapin_vma_tracking;
extern int swapin_anon_tracking;
extern int prefetch_on;
extern int target_percentage;
extern int random_nbd_entry;





#endif /* _LINUX_APP_AWARE_H */
