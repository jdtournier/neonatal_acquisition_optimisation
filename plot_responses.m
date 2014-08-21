function plot_responses (param, file_prefix)

% plot_responses (param, file_prefix)

scale = 2*(sum(param.weights, 2) > 0)-1;
for n = 1:size(param.response,2)
  plot (param.bvals_HR, scale(n)*param.response(:,n));
  grid on;
  printpdf (gcf, [ file_prefix num2str(n) ]);
end
