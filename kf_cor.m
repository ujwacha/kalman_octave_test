
function Kfi = kf_cor (Kf, sensors)
  Kfi = Kf;
  Ybar = sensors - (Kf.C * Kf.X);
  S = (Kf.C * Kf.P * transpose(Kf.C)) + Kf.V;
  K = Kf.P * transpose(Kf.C) * inv(S);

  Kfi.X = Kf.X + K*Ybar;
  Kfi.P = Kf.P - K * Kf.C * Kf.P;

end