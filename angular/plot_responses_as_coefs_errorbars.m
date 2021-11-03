collate_responses;

labels = {};
for n=1:size(allR, 2)
  labels{n} = [ '{\it l} = ' num2str(2*(n-1)) ];
end

nvox = size (dumpR,1);
nl = size (dumpR,2);
nb = size (dumpR,3);
nsubj = size (dumpR,4);

% normalise to total power in response across l=0 curve:
%b0norm=repmat (sqrt(sum(dumpR(:,1,:,:).^2,3)), [ 1 nl nb 1 ]);
b0norm=repmat (dumpR(:,1,1,:), [ 1 nl nb 1 ]);
dumpRnorm = dumpR./(eval_ALP(0,0)*b0norm);
X = permute(dumpRnorm, [ 4 1 2 3 ]);
X = abs (reshape (X, [], nl, nb));

subplot (1,2,1);
errorbar (bval'*ones(1,nl), squeeze(mean(X,1))', squeeze(std(X,[],1))')
xlim ([ -100 4100 ]);
grid on
legend ( labels, 'Location', 'NorthEast')
xlabel ('b-value')
ylabel ('SH coefficient amplitude');

subplot (1,2,2);
errorbar (bval'*ones(1,nl), squeeze(mean(X,1))', squeeze(std(X,[],1))')
xlim ([ -100 4100 ]);
ylim ([ 0 0.5 ]);
grid on
xlabel ('b-value')

printpdf (gcf, 'response_coefs_errorbars.pdf');


