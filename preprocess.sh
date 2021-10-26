#!/bin/bash

set -e
export MRTRIX_QUIET=1
force="-force"



for pat in pat[^_]*
do (
  cd $pat
  echo processing $pat...

  dwi2mask dwi.mif mask.mif $force
  dwiextract dwi.mif -bzero - | mrmath - mean -axis 3 - | mrcalc - 0.282094791773878 -div b0000.mif $force

  mrinfo dwi.mif -shell_bvalues > bvals.txt

  for s in $( mrinfo dwi.mif -shell_bvalues ); do
    if (( $s == 0 )); then continue; fi
    printf -v s '%04d' "$s"
    amp2sh dwi.mif -lmax 8 -shell $s - | mrconvert -coord 3 0 - b${s}.mif $force
  done

  mrcat b??00.mif -axis 3 dc.mif $force && rm -rf b??00.mif
  mrmath dc.mif mean -axis 3 - | mrthreshold - mask_tissue.mif $force
)
done


echo 'producing pat_all...'
mkdir -p pat_all
mrcat pat[^_]*/dc.mif -axis 2 pat_all/dc.mif $force
mrcat pat[^_]*/mask.mif -axis 2 pat_all/mask.mif $force
mrcat pat[^_]*/mask_tissue.mif -axis 2 pat_all/mask_tissue.mif $force
for pat in pat[^_]*; do
  cp $pat/bvals.txt pat_all
  break
done


