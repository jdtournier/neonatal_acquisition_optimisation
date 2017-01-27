function bvals_opt = find_best_DW_scheme_postSVD (N_bvals, n_coefs, param)

% bvals_opt = find_best_DW_scheme_postSVD (N_bvals, n_coefs, param)
% 
% with param obtained using preprocess_with_SVD

% for final display:
SNR = 15;
N_total = 400;

% TE used to acquire data:
param.TE_used = TE_for_bvalue(4000); 


N_bvals = N_bvals-1;
param.n_coefs = n_coefs;

disp ('optimising b-values and nDW...');
current_fmin = Inf;
for n_restarts = 1:10
  non_zero_bvals = sort (rand (N_bvals,1) * param.bvals(end));
  [ bvals, fmin ] = fminsearch (@(x) objective_function_postSVD(x, param), non_zero_bvals, optimset ('MaxIter', 10000));
  disp ([ 'restart ' num2str(n_restarts) ': bvals = [ 0 ' num2str(bvals') ' ]: f = ' num2str(fmin) ]);
  if fmin < current_fmin
    bvals_opt = bvals;
    current_fmin = fmin;
  end
end

disp (' ')

bvals_opt = [ 0; bvals_opt ];

% for information only:
response = interp1 (param.bvals_HR, param.response, bvals_opt, 'pchip');
[ inv_response, effect_sizes ] = truncate_response (response, param.effect_sizes, param.n_coefs);
if isfield (param, 'T2')
  TE = TE_for_bvalue(max(bvals_opt));
  effect_sizes = effect_sizes * exp((param.TE_used-TE)/param.T2);
end
nDW = N_total * get_optimal_nDW (inv_response, effect_sizes);
noise_var = get_noise_variance (inv_response, nDW) ./ (SNR^2);
CNR = get_CNR (effect_sizes, noise_var);

disp ([ 'optimal b-values: [ ' num2str(bvals_opt') ' ] (f_min = ' num2str(current_fmin) ')']);
disp ([ 'assuming SNR = ' num2str(SNR) ' and N_total = ' num2str(N_total) ':' ]);
disp ([ '  nDW = ' num2str(nDW') ]);
disp ([ '  CNR = ' num2str(CNR') ]);

plot (param.bvals_HR, param.response(:,1:param.n_coefs))
grid on;
yr = get(gca, 'ylim');
h = line ([1;1]*bvals_opt', yr'*ones(1,size(bvals_opt,1)));
set (h, 'color', [0 0 0], 'linestyle', '--')
h = line (bvals_opt, yr(1)*ones(size(bvals_opt,1),1));
set (h, 'color', [0 0 0], 'linestyle', 'none', 'marker', '.', 'markersize', 25)
%hold on; plot (bvals_opt, response(:,1:param.n_coefs), 'o'); hold off

filename = [ '_' num2str(numel(bvals_opt)) 'b_' num2str(n_coefs) 'coefs' ];
if isfield (param, 'T2')
  filename = [ filename '_T2_' num2str(param.T2) 'ms'];
end

save ([ 'bvals_opt' filename '.txt' ], '-ascii', 'bvals_opt');
save ([ 'CNR_opt' filename '.txt' ], '-ascii', 'CNR');
save ([ 'nDW_opt' filename '.txt' ], '-ascii', 'nDW');
printpdf (gcf, [ 'results' filename ]);
