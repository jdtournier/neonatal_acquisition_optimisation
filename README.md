# Optimisation of DW scheme for neonatal dMRI


This contains the code used in this paper:

> A data-driven approach to optimising the encoding for multi-shell diffusion MRI with application to neonatal imaging. 
> Tournier JD, Christiaens D, Hutter J, Price AN, Cordero-Grande L, Hughes E, Bastiani M, Sotiropoulos SN, Smith SM,Rueckert D, Counsell SJ, Edwards AD, Hajnal JV
> [NMR in Biomedicine 33, e4348 (2020)](https://analyticalsciencejournals.onlinelibrary.wiley.com/doi/full/10.1002/nbm.4348).


## Instructions

### Prerequisites

To perform this analysis, you will need:
- a working installation of [MatLab](https://uk.mathworks.com/products/matlab.html)
- a working installation of [MRtrix3](https://www.mrtrix.org/)
- a Unix-like terminal with a working [BASH shell](https://www.gnu.org/software/bash/)



### Data preparation

Each input dataset is expected to reside in its own folder, named `patN`, with
`N` set to a unique numeric ID (e.g. `pat04`). Within each folder, the analysis
expects to find a single file called `dwi.mif`, containing the fully
preprocessed diffusion MRI acquisition for that subject, including the DW
scheme in its header, as verified by `mrinfo dwi.mif -dwgrad`
([`mrinfo`](https://mrtrix.readthedocs.io/en/latest/reference/commands/mrinfo.html)
is part of the [MRtrix3 software package](https://www.mrtrix.org/)).

All datasets are expected to have been acquired with _exactly_ the same
parameters (image dimensions, voxel size, DW scheme, TE, TR, etc.). 


The data should have already been preprocessed and corrected for artefacts
using standard recommendations. We recommend the pipeline suggested in the 
[MRtrix3 documentation](https://mrtrix.readthedocs.io/en/latest/fixel_based_analysis/mt_fibre_density_cross-section.html#pre-processsing-steps), which would normally include:

- [MP-PCA denoising using `dwidenoise`](https://mrtrix.readthedocs.io/en/latest/dwi_preprocessing/denoising.html)
- [Gibbs ringing correction using
  `mrdegibbs`](https://mrtrix.readthedocs.io/en/latest/reference/commands/mrdegibbs.html)
- [motion, eddy-current and susceptibility-induced distortion correction using
  `dwifslpreproc`](https://mrtrix.readthedocs.io/en/latest/dwi_preprocessing/dwifslpreproc.html)
- [bias field correction using ANTs via
  `dwibiascorrect`](https://mrtrix.readthedocs.io/en/latest/reference/commands/dwibiascorrect.html)

### Running the analysis

The analysis starts with generating some of the initial inputs using a BASH
script invoking a series of MRtrix3 commands (this assumes the current working
directory is the project root, where the `preprocess.sh` file is located):
```
$ ./preprocess.sh
```

Then from the MatLab prompt, with the same working directory:
```
>> process_all_pat
```

### Interpreting the outputs

The script will generate a lot of text files and PDF documents, for each
patient folder separately, and for the combined analysis with all patients
included (in the `pat_all` folder). The main outputs of interest are:

- `bvals_opt_Nb_Mcoeffs_T2_X.txt`: the optimal b-values for an acquisition
  consisting of `N` b-values (including the b=0), geared towards maximum
sensitivity to `M` coefficients, assuming a T2 of X ms. 

- `CNR_opt_Nb_Mcoeffs_T2_X.txt`: the optimal CNR of the `M` coefficients;
  filename otherwise follows convention above.

- `nDW_opt_Nb_Mcoeffs_T2_X.txt`: the optimal number of DW directions per shell;
  filename otherwise follows convention above.

- `responseX.pdf`: a plot of the singular vector of the `X`th coefficient

- `results_Nb_Mcoeffs_T2_X.txt`: a plot of all responses, with the optimal
  b-value per shell shown as vertical dashed lines; filename otherwise follows
  convention above.

- `weights.mif`: a 4D image of the coefficient weights, with each coefficient shown
  as a different volume. 

  



