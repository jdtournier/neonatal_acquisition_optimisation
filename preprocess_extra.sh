#!/bin/bash

for s in 0500 1000 2000 3000 4000; do
	amp2sh dwi_corrected.mif -lmax 8 -rician noise.mif -shell $s sh_b${n}.mif -force
done

