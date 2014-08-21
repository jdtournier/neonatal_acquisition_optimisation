N_bvals = 5;
n_coefs = 3;

% for final display:
SNR = 15;
N_total = 400;



N_bvals = N_bvals-1;
param.n_coefs = n_coefs;
[ param.data, param.mask, param.bvals ] = load_data ('dc.mif', 'mask.mif', 'bvals.txt');
non_zero_bvals = (1:N_bvals)'*param.bvals(end)./N_bvals;

bvals_opt = fminsearch (@(x) objective_function(x, param), non_zero_bvals, optimset ('Display', 'final'));

bvals_opt = [ 0; bvals_opt ];

% for information only:
[ response, effect_sizes ] = get_response_from_data (param.data, param.bvals, bvals_opt);
[ inv_response, effect_sizes ] = truncate_response (response, effect_sizes, n_coefs);
nDW = get_optimal_nDW (inv_response, effect_sizes);
noise_var = get_noise_variance (inv_response, N_total * nDW) ./ (SNR^2);
CNR = get_CNR (effect_sizes, noise_var);

disp ([ 'optimal b-values: ' num2str(bvals_opt') ]);
disp ([ 'assuming SNR = ' num2str(SNR) ' and N_total = ' num2str(N_total) ':' ]);
disp ([ '  nDW = ' num2str(N_total*nDW') ]);
disp ([ '  CNR = ' num2str(CNR') ]);


