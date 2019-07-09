function param = preprocess_with_SVD (data_mif, mask_mif, bvals_file, bvals_interval)

% param = preprocess_with_SVD (data_mif, mask_mif, bvals_file, bvals_HR)

disp ('loading data...');
[ param.data, param.mask, param.bvals, param.header ] = load_data (data_mif, mask_mif, bvals_file);
disp ('upsampling data and computing SVD...');
param.bvals_HR = 0:bvals_interval:max(param.bvals);
[ param.response, param.effect_sizes, param.weights ] = get_response_from_data (param.data, param.bvals, param.bvals_HR);


