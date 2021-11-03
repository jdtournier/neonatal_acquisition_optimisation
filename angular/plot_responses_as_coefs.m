collate_responses;

labels = {};
for n=1:size(allR, 2)
  labels{n} = [ '{\it l} = ' num2str(2*(n-1)) ];
end
R = abs(allR./(allR(1,1)*eval_ALP(0,0)));

clf
subplot (1,3,1);
plot (bval, R, '.-')
grid on
legend ( labels, 'Location', 'NorthEast')
xlabel ('b-value')
ylabel ('SH coefficient amplitude');

subplot (1,3,2);
plot (bval, R, '.-')
ylim ([ 0 0.5 ]);
grid on
xlabel ('b-value')

subplot (1,3,3);
plot (bval, R, '.-')
ylim ([ 0 0.1 ]);
grid on
xlabel ('b-value')

printpdf (gcf, 'response_coefs.pdf');

