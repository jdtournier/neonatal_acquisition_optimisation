clear;

param = preprocess_with_SVD ('dc.mif', 'mask_tissue.mif', 'bvals.txt', 0:100:4000);
T2 = 40:5:100;

bvals_3_T2 = bval_as_function_of_T2 (3, 3, param, T2);
bvals_4_T2 = bval_as_function_of_T2 (4, 4, param, T2);
bvals_5_T2 = bval_as_function_of_T2 (5, 5, param, T2);



