collate_responses;
N=size(allR,1);

clf
plot_profiles (allR, 'none', 1:N, [ jet(N) ones(N,1) ]);
l = {};
for b=1:numel(bval), l{b} = sprintf('b=%d',bval(b)); end
legend (l, 'Location', 'NorthEastOutside')

printpdf (gcf, 'responses.pdf');
