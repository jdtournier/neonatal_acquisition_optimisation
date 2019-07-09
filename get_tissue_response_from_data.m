function  tissue_responses = get_tissue_response_from_data (full_responses, weights, actual_bvals, bvals_desired)

% [ response, effect_sizes ] = get_tissue_response_from_data (full_responses, actual_bvals, bvals_desired)
% 
% where:
%   - full_responses is n_bvals x n_voxels full_responses matrix
%   - weights is the weights image as determined from DC analysis
%   - bvals is vector of b-values corresponding to rows of data
%   - bvals_desired is vector b-values onto which to resample data before
%        estimating responses.

% scale data to mean b=0 signal and interpolate to bvals_desired:

for l=1:size(full_responses,3)
  responses = double (interp1 (actual_bvals, full_responses(:,:,l)', bvals_desired, 'pchip'))';
  tissue_responses(:,:,l) = weights' \ responses;
end


