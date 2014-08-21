function CNR = get_CNR (effect_sizes, noise_var)

% CNR = get_CNR (effect_sizes, noise_var)
%
% Assumes SNR of input data is 1. Divide noise_var by square of SNR for
% relevant results.

CNR = effect_sizes ./ sqrt(noise_var);

