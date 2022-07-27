
#cat /proc/vmstat > vmstat_start
#am start -a android.intent.action.VIEW
#adb shell am start -a android.intent.action.VIEW

### Start CandyCrush on host
#adb shell am start -n com.king.candycrushsaga/.CandyCrushSagaActivity $

app=${1}
kernel=${2}
state=${3}
debugfs="/sys/kernel/debug"
#echo nop > $debugfs/tracing/current_tracer
#echo 0 > $debugfs/tracing/tracing_on
#echo 4096 > $debugfs/tracing/buffer_size_kb

#mkdir -p /data/launch/result_${app}
#mkdir -p /data/launch/result_${app}/${kernel}
#mkdir -p /data/launch/result_${app}/${kernel}/${state}

#cat /proc/vmstat > /data/launch/result_${app}/${kernel}/${state}/vmstat_start
#cat /proc/stat > /data/launch/result_${app}/${kernel}/${state}/stat_start
#cat /proc/diskstats > /data/launch/result_${app}/${kernel}/${state}/diskstats_start

#echocom.spotify.music/.MainActivity 1 > $debugfs/tracing/tracing_on
#echo 1 > /proc/sys/kernel/fastpf_analysis
#if [ "${kernel}" = "fastpf" ]; then
#	echo 1 > /proc/sys/kernel/fastpf
#fi


if [ "${app}" = "candycrush" ]; then
	echo 10128 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "googlemaps" ]; then
	echo 10135 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "youtube" ]; then
	echo 10126 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "instagram" ]; then
	echo 10127 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "twitter" ]; then
	echo 10133 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "angrybirds" ]; then
	echo 10122 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "facebook" ]; then
	echo 10137 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "pubg" ]; then
	echo 10158 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "clashroyale" ]; then
	echo 10171 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "gmail" ]; then
	echo 10136 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "chrome" ]; then
	echo 10124 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "investing" ]; then
	echo 10173 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "cnn" ]; then
	echo 10172 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "spotify" ]; then
	echo 10174 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "mxplayer" ]; then
	echo 10175 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "kakaotalk" ]; then
	echo 10134 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "pokemongo" ]; then
	echo 10164 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "dropbox" ]; then
	echo 10144 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "twitch" ]; then
	echo 10161 > /proc/sys/kernel/foreground_uid
elif [ "${app}" = "home" ]; then
	echo 0 > /proc/sys/kernel/foreground_uid
else
	echo "Please enter Appname Kernel_mode Launching_state"
	exit 100
fi

echo 1 > /proc/sys/kernel/app_switch_start

if [ "${app}" = "candycrush" ]; then
	am start -n com.king.candycrushsaga/.CandyCrushSagaActivity -W
elif [ "${app}" = "googlemaps" ]; then
	am start -n com.google.android.apps.maps/com.google.android.maps.MapsActivity -W
elif [ "${app}" = "gmail" ]; then
	am start -n com.google.android.gm/.ConversationListActivityGmail -W
elif [ "${app}" = "youtube" ]; then
	am start -n com.google.android.youtube/com.google.android.apps.youtube.app.WatchWhileActivity -W
elif [ "${app}" = "instagram" ]; then
	am start -n com.instagram.android/com.instagram.android.activity.MainTabActivity -W
elif [ "${app}" = "pinterest" ]; then
	am start -n com.pinterest/.activity.PinterestActivity -W
elif [ "${app}" = "discord" ]; then
	am start -n com.discord/com.discord.app.AppActivity$Main -W
elif [ "${app}" = "zoom" ]; then
	am start -n us.zoom.videomeetings/com.zipow.videobox.LauncherActivity -W
elif [ "${app}" = "airbnb" ]; then
	am start -n com.airbnb.android/com.airbnb.android.feat.homescreen.HomeActivity -W
elif [ "${app}" = "agoda" ]; then
	am start -n com.agoda.mobile.consumer/com.agoda.mobile.consumer.screens.home.HomeActivity -W
elif [ "${app}" = "uber" ]; then
	am start -n com.ubercab/com.ubercab.presidio.app.core.root.RootActivity -W
elif [ "${app}" = "googledrive" ]; then
	am start -n com.google.android.apps.docs/.drive.app.navigation.NavigationActivity -W
elif [ "${app}" = "coc" ]; then
	am start -n com.supercell.clashofclans/com.supercell.titan.GameApp -W
elif [ "${app}" = "twitter" ]; then
	am start -n com.twitter.android/com.twitter.app.main.MainActivity -W
elif [ "${app}" = "microword" ]; then
	am start -n com.microsoft.office.word/com.microsoft.office.apphost.LaunchActivity -W
elif [ "${app}" = "adobe" ]; then
	am start -n com.adobe.reader/.home.ARHomeActivity -W
elif [ "${app}" = "minecraft" ]; then
	am start -n com.mojang.minecrafttrialpe/com.mojang.minecraftpe.MainActivity -W
elif [ "${app}" = "webview" ]; then
	am start -a android.intent.action.VIEW -d http://www.naver.com -W
elif [ "${app}" = "clashroyale" ]; then
	am start -n com.supercell.clashroyale/com.supercell.titan.GameApp -W
elif [ "${app}" = "angrybirds" ]; then
	am start -n com.rovio.baba/com.unity3d.player.UnityPlayerActivity -W
elif [ "${app}" = "chrome" ]; then
	am start -n com.android.chrome/com.google.android.apps.chrome.Main -d http://www.naver.com  -W
elif [ "${app}" = "facebook" ]; then
	am start -n com.facebook.katana/.activity.FbMainTabActivity -W
elif [ "${app}" = "camera" ]; then
	am start -a android.media.action.IMAGE_CAPTURE -W
elif [ "${app}" = "pubg" ]; then
	am start -n com.pubg.krmobile/com.epicgames.ue4.GameActivity -W
elif [ "${app}" = "investing" ]; then
	am start -n com.fusionmedia.investing/.ui.activities.SplashSplitter -W
elif [ "${app}" = "cnn" ]; then
	am start -n com.cnn.mobile.android.phone/.features.splash.SplashActivity -W
elif [ "${app}" = "spotify" ]; then
	am start -n com.spotify.music/.MainActivity -W
elif [ "${app}" = "mxplayer" ]; then
	am start -n com.mxtech.videoplayer.ad/.ActivityWelcomeMX -W
elif [ "${app}" = "kakaotalk" ]; then
	am start -n com.kakao.talk/.activity.SplashActivity -W	
elif [ "${app}" = "pokemongo" ]; then
	am start -n com.nianticlabs.pokemongo/com.nianticproject.holoholo.libholoholo.unity.UnityMainActivity -W
elif [ "${app}" = "dropbox" ]; then
	am start -n com.dropbox.android/.activity.DropboxBrowser -W
elif [ "${app}" = "twitch" ]; then
	am start -n tv.twitch.android.app/.core.LandingActivity -W
elif [ "${app}" = "home" ]; then
	am start -a android.intent.action.MAIN -c android.intent.category.HOME
else
	echo "Please enter Appname Kernel_mode Launching_state"
fi

echo 1 > /proc/sys/kernel/app_switch_fin
#cat /proc/vmstat > /data/launch/result_${app}/${kernel}/${state}/vmstat_end
#if [ "${kernel}" = "fastpf" ]; then
#	echo 0 > /proc/sys/kernel/fastpf
#fi
#echo 0 > /proc/sys/kernel/fastpf_analysis
#echo 0 > $debugfs/tracing/tracing_on
#echo 0 > /sys/kernel/debug/tracing/events/fastpf/enable

#dmesg > /data/launch/result_${app}/dmesg.txt

#./test_time
#cat /proc/stat > /data/launch/result_${app}/${kernel}/${state}/stat_end
#cat /proc/diskstats > /data/launch/result_${app}/${kernel}/${state}/diskstats_end

#cat $debugfs/tracing/per_cpu/cpu0/trace_pipe > ./result_${app}/${kernel}/${state}/core0.txt
#cat $debugfs/tracing/per_cpu/cpu1/trace_pipe > ./result_${app}/${kernel}/${state}/core1.txt
#cat $debugfs/tracing/per_cpu/cpu2/trace_pipe > ./result_${app}/${kernel}/${state}/core2.txt
#cat $debugfs/tracing/per_cpu/cpu3/trace_pipe > ./result_${app}/${kernel}/${state}/core3.txt
#cat $debugfs/tracing/per_cpu/cpu4/trace_pipe > ./result_${app}/${kernel}/${state}/core4.txt
#cat $debugfs/tracing/per_cpu/cpu5/trace_pipe > ./result_${app}/${kernel}/${state}/core5.txt
#cat $debugfs/tracing/per_cpu/cpu6/trace_pipe > ./result_${app}/${kernel}/${state}/core6.txt
#cat $debugfs/tracing/per_cpu/cpu7/trace_pipe > ./result_${app}/${kernel}/${state}/core7.txt

#echo nop > $debugfs/tracing/current_tracer
echo "end"

#cat /proc/vmstat > vmstat_chrome_end
#VAR="$(ps -el | grep chrome | cut -f ${1} -d ' ')"
#cat /proc/$VAR/maps > maps_chrome_end
#cat /proc/$VAR/status > status_chrome_end

#./test_time

#./a.out

#cat /proc/vmstat > vmstat_end

