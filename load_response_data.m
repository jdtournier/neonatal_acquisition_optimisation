function [ full_responses, weights, mask, bvals, header ] = load_response_data (responses_mif, weights_mif, mask_mif, bvals_file)

% [ full_responses, weights, mask, bvals, header ] = load_response_data (responses_mif, weights_mif, mask_mif, bvals_file)

% read mask
header = read_mrtrix (mask_mif);
mask = logical (header.data);

% read responses:
header = read_mrtrix (responses_mif);
response = vec (header.data, mask);

header = rmfield (header, 'data');

% read weights:
header = read_mrtrix (weights_mif);
weights = vec (header.data, mask);

bvals = load (bvals_file);

nsh = (size(response,1)-1) / (prod(size (bvals))-1);
nb = prod(size(bvals));
full_responses = [];

for n = 1:nb

  full_responses(:,1,:) = [ response(1,:)' zeros(size(response,2),nsh-1) ];
  for b=2:nb
    full_responses(:,b,:) = response((2+nsh*(b-2)):(1+nsh*(b-1)),:)' ;
  end

end

full_responses = full_responses./mean(full_responses(:,1,1));



