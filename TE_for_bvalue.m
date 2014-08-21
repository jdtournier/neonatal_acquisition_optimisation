function TE = TE_for_bvalue (bmax)

% TE = TE_for_bvalue (bmax)
%
% time specified in milliseconds
%
% Assumes fixed values for G_max, t_90, t_180 and t_RO
% Modify in m-file if needed


G_max = 80;
t_90 = 5;
t_180 = 5;
t_RO = 15;
gamma = 2.675222e8;

% remember:
%   b is in s/mm^2
%   G is in mT/m
%   times are in ms
%   gamma is in rad/sT
%
% therefore:
%   bmax => bmax * 1e3/(1e-3)^2 => bmax * 1e9
%   G_max => G_max * 1e-3
%   gamma => gamma * 1e-3
% ==> overall, bmax/(gamma^2*G_max^2) should be scaled by 1e21

c = [ 1 3*(t_RO-t_90+2*t_180)/2 0 -3e21*bmax/(2*gamma^2*G_max^2) ];
r = roots (c);
delta = r(find(r>0));

TE = 2*(t_180 + delta + t_RO);

