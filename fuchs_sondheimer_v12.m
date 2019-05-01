#******************************************************************************
#
# [1] 1950 - The conductivity of thin wires in a magnetic field
#
# note: 
#       during the integration, use the original formula from [1] -
#         BEFORE kicking out '1' to the front.
#       Octave v4.4.1.
#       Symmetry applied on the cross section. --> *2
#       Somehow phi_5 MUST be used if you don't want to use symmetry. This might
#         be used for other cross sectional geometry.
#
#******************************************************************************

clear all;
clc;
tic;

abstol = 1e-10; #default = 1e-10
reltol = 1e-6; #default = 1e-06

n = 1;
tol_up = 0.99999;  # 0.999999 gives error
tol_bottom = 1e-9;
#material = "Au3";   # 1 = Au, 2 = Pt, 3 = Ti, 4 = Pt/Ti/SiO2/Si, 5 = Ag

#for mat = {"Au4"}
#for mat = {"Au4", "Pt4", "Ti4", "PtTi4"}
for mat = {"Ag","Cu"}
  
material = mat{};

if (strcmp(material, "Ag"))
rho_bulk = 1.6; # rho_bulk = 1.6 uOhm.cm
h = 200e-9;
p = 0.0; # assumed
lambda = 57e-9;
w = linspace(50e-9,900e-6,n);
sigma = 0.385;
D_50 = 50e-9;  # 53.502+-20.374
R = 0.3;

elseif (strcmp(material, "Ag2"))
rho_bulk = 1.6; # rho_bulk = 1.6 uOhm.cm
h = 200e-9;
p = 0.0; # assumed
lambda = 57e-9;
w = [56e-9  58e-9  60e-9  62e-9  64e-9  ...
            68e-9  70e-9  72e-9         ...
     76e-9  78e-9  80e-9  82e-9  84e-9  ...
            88e-9  90e-9  92e-9         ...
     96e-9  98e-9  100e-9 102e-9 104e-9 ...
     116e-9 118e-9 120e-9 122e-9 124e-9 ...
            128e-9                      ...
     136e-9 138e-9 140e-9 142e-9 144e-9 ...
            148e-9                      ...
     156e-9 158e-9 160e-9 162e-9 164e-9 ...
            168e-9                      ...
                                 324e-9 ...
     326e-9 328e-9 330e-9 332e-9 334e-9 ...
     836e-9 838e-9 840e-9 842e-9 844e-9 ...
     ];  # n = 50;
#w = linspace(50e-9,900e-6,n);
sigma = 0.385;
D_50 = 50e-9;  # 53.502+-20.374
R = 0.3;

elseif (strcmp(material, "Cu"))
rho_bulk = 1.65; # rho_bulk = 1.75 uOhm.cm
h = 800e-9; # assumed, to fit
p = 0.0;
lambda = 39e-9;
w = linspace(50e-9,550e-9,n);
#w = [76.1e-9 86.1e-9 96.2e-9 140e-9 162e-9 251e-9 355e-9 520e-9];  # n = 8;
sigma = 0.2; # assumed
D_50 = 40e-9; # 40.808+-8.244
R = 0.25;

#*******************************************************************************
#*******************************************************************************
elseif (strcmp(material, "Au3"))
rho_bulk = 2.20; # rho_bulk = 2.20 uOhm.cm
h = 180e-9;
p = 0.5;
lambda = 40e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.2;
D_50 = 40e-9;   # 40.808+-8.244
R = 0.658;

elseif (strcmp(material, "Pt3"))
rho_bulk = 10.5; # rho_bulk = 10.5 uOhm.cm
h = 150e-9;
p = 1.0;  # assumed
lambda = 23e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.385;
D_50 = 23.212e-9; # 25+-10
R = 0.57;

elseif (strcmp(material, "Ti3"))
rho_bulk = 75; # rho_bulk = 75 uOhm.cm
h = 30e-9;
p = 1.0;  # assumed
lambda = 18e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.246;
D_50 = 31.045e-9;  # 32+-8
R = 0.17;

elseif (strcmp(material, "PtTi3"))
rho_bulk = 17.8; # rho_bulk = 17.8 uOhm.cm
h = 180e-9;
p = 0.5;  # no_info
lambda = 17.2e-9;
w = linspace(50e-9,2049e-9,n);
sigma = 0.2;
D_50 = 29.398e-9;  # 30+-6.1
R = 0.41;
#*******************************************************************************
#*******************************************************************************
elseif (strcmp(material, "Au4"))
rho_bulk = 2.20; # rho_bulk = 2.20 uOhm.cm
h = 180e-9;
p = 0.5;
lambda = 40e-9;
w = 20000e-9;
sigma = 0.2;
D_50 = 40e-9;   # 40.808+-8.244
R = 0.658;

elseif (strcmp(material, "Pt4"))
rho_bulk = 10.5; # rho_bulk = 10.5 uOhm.cm
h = 150e-9;
p = 1.0;  # assumed
lambda = 23e-9;
w = 20000e-9;
sigma = 0.385;
D_50 = 23.212e-9; # 25+-10
R = 0.57;

elseif (strcmp(material, "Ti4"))
rho_bulk = 75; # rho_bulk = 75 uOhm.cm
h = 30e-9;
p = 1.0;  # assumed
lambda = 18e-9;
w = 20000e-9;
sigma = 0.246;
D_50 = 31.045e-9;  # 32+-8
R = 0.17;

elseif (strcmp(material, "PtTi4"))
rho_bulk = 17.8; # rho_bulk = 17.8 uOhm.cm
h = 180e-9;
p = 0.5;  # no_info
lambda = 17.2e-9;
w = 20000e-9;
sigma = 0.2;
D_50 = 29.398e-9;  # 30+-6.1
R = 0.41;
#*******************************************************************************
#*******************************************************************************


else
# do nothing
endif

h_nm = h * 1e9;

for i = 1:n
  # limit for theta
  p2    = pi*tol_up;
  p1    = 1*tol_bottom;
  
  # limit for phi
  phi_2    = @(x,y) atan(x./(h-y)) + (pi/2);
  phi_1    = @(x,y) atan((h-y)./(w(i)-x));
  
  # limit for y
  p6    = h*tol_up;
  p5    = 1*tol_bottom;
  
  # limit for x
  p8(i) = w(i).*tol_up;
  p7(i) = 1.*tol_bottom;
    
  f1 = @(x, y, phi, theta) exp(-(h-y)./(lambda .*sin(theta) .*sin(phi)));  
  f3 = @(x, y, phi, theta) sin(theta).*cos(theta).^2 .* (1 - f1(x, y, phi, theta));
  
  #[q1(i)] = integral( @(x) (integral3( @(y, phi, theta) f3(x, y, phi, theta), p5, p6, @(y) phi_1(x,y), @(y) phi_2(x,y), p1, p2, 'AbsTol',abstol, 'RelTol',reltol)), p7(i), p8(i), 'ArrayValued',true);
  [q1(i)] = integral( @(x) arrayfun( @(x) (integral3( @(y, phi, theta) f3(x, y, phi, theta), p5, p6, @(y) phi_1(x,y), @(y) phi_2(x,y), p1, p2)), x), p7(i), p8(i) );
  ratio_FS1(i) = 1 *3 / (4*pi*h*w(i)) * q1(i);
end;


for i = 1:n
  # limit for theta
  p2    = pi*tol_up;
  p1    = 1*tol_bottom;
  
  # limit for phi
  phi_3    = @(x,y) atan(y./x) + (pi/1);
  phi_2    = @(x,y) atan(x./(h-y)) + (pi/2);
  
  # limit for y
  p6    = h*tol_up;
  p5    = 1*tol_bottom;
  
  # limit for x
  p8(i) = w(i).*tol_up;
  p7(i) = 1.*tol_bottom;
    
  f1 = @(x, y, phi, theta) exp( -(-x)./(lambda .*sin(theta) .*cos(phi)));  
  f3 = @(x, y, phi, theta) sin(theta).*cos(theta).^2 .* (1 - f1(x, y, phi, theta));
  
  #[q2(i)] = integral( @(x) (integral3( @(y, phi, theta) f3(x, y, phi, theta), p5, p6, @(y) phi_2(x,y), @(y) phi_3(x,y), p1, p2, 'AbsTol',abstol, 'RelTol',reltol)), p7(i), p8(i), 'ArrayValued',true);
  [q2(i)] = integral( @(x) arrayfun( @(x) (integral3( @(y, phi, theta) f3(x, y, phi, theta), p5, p6, @(y) phi_2(x,y), @(y) phi_3(x,y), p1, p2)), x), p7(i), p8(i) );
  ratio_FS2(i) = 1 *3 / (4*pi*h*w(i)) * q2(i);
end;


for i = 1:n
ratio_FS(i)  = (ratio_FS1(i) + ratio_FS2(i)) * 2;  # symmetry applied : *2
rho_FS(i)  = rho_bulk / ratio_FS(i);
rho_s(i) = rho_FS(i) - rho_bulk;
end;

#{
#subplot (rows, cols, index)
subplot(2,2,1)
plot (w,ratio_FS1);
xlabel ("w");
ylabel ("ratio_FS1", "Interpreter", "none");

subplot(2,2,2)
plot (w,ratio_FS2);
xlabel ("w");
ylabel ("ratio_FS2", "Interpreter", "none");

subplot(2,2,3)
plot (w,ratio_FS);
title ("ratio_FS=ratio_FS1+ratio_FS2", "Interpreter", "none")
xlabel ("w");
ylabel ("rho_bulk/rho_FS=ratio_FS", "Interpreter", "none");

subplot(2,2,4)
plot (w,rho_FS);
title ("rho_FS=rho_bulk/ratio_FS", "Interpreter", "none")
xlabel ("w");
ylabel ("rho_FS", "Interpreter", "none");
#}
#******************************************************************************
# To export to a file
result_matrix = transpose([1:i; w; ratio_FS1; ratio_FS2; ratio_FS; rho_FS; rho_s; rho_bulk*ones(1,i)]);
dlmwrite (sprintf('fs_v12_%s_%dnm_%d.csv', material, h_nm, n), result_matrix); 
#
#******************************************************************************

endfor;

elapsed_time = toc;
hours_time = floor(elapsed_time/3600);
minutes_time = floor((elapsed_time - (hours_time*3600))/60);
seconds_time = rem  ((elapsed_time - (hours_time*3600)),60);
elapsed_time_formated = [hours_time minutes_time seconds_time];

disp_elapsed_time_formated = elapsed_time_formated;
disp_elapsed_time = elapsed_time;
disp_w = w;
disp_h = h;
disp_ratio_FS = ratio_FS;
disp_rho_FS = rho_FS;
disp_material = material;