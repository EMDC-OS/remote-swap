#!/bin/bash

for var in {0..19}
do
	grep -nR Cached ${var}.txt | grep -v Swap
done

