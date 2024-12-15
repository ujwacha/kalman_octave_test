## usage: Kfi = kf_pre (Kf)
##
##
function Kfi = kf_pre (Kf)
  Kfi = Kf;
  Kfi.X = Kf.A * Kf.X;
  Kfi.P = Kf.A * Kf.P * transpose(Kf.A); # no noise here for now
endfunction
