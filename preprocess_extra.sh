#!/bin/bash

dwi2fod dwi_corrected.mif -mask mask.mif -shell 2000 ../response_b2000.txt csd8_b2000.mif -lmax 8 -threshold 0.2 -force
dwi2fod dwi_corrected.mif -mask mask.mif -shell 3000 ../response_b3000.txt csd8_b3000.mif -lmax 8 -threshold 0.2 -force
dwi2fod dwi_corrected.mif -mask mask.mif -shell 4000 ../response_b4000.txt csd8_b4000.mif -lmax 8 -threshold 0.2 -force
b2000=$(mrconvert csd8_b2000.mif -coord 3 0 - | mrcalc csd8_b2000.mif - -div 0.282094791773878 -mult - )
b3000=$(mrconvert csd8_b3000.mif -coord 3 0 - | mrcalc csd8_b3000.mif - -div 0.282094791773878 -mult - )
mrconvert csd8_b4000.mif -coord 3 0 - | mrcalc csd8_b4000.mif - -div 0.282094791773878 -mult $b2000 -add $b3000 -add 3 -div odf.mif -force
for b in 0500 1000 2000 3000 4000; do
  amp2sh dwi_corrected.mif -lmax 8 -rician noise.mif -shell $b sh_b${b}.mif -force
  sh_response_coefs sh_b${b}.mif odf.mif -force responses_b${b}.mif
done
mrcat b0000.mif responses_b??00.mif -axis 3 -force full_responses.mif

