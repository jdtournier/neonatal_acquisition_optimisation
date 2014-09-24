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

(                                                                                                                                                                                         
  mkdir -p eddy
  cd eddy 
  mrconvert ../dwi.mif dwi.nii -stride 1:4 
  mrconvert ../mask.mif mask.nii -stride 1:3 
  mrinfo ../dwi.mif -export_grad_fsl bvecs bvals
  nvol=$(mrinfo dwi.nii -dim | cut -d ' ' -f 4)
  echo 0 1 0 0.05 > acqp.txt
  ( for n in $(seq 1 $nvol); do echo 1; done ) > index.txt
  
  export FSLOUTPUTTYPE=NIFTI
  eddy --imain=dwi --mask=mask --acqp=acqp.txt --index=index.txt --bvecs=bvecs --bvals=bvals --out=eddy_dwi --verbose

  mrconvert eddy_dwi.nii -fslgrad bvecs bvals -stride 2:4,1 ../dwi_corrected.mif -force

  cd ..
  rm -rf eddy
)   


dwi2noise dwi_corrected.mif - -shell 2000 | mrfilter - median -extent 5 noise.mif -force

dwiextract dwi_corrected.mif -bzero - | mrmath - mean -axis 3 - | mrcalc - 0.282094791773878 -div -force b0000.mif

for s in 0500 1000 2000 3000 4000; do
	amp2sh dwi_corrected.mif -lmax 8 -rician noise.mif -shell $s - | mrconvert -coord 3 0 - b${s}.mif -force
done

mrcat b??00.mif -axis 3 -force dc.mif


