function noise_var = get_noise_variance (inv_responses, nDW)

% noise_var = get_noise_variance (inv_responses, nDW)
%
% Assumes total number of directions is 1. Multiply nDW by actual number of
% volumes for corresponding noise variance.

noise_var = (inv_responses.^2) * (1./nDW);

