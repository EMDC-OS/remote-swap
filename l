[1mdiff --git a/adb_data_backup/data/launch/after_launch_app.sh b/adb_data_backup/data/launch/after_launch_app.sh[m
[1mindex 3aebf24b8..d925c01e1 100644[m
[1m--- a/adb_data_backup/data/launch/after_launch_app.sh[m
[1m+++ b/adb_data_backup/data/launch/after_launch_app.sh[m
[36m@@ -131,7 +131,7 @@[m [melif [ "${app}" = "facebook" ]; then[m
 elif [ "${app}" = "camera" ]; then[m
 	am start -a android.media.action.IMAGE_CAPTURE -W > /data/launch/temp[m
 elif [ "${app}" = "investing" ]; then[m
[31m-	am start -n com.fusionmedia.investing/.ui.activities.SplashSplitter -W > /data/launch/temp[m
[32m+[m	[32mam start -n com.fusionmedia.investing/.ui.activities.LiveActivity -W > /data/launch/temp[m
 elif [ "${app}" = "cnn" ]; then[m
 	am start -n com.cnn.mobile.android.phone/.features.splash.SplashActivity -W > /data/launch/temp[m
 elif [ "${app}" = "spotify" ]; then[m
[1mdiff --git a/adb_data_backup/data/launch/launch_app.sh b/adb_data_backup/data/launch/launch_app.sh[m
[1mindex 2d6f44421..1bbcdffb7 100644[m
[1m--- a/adb_data_backup/data/launch/launch_app.sh[m
[1m+++ b/adb_data_backup/data/launch/launch_app.sh[m
[36m@@ -128,7 +128,7 @@[m [melif [ "${app}" = "facebook" ]; then[m
 elif [ "${app}" = "camera" ]; then[m
 	am start -a android.media.action.IMAGE_CAPTURE -W > /data/launch/temp[m
 elif [ "${app}" = "investing" ]; then[m
[31m-	am start -n com.fusionmedia.investing/.ui.activities.SplashSplitter -W > /data/launch/temp[m
[32m+[m	[32mam start -n com.fusionmedia.investing/.ui.activities.LiveActivity -W > /data/launch/temp[m
 elif [ "${app}" = "cnn" ]; then[m
 	am start -n com.cnn.mobile.android.phone/.features.splash.SplashActivity -W > /data/launch/temp[m
 elif [ "${app}" = "spotify" ]; then[m
[1mdiff --git a/adb_data_backup/data/launch/with_sysctl_launch_app.sh b/adb_data_backup/data/launch/with_sysctl_launch_app.sh[m
[1mindex 4a3f40567..86ea4643b 100644[m
[1m--- a/adb_data_backup/data/launch/with_sysctl_launch_app.sh[m
[1m+++ b/adb_data_backup/data/launch/with_sysctl_launch_app.sh[m
[36m@@ -131,7 +131,7 @@[m [melif [ "${app}" = "facebook" ]; then[m
 elif [ "${app}" = "camera" ]; then[m
 	am start -a android.media.action.IMAGE_CAPTURE -W > /data/launch/temp[m
 elif [ "${app}" = "investing" ]; then[m
[31m-	am start -n com.fusionmedia.investing/.ui.activities.SplashSplitter -W > /data/launch/temp[m
[32m+[m	[32mam start -n com.fusionmedia.investing/.ui.activities.LiveActivity -W > /data/launch/temp[m
 elif [ "${app}" = "cnn" ]; then[m
 	am start -n com.cnn.mobile.android.phone/.features.splash.SplashActivity -W > /data/launch/temp[m
 elif [ "${app}" = "spotify" ]; then[m
[1mdiff --git a/msm-google/include/linux/app_aware.h b/msm-google/include/linux/app_aware.h[m
[1mindex 15ce4d36e..7976454bd 100644[m
[1m--- a/msm-google/include/linux/app_aware.h[m
[1m+++ b/msm-google/include/linux/app_aware.h[m
[36m@@ -104,7 +104,6 @@[m [mstruct per_app_swap_table {[m
 	atomic_t after_index1;[m
 	struct swap_trace_entry swap_trace_table0[NUM_STT_ENTRIES];[m
 	struct swap_trace_entry swap_trace_table1[NUM_STT_ENTRIES];[m
[31m-	bool st_should_check; // --> per app, and keep in list[m
 	bool which_table; // --> per app[m
 };[m
 [m
[1mdiff --git a/msm-google/jyp/remote.c b/msm-google/jyp/remote.c[m
[1mindex b0fbc48c8..31ea5934d 100644[m
[1m--- a/msm-google/jyp/remote.c[m
[1m+++ b/msm-google/jyp/remote.c[m
[36m@@ -270,7 +270,7 @@[m [mstatic int _send_target_page(unsigned int id, pte_t *pte, pmd_t *pmd, unsigned l[m
 	[m
 	set_pte(orig_pte, new_pte);[m
 	if(mm && mm->owner)[m
[31m-		trace_printk("target sent id %d: cluster %d, %d %llx %llx\n",id,id+(__NR_APPIDS+1)*is_after,mm->owner->tgid, vpage, swp_offset(new_entry));[m
[32m+[m		[32mtrace_printk("target sent id %d state %d: cluster %d, %d %llx %llx\n",id,app_sbp[id]->last_state,id+(__NR_APPIDS+1)*is_after,mm->owner->tgid, vpage, swp_offset(new_entry));[m
 	swap_free(entry);[m
 	ret=1;[m
 unlock:[m
[36m@@ -1675,7 +1675,7 @@[m [mint update_to_nbd_flag(unsigned int id){[m
 		after_idx_l