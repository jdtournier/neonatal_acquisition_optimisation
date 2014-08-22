function bvals_T2 = bval_as_function_of_T2 (N_bvals, n_coefs, param, T2)

% bvals_T2 = bval_as_function_of_T2 (N_bvals, n_coefs, param, T2)
% 
% with param obtained using preprocess_with_SVD

% for final display:
SNR = 15;
N_total = 400;

% TE used to acquire data:
param.TE_used = TE_for_bvalue(4000); 


N_bvals = N_bvals-1;
param.n_coefs = n_coefs;
bvals_T2 = [];

for n=1:numel(T2)
  param.T2 = T2(n);
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

  bvals_T2 = [ bvals_T2 bvals_opt ];
end


