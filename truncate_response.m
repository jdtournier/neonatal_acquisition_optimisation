function [ inv_response, effect_sizes ] = truncate_response (response, effect_sizes, n_coefs)

% [ inv_response, effect_sizes ] = truncate_response (response, effect_sizes, n_coefs)

inv_response = pinv(response(:,1:n_coefs));
effect_sizes = effect_sizes(1:n_coefs);


