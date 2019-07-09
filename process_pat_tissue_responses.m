clear param;

param.bvals_HR = 0:100:4000;
[ param.full_responses, param.weights, param.mask, param.bvals, param.header ] = load_response_data ('full_responses.mif', 'weights.mif', 'mask_tissue.mif', 'bvals.txt');
param.R = get_tissue_response_from_data (param.full_responses, param.weights, param.bvals, param.bvals_HR);

load effect_sizes.txt
param.effect_sizes = effect_sizes;
param.T2 = 100;

P = prep_param_full_SH (3, 3, param);
find_best_DW_scheme_postSVD (param.n_coefs, param.n_coefs, P);


