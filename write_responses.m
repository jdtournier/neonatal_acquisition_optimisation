function write_responses (param, filename)

% write_responses (param, filename)
%
% save the response weights to a mif file

param.header
image = param.header;
scale = 2*(sum(param.weights, 2) > 0)-1;
weights = bsxfun (@times, param.weights, scale);
image.data = unvec0 (weights, param.mask);
write_mrtrix (image, filename);

