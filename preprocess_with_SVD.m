function param = preprocess_with_SVD (data_mif, mask_mif, bvals_file, bvals_HR)

% param = preprocess_with_SVD (data_mif, mask_mif, bvals_file, bvals_HR)

disp ('loading data...');
[ param.data, param.mask, param.bvals, param.header ] = load_data (data_mif, mask_mif, bvals_file);
disp ('upsampling data and computing SVD...');
[ param.response, param.effect_sizes, param.weights ] = get_response_from_data (param.data, param.bvals, bvals_HR);
param.bvals_HR = bvals_HR;


