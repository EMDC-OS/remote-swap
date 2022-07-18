#!/bin/bash

for var in {0..19}
do
	grep -nR else ${var}.txt
done

