#ifndef _LINUX_APP_AWARE_H
#define _LINUX_APP_AWARE_H

#include <linux/types.h>
#include <linux/printk.h>
#include <linux/mm_types.h>


#define ZRAM_TYPE   0
#define NBD_TYPE    1
#define COLD_PAGE_THRESHOLD 2 
#define SYS_COLD_PAGE_THRESHOLD 4 
#define ZRAM_PAGES 524287
#define NUM_STT_ENTRIES 30000

/******************************
 * APPLICATION UID DEFINITION *
 ******************************/
#define MAPS_UID 10135
#define YT_UID 10126
#define IG_UID 10127
#define TW_UID 10133
#define CC_UID 10128
#define AB_UID 10122
#define FB_UID 10137
#define CR_UID 10171
#define MAIL_UID 10136
#define CH_UID 10124 
#define	IV_UID 10173
#define	CN_UID 10172
#define	SP_UID 10174
#define	MX_UID 10175
#define	KT_UID 10134
#define	PG_UID 10164
#define	DB_UID 10144
#define	TWCH_UID 10161


enum appids {
	MAPS_ID,
	YT_ID,
	IG_ID,
	TW_ID,
	CC_ID,
	AB_ID,
	FB_ID,
	CR_ID,
	MAIL_ID,
	CH_ID,
	IV_ID,
	CN_ID,
	SP_ID,
	MX_ID,
	KT_ID,
	PG_ID,
	DB_ID,
	TWCH_ID,
/************/
	COLD_ID, // == __NR_APPIDS
	DIRECT_ID,
	SYS_COLD_ID,
};
#define __NR_APPIDS COLD_ID


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
	atomic_t after_index0;
	atomic_t after_index1;
	struct swap_trace_entry swap_trace_table0[NUM_STT_ENTRIES];
	struct swap_trace_entry swap_trace_table1[NUM_STT_ENTRIES];
	bool st_should_check; // --> per app, and keep in list
	bool which_table; // --> per app
};

extern bool switch_start;
extern bool switch_after;
extern bool miss_handling;
extern bool zram_full;
extern struct perapp_cluster pac[2*__NR_APPIDS+1];
extern struct per_app_swap_trace *past[__NR_APPIDS];

extern atomic_t sent_cold_page;
extern atomic_t sent_sys_cold_page;
extern atomic_t faulted_cold_page;
extern atomic_t faulted_sys_cold_page;

extern atomic_t excepted_page;
extern atomic_t nbd_direct_page;


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

extern int app_switch_after_1;
extern int app_switch_after_1_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int app_switch_after_2;
extern int app_switch_after_2_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int app_trace_status;
extern int app_trace_status_handler(struct ctl_table *table, int write,
			   void __user *buffer, size_t *length, loff_t *ppos);


extern unsigned int get_id_from_uid(int uid);
extern void init_past(struct per_app_swap_trace *past);

extern int foreground_uid;
extern int foreground_pid;
extern int swapin_vma_tracking;
extern int swapin_anon_tracking;
extern int prefetch_on;
extern int target_percentage;
extern int nbd_client_pid;
extern int sys_cold_handler_off;



/***API FROM ASAP***/
extern int anon_page_dump;
extern int anon_page_dump_clear_af;
extern int anon_page_dump_sysctl_handler(struct ctl_table *table, int write,
	void __user *buffer, size_t *length, loff_t *ppos); 



#endif /* _LINUX_APP_AWARE_H */
