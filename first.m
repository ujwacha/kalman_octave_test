% I will attempt to write a kalman filter here for more experiments


T = 0.1;


projectile = [20;20;20;15;10;40;9.81];
transition_matrix = [1 0 0 T 0 0 0;
                          0 1 0 0 T 0 0;
                          0 0 1 0 0 T -0.5*(T^2);
                          0 0 0 1 0 0 0;
                          0 0 0 0 1 0 0;
                          0 0 0 0 0 1 -T;
                          0 0 0 0 0 0 1];



cov = [
       1, 0.0000005,   0.0000005,    0,    0,    0,    0;
       0.0000005,   1, 0.0000005,    0,    0,    0,    0;
       0.0000005,   0.0000005,   1,  0,    0,    0,    0;
       0,   0,   0,    0.00000001,  0.00, 0.0000, 0;
       0,   0,   0,    0.0000, 0.00000001,  0.0000, 0;
       0,   0,   0,    0.0000, 0.0000, 0.0000001,  0;
       0,   0,   0,    0,    0,    0,    0.00001;
  ];

%S = get_sensor_value(projectile, cov);

% Now is the time to kalman filer


Kf.A = [1, 0, 0, T, 0, 0, 0;
	0, 1, 0, 0, T, 0, 0;
	0, 0, 1, 0, 0, T, -0.5*(T^2);
	0, 0, 0, 1, 0, 0, 0;
	0, 0, 0, 0, 1, 0, 0;
	0, 0, 0, 0, 0, 1, -T;
	0, 0, 0, 0, 0, 0, 1];

Kf.C = [1 0 0 0 0 0 0;
	0 1 0 0 0 0 0;
	0 0 1 0 0 0 0;
  0 0 0 0 0 0 1];

Kf.V = [1 0 0 0;
	0 1 0 0;
	0 0 1 0;
  0 0 0 0.00001];

Kf.X = [0; 0; 0; 0; 0; 0; 9.81];


Kf.P = eye(7);

i = 1;



while (projectile(3,1) >= -1)

  projectile = predict_once(projectile, transition_matrix);



  data(i, 1) = projectile(1,1);

  data(i, 2) = projectile(2,1);

  data(i, 3) = projectile(3,1);



  Kf = kf_pre(Kf);
 % plot3(Kf.X(1,1), Kf.X(2,1), Kf.X(3,1));

  data(i, 4) = Kf.X(1,1);

  data(i, 5) = Kf.X(2,1);


  data(i, 6) = Kf.X(3,1);


  sv = get_sensor_value(projectile, cov);

  data(i,7) = sv(1,1);
  data(i,8) = sv(2,1);
  data(i,9) = sv(3,1);



  clf;
  plot3(data(:,1), data(:,2), data(:,3));
  hold on
  plot3(data(:,4), data(:,5), data(:,6));
  hold on
  plot3(data(:,7), data(:,8), data(:,9));

  % Now for the animation part
  % first print all the things you are supposed to on data

  %now keep on predicting and print
  kk = Kf;

  for j = (1:50)
   kk = kf_pre(kk);
   kkd(j,1) = kk.X(1,1);
   kkd(j,2) = kk.X(2,1);
   kkd(j,3) = kk.X(3,1);

   ellipsoid(kk.X(1,1),kk.X(2,1), kk.X(3,1) ,sqrt(kk.P(1,1)),sqrt(kk.P(2,2)),sqrt(kk.P(3,3)));

  end

  %now plot kkdata
  hold on
  plot3(kkd(:,1), kkd(:,2), kkd(:,3));
  pause(0.1)


  Kf = kf_cor(Kf, sv );
  i = i + 1;
end

