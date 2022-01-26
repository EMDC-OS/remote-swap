#!/bin/bash

for var in {0..9} 
do
	cat 2_cut_CC_dmesgb_${var}_01.txt >> 2_cut_CC_dmesgb_${var}_00.txt
	
	rm 2_cut_CC_dmesgb_${var}_01.txt
	mv 2_cut_CC_dmesgb_${var}_00.txt 2_cut_CC_dmesgb_${var}.txt
done
