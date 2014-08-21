function [ data, mask, bvals, header ] = load_data (data_mif, mask_mif, bvals_file)

% [ data, mask, bvals ] = load_data (data_mif, mask_mif, bvals_file)

% read mask
header = read_mrtrix (mask_mif);
mask = logical (header.data);

% read data
header = read_mrtrix (data_mif);
data = vec (header.data, mask);

% enforce positivity of data vector
data(data<0) = 0; 

bvals = load (bvals_file);

header = rmfield (header, 'data');

