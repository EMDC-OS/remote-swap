#!/bin/bash

	echo ========googlemaps=======
for var in {0..8}
do
	cat ${var}.txt | grep "MapsActivity" -A 5 | grep Time | head -n 1
done


	echo ========youtube=======
for var in {0..8}
do
	cat ${var}.txt | grep "youtube.app.watchwhile" -A 5 | grep Time | head -n 1
done


	echo ========candycrush=======
for var in {0..8}
do
	cat ${var}.txt | grep "CandyCrushSagaActivity" -A 5 | grep Time | head -n 1
done


	echo ========chrome=======
for var in {0..8}
do
	cat ${var}.txt | grep "apps.chrome.Main" -A 5 | grep Time | head -n 1
done


	echo ========twitter=======
for var in {0..8}
do
	cat ${var}.txt | grep "com.twitter.app.main.MainActivity" -A 5 | grep Time | head -n 1
done


	echo ========angrybirds=======
for var in {0..8}
do
	cat ${var}.txt | grep "com.rovio.baba/com.unity3d" -A 5 | grep Time | head -n 1
done


	echo ========gmail=======
for var in {0..8}
do
	cat ${var}.txt | grep "ConversationListActivity" -A 5 | grep Time | head -n 1
done


	echo ========instagram=======
for var in {0..8}
do
	cat ${var}.txt | grep "MainTabActivity" -A 5 | grep Time | head -n 1
done



	echo ========clashroyale=======
for var in {0..8}
do
	cat ${var}.txt | grep "titan.GameApp" -A 5 | grep Time | head -n 1
done


