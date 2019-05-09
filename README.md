# Fuchs-Sondheimer
The code calculates the increased resistivity in thin metal wires due to the surface scattering effect.
This phenomenon is relevant not only in memristor crossbar structure but also in the micro/nanoelectronic in general.
The material properties are hardcoded into the script.
The result is saved into a *.csv file.

column_1   column_2   column_3   column_4    column_5   column_6  column_7  column_8
index      w          ratio_FS1  ratio_FS2   ratio_FS   rho_FS    rho_s     rho_bulk

[1:i; w; ratio_FS1; ratio_FS2; ratio_FS; rho_FS; rho_s; rho_bulk*ones(1,i)]

Octave v4.4.1

E. H. Sondheimer, Advances in Physics 1, 1 (1952).
https://doi.org/10.1080/00018735200101151

K. Fuchs, Proc. Cambridge Philos. Soc. 34, 100 (1938). 
https://doi.org/10.1017/s0305004100019952

A. F. Mayadas and M. Shatzkes, Phys. Rev. B 1, 1382 (1970)
https://doi.org/10.1103/physrevb.1.1382

R. G. Chambers, Proc. Roy. Soc. A 202, 378 (1950). 
https://doi.org/10.1098/rspa.1950.0107
