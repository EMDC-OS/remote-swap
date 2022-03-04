#!/bin/bash

for var in {0..19}
do
	echo "===" ${var}.txt "==="
	grep -nR VmSwap: ${var}.txt -B 2
	echo "=============="
done

