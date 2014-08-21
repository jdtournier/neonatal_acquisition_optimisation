function f = objective_function_postSVD (non_zero_bvals, param)

% function f = objective_function_postSVD (non_zero_bvals, param)
%   param is a struct with fields:
%     - data
%     - bvals
%     - n_coefs
%     - [ T2 ] - optional: if included, effect sizes will be attenuated according to
%                minimum TE achievable with given max bval - see TE_for_bvalue.m for 
%                details



if any (non_zero_bvals > param.bvals(end))
  f = Inf;
  return;
end

if any (non_zero_bvals <= 0)
  f = Inf;
  return;
end

% force b-values to remain sorted:
if any (non_zero_bvals(2:end) - non_zero_bvals(1:end-1) < 0) 
  f = Inf;
  return;
end


response = interp1 (param.bvals_HR, param.response, [0; non_zero_bvals], 'pchip');
[ inv_response, effect_sizes ] = truncate_response (response, param.effect_sizes, param.n_coefs);

if isfield (param, 'T2')
  effect_sizes = effect_sizes * exp((param.TE_used-TE_for_bvalue(max(non_zero_bvals)))/param.T2);
end

nDW = get_optimal_nDW (inv_response, effect_sizes);
noise_var = get_noise_variance (inv_response, nDW);
f = sum (noise_var ./ (effect_sizes.^2));

%disp ([ 'f = ' num2str(f) ', bvals = ' num2str(non_zero_bvals') ]);

