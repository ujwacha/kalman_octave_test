# I will attempt to write a kalman filter here for more experiments


T = 0.1;


projectile = [0;0;0;15;10;40;9.81]; # state vector
transition_matrix = [1 0 0 T 0 0 0;
                          0 1 0 0 T 0 0;
                          0 0 1 0 0 T -0.5*(T^2);
                          0 0 0 1 0 0 0;
                          0 0 0 0 1 0 0;
                          0 0 0 0 0 1 -T;
                          0 0 0 0 0 0 1];



cov = [
       3, 0.0000005,   0.0000005,    0,    0,    0,    0;
       0.0000005,   3, 0.0000005,    0,    0,    0,    0;
       0.0000005,   0.0000005,   3,  0,    0,    0,    0;
       0,   0,   0,    0.00000001,  0.00, 0.0000, 0;
       0,   0,   0,    0.0000, 0.00000001,  0.0000, 0;
       0,   0,   0,    0.0000, 0.0000, 0.0000001,  0;
       0,   0,   0,    0,    0,    0,    0.00001;
  ];

#S = get_sensor_value(projectile, cov);

## Now is the time to kalman filer


Kf.A = [1, 0, 0, T, 0, 0, 0;
	0, 1, 0, 0, T, 0, 0;
	0, 0, 1, 0, 0, T, -0.5*(T^2);
	0, 0, 0, 1, 0, 0, 0;
	0, 0, 0, 0, 1, 0, 0;
	0, 0, 0, 0, 0, 1, -T;
	0, 0, 0, 0, 0, 0, 1];

Kf.C = [1 0 0 0 0 0 0;
	0 1 0 0 0 0 0;
	0 0 1 0 0 0 0];

Kf.V = [3 0 0;
	0 3 0;
	0 0 3];

Kf.X = [0; 0; 0; 15; 0; 40; 9.81];


Kf.P = eye(7);

i = 1;

Kf.X(3,1)



while (projectile(3,1) >= -1)

  projectile = predict_once(projectile, transition_matrix);



  data(i, 1) = projectile(1);

  data(i, 2) = projectile(2);

  data(i, 3) = projectile(3);



  Kf = kf_pre(Kf);
 # plot3(Kf.X(1,1), Kf.X(2,1), Kf.X(3,1));

  data(i, 4) = Kf.X(1,1);

  data(i, 5) = Kf.X(2,1);


  data(i, 6) = Kf.X(3,1);


  sv = get_sensor_value(projectile, cov);

  data(i,7) = sv(1,1);
  data(i,8) = sv(2,1);
  data(i,9) = sv(3,1);






  ### Now for the animation part
  # first print all the things you are supposed to on data

  ## now keep on predicting and print
  kk = Kf;

  #for i = (1:20)
   # kk = kf_pre(kk);
    #kkdata(i,1) = kk.X(1,1);
    #kkdata(i,2) = kk.X(2,1);
    #kkdata(i,3) = kk.X(3,1);
  #endfor
  ## now plot kkdata
  #hold on
  #clf
  #plot3(kkdata(:,1), kkdata(:,2), kkdata(:,3));
  #pause(0.1)


  Kf = kf_cor(Kf, sv );
  i = i + 1;

endwhile

  plot3(data(:,1), data(:,2), data(:,3));
  hold on
  plot3(data(:,4), data(:,5), data(:,6));
  hold on
  plot3(data(:,7), data(:,8), data(:,9));

