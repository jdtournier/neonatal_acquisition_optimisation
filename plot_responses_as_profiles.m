collate_responses;

plot_profiles (allR, 'none', 1:6, [0.15*(0:5)'*[1 1 1] ones(6,1)]);
legend ({ 'b=0', 'b=500', 'b=1000', 'b=2000', 'b=3000', 'b=4000' }, 'Location', 'NorthEastOutside')

printpdf (gcf, 'responses.pdf');
