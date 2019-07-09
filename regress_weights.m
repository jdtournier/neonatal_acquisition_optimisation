function [ tissue_responses ] = regress_weights (full_responses, weights)

% [ tissue_responses ] = regress_weights (full_responses, weights)

tissue_responses = weights' \ full_responses';

