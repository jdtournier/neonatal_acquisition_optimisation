#!/bin/bash


mrcat 2014*_PHILIPS*/*WIPb{5,10,20,30,40}00SENSE  dwi.mif -force
dwi2mask dwi.mif mask.mif -force 

for b in 500 1000 2000 3000 4000 ; do 
  median=$(dwiextract 2014*_PHILIPS*/*WIPb${b}SENSE -bzero - | mrstats - -mask mask.mif -output median)
  mrcalc 2014*_PHILIPS*/*WIPb${b}SENSE $median -div 500 -mult dwi_b${b}.mif -force
  echo $b $median
done

mv dwi_b500.mif dwi_b0500.mif
mrcat dwi_b??00.mif -axis 3 dwi.mif -force
rm -f dwi_b*

dwi2noise dwi.mif - -shell 2000 | mrfilter - median -extent 5 noise.mif -force

dwiextract dwi.mif -bzero - | mrmath - mean -axis 3 - | mrcalc - 0.282094791773878 -div -force b0000.mif

for s in 0500 1000 2000 3000 4000; do
  amp2sh dwi.mif -lmax 8 -rician noise.mif -shell $s - | mrconvert -coord 3 0 - b${s}.mif -force
done

mrcat b??00.mif -axis 3 -force dc.mif


