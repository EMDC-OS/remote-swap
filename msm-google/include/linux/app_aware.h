#ifndef _LINUX_APP_AWARE_H
#define _LINUX_APP_AWARE_H


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

extern int background_swapout;
extern int background_swapout_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);


extern int ksg_pid;
extern int ksg_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int backgrounded_uid;
extern int backgrounded_uid_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);

extern int swap_counter_dump;
extern int swap_counter_dump_handler(struct ctl_table *table, int write,
                 void __user *buffer, size_t *length, loff_t *ppos);


extern int foreground_uid;
extern int foreground_pid;
extern int swapin_vma_tracking;
extern int swapin_anon_tracking;


#endif /* _LINUX_APP_AWARE_H */
