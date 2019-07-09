function  [ response, effect_sizes, weights ] = get_full_responses_from_data (data)

% [ response, effect_sizes ] = get_full_responses_from_data (data)
% 
% where:
%   - data is n_bvals x n_voxels data matrix
%   - bvals is vector of b-values corresponding to rows of data

% SVD factorization:
[weights,effect_sizes,response] = svd (double (data./mean(data(1,:)))', 0); 

% for reference:
% if [U,S,V] = svd(data, 0); 
% data = U*S*V' = weights*effect_sizes*response';

% RMS effect sizes:
effect_sizes = diag(effect_sizes)./sqrt(size(data,1));
weights = weights' .* sqrt(size(data,1));

