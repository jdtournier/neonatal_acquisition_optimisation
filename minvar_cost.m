function cost = minvar_cost (x, m)
  ndw = [ x 1-sum(x) ];
  if any(ndw<0), cost = inf; else cost = (m.^2) * (1./ndw'); end
