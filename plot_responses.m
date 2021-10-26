function plot_responses (param, file_prefix)

% plot_responses (param, file_prefix)

for n = 1:size(param.response,2)
  h = plot (param.bvals_HR, param.response(:,n));
  grid on;
  %set (gca, 'color', 'none', 'xcolor', 'white', 'ycolor', 'white');
  %set(findobj('type', 'line'), 'color', 'white');
  %set(findobj('type', 'text'), 'color', 'white');
  %set (h, 'color', [1 1 0], 'linewidth', 2);
  %set(gcf, 'invertHardcopy', 'off', 'color', 'none')
  printpdf (gcf, [ file_prefix num2str(n) ]);
end
