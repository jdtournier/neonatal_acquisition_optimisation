#!/bin/bash

bval_for_peak_estimation=2000

set -e
export MRTRIX_QUIET=1
force="-force"


for p in ../pat[^_]*; do (
  
  echo processing $p
  cd $p
  echo 100 -50 20 -5 > response-generic.txt
  dwi2fod csd -mask mask.mif dwi.mif -shell $bval_for_peak_estimation response-generic.txt csd8.mif $force
  sh2peaks csd8.mif -num 2 -mask mask.mif peaks-[].mif $force
  mrcalc peaks-0.mif 2 -pow peaks-1.mif 2 -pow peaks-2.mif 2 -pow -add -add peaks-3.mif 2 -pow peaks-4.mif 2 -pow peaks-5.mif 2 -pow -add -add -div peak-ratio.mif $force
  mrthreshold peak-ratio.mif -top 200 sf.mif $force
  for b in $(cat bvals.txt); do
    if (( $b == 0 )); then continue; fi
    printf -v b '%04d' "$b"
    amp2sh -shell $b dwi.mif - |\
    sh2response - sf.mif peaks-"[0:2]".mif response-new-${b}.txt -dump response-new-dump-${b}.txt $force
  done
  echo $(mrconvert dc.mif -coord 3 0 - | mrstats - -mask sf.mif -output mean) 0 0 0 0 > response-new-0000.txt
  mrconvert dc.mif -coord 3 0 - | mrdump - -mask sf.mif response-new-dump-0000.txt $force


  cat response-new-????.txt | grep -v '^#.*' > all_responses_new.txt
) done

