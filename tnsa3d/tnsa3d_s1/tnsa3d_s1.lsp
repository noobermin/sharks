[Title]
simulation_title "LSP TNSA stage 1, I = 1.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.5000e-04
 time_step_ns 5.0000e-08
;Restart
maximum_restart_dump_time 23.75
;Parallel Processing
 balance_interval_ns 0
 load_balance_flag OFF
;Field Solution and Modification
 time_bias_coefficient 0
 time_bias_iterations 1
;Implicit Field Algorithm
 error_current_filtering_parameter 0.95
 implicit_iterations 10
 implicit_tolerance 1.e-5
;Matrix Solution Algorithm
 preconditioner JACOBI
 linear_solution GMRES
;Fluid Physics Algorithm
 fluid_electron_streaming_factor 0.1
 fluid_ion_streaming_factor 0.01 ;Tony insists this is 0.01 instead of 0.005
 flux_limit_fraction 0.2
;(Diagnostic Output) Flags
 dump_current_density_flag OFF
 dump_fields_flag ON
 dump_scalars_flag ON
 dump_plasma_quantities_flag ON
 dump_velocities_flag OFF
 dump_particles_flag OFF
 dump_number_densities_flag ON
 ;dump_time_zero_flag ON ; dump the results of the 'zeroth' time step...does it actually start?
 extract_photons_flag OFF
 dump_particles_flag OFF
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 5.000000000000001e-07
 dump_steps
1 
end
 spatial_skip_x 1
 spatial_skip_y 1
 spatial_skip_z 1
 probe_interval 1
;(Diagnostic Output) Formats
 photon_output_format ASCII
 target_output_format ASCII
 use_its_format_flag OFF
 print_region_flag OFF
;(Diagnostic Output) Movie Controls
;particle_movie_interval_ns 5.000000000000001e-07
;particle_movie_components Q X Y Z VX VY VZ XI YI ZI

particle_movie_interval_ns 5.000000000000001e-07
particle_movie_components Q X Y Z VX VY VZ XI YI ZI

;Numerical Checks and Reports
 domain_boundary_check ON
 report_timing_flag ON
 dump_timing_flag ON
;
[Grid]
;
grid1
xmin             -5.000000e-04
xmax             2.000000e-03
x-cells          500
                                        ;
;
ymin             -2.000000e-03
ymax             2.000000e-03
y-cells          800

;
zmin             -2.000000e-03
zmax             2.000000e-03
z-cells          800

[Regions]
;

;total number of domains: 25000

;
region1
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.000000e-03
zmax             -1.980000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region2
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.980000e-03
zmax             -1.960000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region3
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.960000e-03
zmax             -1.940000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region4
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.940000e-03
zmax             -1.920000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region5
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.920000e-03
zmax             -1.900000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region6
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.900000e-03
zmax             -1.880000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region7
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.880000e-03
zmax             -1.860000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region8
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.860000e-03
zmax             -1.840000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region9
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.840000e-03
zmax             -1.820000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region10
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.820000e-03
zmax             -1.800000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region11
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.800000e-03
zmax             -1.780000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region12
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.780000e-03
zmax             -1.760000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region13
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.760000e-03
zmax             -1.740000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region14
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.740000e-03
zmax             -1.720000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region15
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.720000e-03
zmax             -1.700000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region16
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.700000e-03
zmax             -1.680000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region17
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.680000e-03
zmax             -1.660000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region18
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.660000e-03
zmax             -1.640000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region19
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.640000e-03
zmax             -1.620000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region20
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.620000e-03
zmax             -1.600000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region21
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.600000e-03
zmax             -1.580000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region22
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.580000e-03
zmax             -1.560000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region23
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.560000e-03
zmax             -1.540000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region24
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.540000e-03
zmax             -1.520000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region25
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.520000e-03
zmax             -1.500000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region26
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.500000e-03
zmax             -1.480000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region27
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.480000e-03
zmax             -1.460000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region28
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.460000e-03
zmax             -1.440000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region29
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.440000e-03
zmax             -1.420000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region30
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.420000e-03
zmax             -1.400000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region31
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.400000e-03
zmax             -1.380000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region32
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.380000e-03
zmax             -1.360000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region33
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.360000e-03
zmax             -1.340000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region34
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.340000e-03
zmax             -1.320000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region35
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.320000e-03
zmax             -1.300000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region36
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.300000e-03
zmax             -1.280000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region37
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.280000e-03
zmax             -1.260000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region38
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.260000e-03
zmax             -1.240000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region39
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.240000e-03
zmax             -1.220000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region40
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.220000e-03
zmax             -1.200000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region41
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.200000e-03
zmax             -1.180000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region42
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.180000e-03
zmax             -1.160000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region43
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.160000e-03
zmax             -1.140000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region44
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.140000e-03
zmax             -1.120000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region45
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.120000e-03
zmax             -1.100000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region46
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.100000e-03
zmax             -1.080000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region47
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.080000e-03
zmax             -1.060000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region48
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.060000e-03
zmax             -1.040000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region49
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.040000e-03
zmax             -1.020000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region50
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.020000e-03
zmax             -1.000000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region51
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.000000e-03
zmax             -9.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region52
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -9.800000e-04
zmax             -9.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region53
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -9.600000e-04
zmax             -9.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region54
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -9.400000e-04
zmax             -9.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region55
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -9.200000e-04
zmax             -9.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region56
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -9.000000e-04
zmax             -8.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region57
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -8.800000e-04
zmax             -8.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region58
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -8.600000e-04
zmax             -8.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region59
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -8.400000e-04
zmax             -8.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region60
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -8.200000e-04
zmax             -8.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region61
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -8.000000e-04
zmax             -7.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region62
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -7.800000e-04
zmax             -7.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region63
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -7.600000e-04
zmax             -7.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region64
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -7.400000e-04
zmax             -7.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region65
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -7.200000e-04
zmax             -7.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region66
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -7.000000e-04
zmax             -6.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region67
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -6.800000e-04
zmax             -6.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region68
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -6.600000e-04
zmax             -6.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region69
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -6.400000e-04
zmax             -6.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region70
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -6.200000e-04
zmax             -6.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region71
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -6.000000e-04
zmax             -5.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region72
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -5.800000e-04
zmax             -5.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region73
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -5.600000e-04
zmax             -5.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region74
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -5.400000e-04
zmax             -5.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region75
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -5.200000e-04
zmax             -5.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region76
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -5.000000e-04
zmax             -4.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region77
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -4.800000e-04
zmax             -4.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region78
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -4.600000e-04
zmax             -4.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region79
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -4.400000e-04
zmax             -4.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region80
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -4.200000e-04
zmax             -4.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region81
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -4.000000e-04
zmax             -3.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region82
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -3.800000e-04
zmax             -3.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region83
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -3.600000e-04
zmax             -3.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region84
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -3.400000e-04
zmax             -3.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region85
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -3.200000e-04
zmax             -3.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region86
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -3.000000e-04
zmax             -2.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region87
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.800000e-04
zmax             -2.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region88
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.600000e-04
zmax             -2.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region89
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.400000e-04
zmax             -2.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region90
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.200000e-04
zmax             -2.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region91
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.000000e-04
zmax             -1.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region92
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.800000e-04
zmax             -1.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region93
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.600000e-04
zmax             -1.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region94
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.400000e-04
zmax             -1.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region95
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.200000e-04
zmax             -1.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region96
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -1.000000e-04
zmax             -8.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region97
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -8.000000e-05
zmax             -6.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region98
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -6.000000e-05
zmax             -4.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region99
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -4.000000e-05
zmax             -2.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region100
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             -2.000000e-05
zmax             0.000000e+00
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region101
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             0.000000e+00
zmax             2.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region102
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             2.000000e-05
zmax             4.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region103
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             4.000000e-05
zmax             6.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region104
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             6.000000e-05
zmax             8.000000e-05
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region105
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             8.000000e-05
zmax             1.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region106
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.000000e-04
zmax             1.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region107
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.200000e-04
zmax             1.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region108
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.400000e-04
zmax             1.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region109
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.600000e-04
zmax             1.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region110
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.800000e-04
zmax             2.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region111
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             2.000000e-04
zmax             2.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region112
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             2.200000e-04
zmax             2.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region113
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             2.400000e-04
zmax             2.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region114
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             2.600000e-04
zmax             2.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region115
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             2.800000e-04
zmax             3.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region116
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             3.000000e-04
zmax             3.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region117
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             3.200000e-04
zmax             3.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region118
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             3.400000e-04
zmax             3.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region119
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             3.600000e-04
zmax             3.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region120
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             3.800000e-04
zmax             4.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region121
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             4.000000e-04
zmax             4.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region122
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             4.200000e-04
zmax             4.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region123
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             4.400000e-04
zmax             4.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region124
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             4.600000e-04
zmax             4.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region125
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             4.800000e-04
zmax             5.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region126
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             5.000000e-04
zmax             5.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region127
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             5.200000e-04
zmax             5.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region128
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             5.400000e-04
zmax             5.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region129
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             5.600000e-04
zmax             5.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region130
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             5.800000e-04
zmax             6.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region131
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             6.000000e-04
zmax             6.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region132
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             6.200000e-04
zmax             6.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region133
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             6.400000e-04
zmax             6.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region134
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             6.600000e-04
zmax             6.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region135
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             6.800000e-04
zmax             7.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region136
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             7.000000e-04
zmax             7.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region137
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             7.200000e-04
zmax             7.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region138
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             7.400000e-04
zmax             7.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region139
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             7.600000e-04
zmax             7.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region140
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             7.800000e-04
zmax             8.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region141
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             8.000000e-04
zmax             8.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region142
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             8.200000e-04
zmax             8.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region143
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             8.400000e-04
zmax             8.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region144
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             8.600000e-04
zmax             8.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region145
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             8.800000e-04
zmax             9.000000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region146
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             9.000000e-04
zmax             9.200000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region147
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             9.200000e-04
zmax             9.400000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region148
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             9.400000e-04
zmax             9.600000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region149
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             9.600000e-04
zmax             9.800000e-04
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region150
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             9.800000e-04
zmax             1.000000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region151
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.000000e-03
zmax             1.020000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region152
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.020000e-03
zmax             1.040000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region153
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.040000e-03
zmax             1.060000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region154
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.060000e-03
zmax             1.080000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region155
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.080000e-03
zmax             1.100000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region156
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.100000e-03
zmax             1.120000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region157
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.120000e-03
zmax             1.140000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region158
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.140000e-03
zmax             1.160000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region159
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.160000e-03
zmax             1.180000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region160
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.180000e-03
zmax             1.200000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region161
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.200000e-03
zmax             1.220000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region162
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.220000e-03
zmax             1.240000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region163
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.240000e-03
zmax             1.260000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region164
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.260000e-03
zmax             1.280000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region165
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.280000e-03
zmax             1.300000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region166
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.300000e-03
zmax             1.320000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region167
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.320000e-03
zmax             1.340000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region168
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.340000e-03
zmax             1.360000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region169
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.360000e-03
zmax             1.380000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region170
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.380000e-03
zmax             1.400000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region171
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.400000e-03
zmax             1.420000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region172
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.420000e-03
zmax             1.440000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region173
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.440000e-03
zmax             1.460000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region174
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.460000e-03
zmax             1.480000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region175
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.480000e-03
zmax             1.500000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region176
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.500000e-03
zmax             1.520000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region177
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.520000e-03
zmax             1.540000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region178
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.540000e-03
zmax             1.560000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region179
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.560000e-03
zmax             1.580000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region180
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.580000e-03
zmax             1.600000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region181
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.600000e-03
zmax             1.620000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region182
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.620000e-03
zmax             1.640000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region183
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.640000e-03
zmax             1.660000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region184
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.660000e-03
zmax             1.680000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region185
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.680000e-03
zmax             1.700000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region186
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.700000e-03
zmax             1.720000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region187
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.720000e-03
zmax             1.740000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region188
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.740000e-03
zmax             1.760000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region189
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.760000e-03
zmax             1.780000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region190
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.780000e-03
zmax             1.800000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region191
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.800000e-03
zmax             1.820000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region192
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.820000e-03
zmax             1.840000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region193
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.840000e-03
zmax             1.860000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region194
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.860000e-03
zmax             1.880000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region195
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.880000e-03
zmax             1.900000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region196
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.900000e-03
zmax             1.920000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region197
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.920000e-03
zmax             1.940000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region198
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.940000e-03
zmax             1.960000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region199
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.960000e-03
zmax             1.980000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;
;
region200
xmin             -5.000000e-04
xmax             2.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             1.980000e-03
zmax             2.000000e-03
;
number_of_domains 125
split_direction XSPLIT
number_of_cells AUTO ; cells = 1600000
;


;
;
[Boundaries]
;back this is the laser
outlet
from -5.000000e-04 -2.000000e-03 -2.000000e-03
to   -5.000000e-04 2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0 ; focal point position
components 0 1 0
phases 0 0 0 ; polarization 1.1781
temporal_function 1
analytic_function 2
time_delay 0.0
;front (back of the target)
outlet
from  2.000000e-03 -2.000000e-03 -2.000000e-03
to    2.000000e-03 2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -5.000000e-04  2.000000e-03 -2.000000e-03
to   2.000000e-03  2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE
;left
outlet
from -5.000000e-04  -2.000000e-03 -2.000000e-03
to   2.000000e-03  -2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE
;top
outlet
from -5.000000e-04  -2.000000e-03 2.000000e-03
to   2.000000e-03  2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -5.000000e-04  -2.000000e-03 -2.000000e-03
to   2.000000e-03  2.000000e-03 -2.000000e-03
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
species1 ; neutral O
charge 0
mass 29392
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.05
;
species2 ; O+
charge +1
mass 29391
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species3 ; O++
charge +2
mass 29390
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species4 ; O 3+
charge +3
mass 29389
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species5 ; O 4+
charge +4
mass 29388
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species6 ; O 5+
charge +5
mass 29387
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species7 ; O 6+
charge +6
mass 29386
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species8 ; O 7+
charge +7
mass 29385
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species9 ; O 8+
charge +8
mass 29384
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species10 ; kinetic electrons
charge -1
mass 1.0
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag on
implicit_filtering_parameter 0.1
selection_ratio 0.01
;
species11 ; protons
charge +1
mass 1836
atomic_number 1
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 0.01

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Particle Creation]

;; initial states ;;

plasma ; O+
from 0.000000e+00  -1.500000e-03  -1.500000e-03
to   2.000000e-04  1.500000e-03  1.500000e-03
species 2
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
plasma ; e-
from 0.000000e+00 -1.500000e-03  -1.500000e-03
to   2.000000e-04 1.500000e-03  1.500000e-03
species 10
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.050
;
plasma ; p+
from 0.000000e+00 -1.500000e-03  -1.500000e-03
to   2.000000e-04 1.500000e-03  1.500000e-03
species 11
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000

;; ionization states ;;
;
higherstate              ; O -> O+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 1
ion_species 2
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 13.6
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
higherstate              ; O+ -> O++
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 2
ion_species 3
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 35.1
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
higherstate              ; O++ -> O 3+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 3
ion_species 4
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 54.9
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
higherstate              ; O 3+ -> O 4+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 4
ion_species 5
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 77.4
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
higherstate              ; O 4+ -> O 5+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 5
ion_species 6
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 113.9
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
;
higherstate              ; O 5+ -> O 6+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 6
ion_species 7
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 138.1
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
higherstate              ; O 6+ -> O 7+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 7
ion_species 8
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 739.3
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0
;
higherstate              ; O 7+ -> O 8+
from -5.000000e-04 -2.000000e-03  -2.000000e-03
to   2.000000e-03 2.000000e-03  2.000000e-03
interval 1
species 8
ion_species 9
movie_tag 5
electron_species 10
movie_tag 3
ionization_potential 871.4
cross_sections
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
  0.0
end
movie_fraction 0.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Particle Extraction]
;
;;extract1
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at -5.000000e-04 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 2.000000e-03 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 2.000000e-03 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -2.000000e-03 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0005 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.002 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.002 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.002 0
 
;
extract5
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.002
 
;
extract6
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.002


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 8.400000e-05
;; Emax, intensity=1.000000e+18 W/cm^2
dependent_variable_multiplier   2.744924e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~4.319689898685966
          ; \lambda spotsize
coefficients 8.000000e-05 2.200000e-04 end

;;
function3 ; electrons

type 30
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

;;
function4 ; Oxygen

type 30
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 0.33

;;
function5 ; Protons

type 30
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 0.67

;;

[Probes]
;
probe1
energy net_energy
;
probe2
energy total_energy
;
probe3
performance cpu_time
