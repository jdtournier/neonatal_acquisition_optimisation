
bvals_HR = 0:100:4000;


names = dir ('pat*')

ylabels = { 'subject 1', 'subject 2', 'subject 3', 'subject 4', 'subject 5', 'all subjects' };
R = load ([ names(1).name '/responses.txt']);

rows = numel(names);
cols = size(R,2);
allR = [];

for n = 1:rows
  names(n).name
  R = load ([ names(n).name '/responses.txt']);
  allR(:,:,end+1) = R;
  for m = 1:cols
    subplot (rows, cols, m + (n-1)*cols);
    plot (bvals_HR, R(:,m));
    set (gca, 'xtick', 0:1000:4000, 'ytick', -0.4:0.2:0.4)
    ylim ([-0.5 0.5])
    grid on
  end
end

for m = 1:size (R,2)
  subplot (rows, cols, (rows-1)*cols + m);
  h = plot (bvals_HR, squeeze(allR(:,m,:)));
  set (h(1:end-1), 'linestyle', '--');
  set (h(end), 'color', [0 0 0]);
  xlabel ('b-value (s/mm²)')
  set (gca, 'xtick', 0:1000:4000, 'ytick', -0.4:0.2:0.4)
  ylim ([-0.5 0.5])
  grid on
end


for n = 1:rows
  subplot (rows, cols, (n-1)*cols+1);
  ylabel ('amplitude');
  h = text (-2000, 0, ylabels{n});
  set (h, 'HorizontalAlignment', 'right', 'FontWeight', 'bold')
end

for n = 1:cols
  subplot (rows, cols, n);
  h = text (2000, 0.8, [ 'response ' num2str(n) ]);
  set (h, 'HorizontalAlignment', 'center', 'FontWeight', 'bold')
end

printpdf (gcf, 'all_responses.pdf');
