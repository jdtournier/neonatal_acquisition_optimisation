function allR = write_tissue_responses (responses, bvals)

nsh = (size(responses,2)-1) / (prod(size (bvals))-1)
nb = (size(responses,2)-1)/nsh
allR = [];

for n = 1:size(responses,1)

  R = [ responses(n,1) zeros(1,nsh-1) ];
  for b=1:nb
    R = [ R; responses(n,(2+nsh*(b-1)):(1+nsh*b)) ];
  end

  save (['tissue_response-' num2str(n) '.txt'], '-ascii', 'R');
  allR(:,:,n) = R;

end

