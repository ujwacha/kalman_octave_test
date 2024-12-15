## usage: sensor_value = get_sensor_data (projectile, covariance)
##
##
function sensor_value = get_sensor_value(projectile, covariance)
  ## generate a random vector
  L = chol(covariance, "lower");

  for i = (1:7),
    A(i) = randn();
  end

  A = transpose(A);

  K = L * A;

  SV = projectile + K;

  sensor_value(1,1) = SV(1,1);
  sensor_value(2,1) = SV(2,1);
  sensor_value(3,1) = SV(3,1);

endfunction

