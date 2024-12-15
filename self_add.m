function [ret]  = self_add (x)
  if isvector(x)
    ret = x + x;
  else
    error("self_add expects a vector as an argument");
  end
endfunction
