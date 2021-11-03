
names = dir ('../pat*');
allR = [];
dumpR = [];

for n = 1:numel(names)
  if strcmp (names(n).name, 'pat_all'), continue, end
  R = load ([ '../' names(n).name '/all_responses_new.txt' ]);
  allR(:,:,n) = R;
  bval = load ([ '../' names(n).name '/bvals.txt' ]);

  for b=1:numel(bval)
    f = [ '../' names(n).name '/response-new-dump-' sprintf('%04d',bval(b)) '.txt' ];
    disp ([ 'loading ' f ]); 
    R = load (f);
    if numel(dumpR) & size(dumpR,2) < size(R,2)
      dumpR(1,size(R,2)) = 0;
    end

    if size(R,2) == 1
      dumpR(:,1,b,n) = R;
    else
      dumpR(:,:,b,n) = R;
    end
  end
end


allR = mean (allR, 3);
