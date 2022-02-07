#!/bin/bash

for var in {0..19}
do
	grep -nR Swap: ${var}.txt
done

