function f = objective_function (non_zero_bvals, param)

% function f = objective_function (non_zero_bvals, param)
%   param is a struct with fields:
%     - data
%     - bvals
%     - n_coefs



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


[ response, effect_sizes ] = get_response_from_data (param.data, param.bvals, [ 0; non_zero_bvals ]);
[ inv_response, effect_sizes ] = truncate_response (response, effect_sizes, param.n_coefs);
nDW = get_optimal_nDW (inv_response, effect_sizes);
noise_var = get_noise_variance (inv_response, nDW);
f = sum (noise_var ./ (effect_sizes.^2));

disp ([ 'f = ' num2str(f) ', bvals = ' num2str(non_zero_bvals') ]);

