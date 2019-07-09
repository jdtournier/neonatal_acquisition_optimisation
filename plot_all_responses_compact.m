
bvals_HR = 0:100:4000;


names = dir ('pat*')

ylabels = { 'subject 1', 'subject 2', 'subject 3', 'subject 4', 'subject 5', 'all subjects' };

allR = [];

for n = 1:numel(names)
  names(n).name
  R = load ([ names(n).name '/responses.txt']);
  allR(:,:,n) = R;
end

rows=2;
cols=3;

for n=1:size(allR,2)
  subplot (rows, cols, n)
  h = plot (bvals_HR, squeeze(allR(:,n,:)));
  set (h(end), 'color', [0 0 0], 'LineStyle', ':', 'LineWidth', 2);
  ylabel ('amplitude');
  xlabel ('b-value (s/mm²)')
  title ([ 'response ' num2str(n) ]);
  set (gca, 'xtick', 0:1000:4000, 'ytick', -0.4:0.2:0.4)
  ylim ([-0.5 0.5])
  grid on
  if n == cols
    legend (ylabels, 'Location', 'SouthEast');
  end
end

printpdf (gcf, 'all_responses_compact.pdf');

