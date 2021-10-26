clear;


% edit as appropriate:

analysis_root = '/home/jdt13/data/KCL/dHCP_acq_test';
mrtrix_matlab_folder = '/home/jdt13/mrtrix3/matlab';



% set paths if required:

cd (analysis_root)
if ~any(ismember (analysis_root, regexp (path, pathsep, 'split')))
  addpath (analysis_root)
end
if ~any(ismember (mrtrix_matlab_folder, regexp (path, pathsep, 'split')))
  addpath (mrtrix_matlab_folder)
end


% analysis starts here:

names = dir ('pat*');
cwd = pwd;

effect_sizes = [];
CNR = [];
nDW = [];
bvals = [];
for n = 1:size(names)
  disp (names(n).name)
  cd (names(n).name);

  process_pat;

  cd (cwd);
end

