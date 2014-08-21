clear;
names = dir ('pat*');
cwd = pwd;

effect_sizes = [];
CNR = [];
nDW = [];
bvals = [];
for n = 1:size(names)
  disp (names(n).name)
  cd (names(n).name);

  files = dir ('CNR_opt_*');
  for n = 1:size(files)
    x = load (files(n).name);
    entry = files(n).name(1:end-4);
    if isfield (CNR, entry)
      CNR = setfield (CNR, entry, [ getfield(CNR,entry); x']);
    else
      CNR = setfield (CNR, entry, x');
    end
  end

  files = dir ('nDW_opt_*');
  for n = 1:size(files)
    x = load (files(n).name);
    entry = files(n).name(1:end-4);
    if isfield (nDW, entry)
      nDW = setfield (nDW, entry, [ getfield(nDW,entry); x']);
    else
      nDW = setfield (nDW, entry, x');
    end
  end

  files = dir ('bvals_opt_*');
  for n = 1:size(files)
    x = load (files(n).name);
    entry = files(n).name(1:end-4);
    if isfield (bvals, entry)
      bvals = setfield (bvals, entry, [ getfield(bvals,entry); x']);
    else
      bvals = setfield (bvals, entry, x');
    end
  end

  x = load ('effect_sizes.txt');
  effect_sizes = [ effect_sizes; x ];

  cd (cwd);
end

save -ascii effect_sizes.txt effect_sizes

l=fieldnames(CNR); 
for n=1:numel(l)
 x=getfield(CNR,l{n});
 save ([ l{n} '.txt' ], '-ascii', 'x'); 
end

l=fieldnames(nDW); 
for n=1:numel(l)
 x=getfield(nDW,l{n});
 save ([ l{n} '.txt' ], '-ascii', 'x'); 
end

l=fieldnames(bvals); 
for n=1:numel(l)
 x=getfield(bvals,l{n});
 save ([ l{n} '.txt' ], '-ascii', 'x'); 
end

