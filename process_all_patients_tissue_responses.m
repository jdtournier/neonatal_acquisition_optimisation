clear;
names = dir ('pat*');
cwd = pwd;

effect_sizes = [];
CNR = [];
nDW = [];
bvals = [];
for n = 1:size(names)
  disp (names(n).name)
  cd (names(n).name);

  process_pat_tissue_responses;

  cd (cwd);
end


