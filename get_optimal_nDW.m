function nDW = get_optimal_nDW (inv_responses, effect_sizes)

% nDW = get_optimal_nDW (inv_responses, effect_sizes)
%
% optimal nDW obtained by minimising sum of variances normalised to
% corresponding effect sizes

nDW = sqrt( (inv_responses.^2)' * (1./effect_sizes.^2) );
nDW = nDW ./ sum(nDW);
