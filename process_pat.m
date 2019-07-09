T2 = [ 60 80 100 0]; % last value ignored
%T2 = [ 100 150 200 0]; % last value ignored

param = preprocess_with_SVD ('dc.mif', 'mask_tissue.mif', 'bvals.txt', 100);
write_responses (param, 'weights.mif');
plot_responses (param, 'response_');
e = param.effect_sizes';
save -ascii effect_sizes.txt e;

for n = 1:numel(T2)
  find_best_DW_scheme_postSVD (3,3,param);
  %find_best_DW_scheme_postSVD (4,3,param);
  find_best_DW_scheme_postSVD (4,4,param);
  %find_best_DW_scheme_postSVD (5,3,param);
  %find_best_DW_scheme_postSVD (5,4,param);
  find_best_DW_scheme_postSVD (5,5,param);

  param.T2 = T2(n);
end
