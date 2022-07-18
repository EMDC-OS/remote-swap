#!/bin/bash

	echo ========googlemaps 0=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "MapsActivity" -A 5 | grep Time | head -n 1
done


	echo ========youtube 1=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "youtube.app" -A 5 | grep Time | head -n 1
done


	echo ========instagram 2=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "MainTabActivity" -A 5 | grep Time | head -n 1
done
	

	echo ========twitter 3=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "com.twitter.app.main.MainActivity" -A 5 | grep Time | head -n 1
done


	echo ========candycrush 4=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "CandyCrushSagaActivity" -A 5 | grep Time | head -n 1
done



	echo ========angrybirds 5=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "com.rovio.baba/com.unity3d" -A 5 | grep Time | head -n 1
done

	echo ========chrome 6=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "apps.chrome.Main" -A 5 | grep Time | head -n 1
done


	echo ========gmail 7=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "ConversationListActivity" -A 5 | grep Time | head -n 1
done





	echo ========clashroyale 8=======
for var in {0..8}
do
	echo -n $var: 
	cat ${var}.txt | grep "titan.GameApp" -A 5 | grep Time | head -n 1
done


