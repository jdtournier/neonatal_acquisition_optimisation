function h = plot_profiles (R, normalisation, indices, colours, show_unity)

% function plot_profiles (R, normalisation, indices)
%
%    if matrix: each row should correspond to a separate 
%               vector of SH coefficients
%
% normalisation [optional]: normalisation method (default = none).
%       'none': no normalisation (default)
%       'max': to maximum amplitude
%       'L2': to L2 norm of SH coefficients
%       'l0': to l=0 SH coefficient
%       vector: normalise each row of SH coefficients 
%               by corresponding entry in vector
% 
% indices [optional]: indices of rows to display (default: all)
% 
% colours [optional]: colours of rows to display, as a 4xN matrix,
%       where each row consists of red, green, blue, and line thickness.


t = (0:0.01:2*pi)';
SH = [];
m = [];

for n = 1:size(R,2)
  X = eval_ALP(2*(n-1), t);
  SH = [ SH; X(((size(X,1)+1)/2),:) ];
end

if ~exist ('indices')
  indices = 1:size(R,1);
end

if ~exist ('colours')
  colours = repmat ([0 0 0 1], size(R,1), 1);
end

cla
hold on
for i = 1:prod(size(indices))
  n = indices(i);
  
  A = SH' * R(n,:)';

  if exist ('normalisation')
    if ischar (normalisation)
      if strcmp(normalisation, 'max')
        A = A./max(A);
      elseif strcmp (normalisation, 'L2')
        A = A./sqrt(sum(R(n,:).^2));
      elseif strcmp (normalisation, 'l0')
        A = A./R(n,1);
      end
    else
     %normalisation(n)
     %R(n,:)
      A = A./normalisation(n);
    end
  end
      
  h(n) = polar (t+pi/2, A);
  set(h(n), 'color', colours(n,1:3), 'linewidth', colours(n,4));
end

if exist ('show_unity')
  h2 = polar (t+pi/2, ones(size(t)));
  set(h2, 'color', [0 0 0], 'linewidth', 1, 'linestyle', ':');
end

%h2 = line([0 -2; 0 2], [-2 0; 2 0]);
%set (h2, 'color', [0 0 0], 'linestyle', ':');


set(gca, 'visible', 'off');

daspect ([1 1 1]);

