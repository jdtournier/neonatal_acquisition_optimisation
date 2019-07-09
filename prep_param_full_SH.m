function param = prep_param_full_SH (n_coefs, n_SH, param)

param.n_coefs = n_SH * n_coefs;
param.response = [];
for l=1:n_SH
  param.response = [param.response param.R(1:n_coefs,:,l)' ];
end
param.effect_sizes = repmat (param.effect_sizes(1:n_coefs), 1, n_SH);

