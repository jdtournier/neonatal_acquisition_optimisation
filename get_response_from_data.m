function  [ response, effect_sizes, weights ] = get_response_from_data (data, actual_bvals, bvals_desired)

% [ response, effect_sizes ] = get_response_from_data (data, actual_bvals, bvals_desired)
% 
% where:
%   - data is n_bvals x n_voxels data matrix
%   - bvals is vector of b-values corresponding to rows of data
%   - bvals_desired is vector b-values onto which to resample data before
%        estimating responses.

% scale data to mean b=0 signal and interpolate to bvals_desired:
data = double (interp1 (actual_bvals, data./mean(data(1,:)), bvals_desired, 'pchip'))';

% SVD factorization:
[weights,effect_sizes,response] = svd (data, 0); 

% for reference:
% if [U,S,V] = svd(data, 0); 
% data = U*S*V' = weights*effect_sizes*response';

% RMS effect sizes:
effect_sizes = diag(effect_sizes)./sqrt(size(data,1));
weights = weights(:,1:prod(size(actual_bvals)))' .* sqrt(size(data,1));

effect_sizes = effect_sizes(1:prod(size(actual_bvals)));
response = response(:,1:prod(size(actual_bvals)));


% ensure consistency in presentation:
try
  load ('../template_response.txt')
  for n = 1:size(response,2)
    if template_response(:,n)' * response(:,n) < 0
      response(:,n) = -response(:,n);
      weights(:,n) = -weights(:,n);
    end
  end
catch
  disp ('template response not found - skipping flip')
end
