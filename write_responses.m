function write_responses (param, weights_filename, responses_filename)

% write_responses (param, weights_filename)
%
% save the response weights to a mif file

param.header
image = param.header;
scale = 2*(sum(param.weights, 2) > 0)-1;
weights = bsxfun (@times, param.weights, scale);
image.data = unvec0 (weights, param.mask);
write_mrtrix (image, weights_filename);
R = param.response;
save -ascii responses.txt R;

