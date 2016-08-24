[Title]
simulation_title "Flash to LSP as IC in 3D, I = 3.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   3.5000e-04
 time_step_ns 1.0000e-07
;Restart
maximum_restart_dump_time 23.5
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
xmin             -4.100000e-03
xmax             9.000000e-04
x-cells          500
                                        ;
;
ymin             -1.700000e-03
ymax             1.700000e-03
y-cells          340

;
zmin             -1.700000e-03
zmax             1.700000e-03
z-cells          340

[Regions]
;

;total number of domains: 1000

;
region1
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.700000e-03
zmax             -1.650000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region2
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.650000e-03
zmax             -1.600000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region3
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.600000e-03
zmax             -1.550000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region4
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.550000e-03
zmax             -1.500000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region5
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.500000e-03
zmax             -1.450000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region6
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.450000e-03
zmax             -1.400000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region7
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.400000e-03
zmax             -1.350000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region8
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.350000e-03
zmax             -1.300000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region9
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.300000e-03
zmax             -1.250000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region10
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.250000e-03
zmax             -1.200000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region11
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.200000e-03
zmax             -1.150000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region12
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.150000e-03
zmax             -1.100000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region13
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.100000e-03
zmax             -1.050000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region14
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.050000e-03
zmax             -1.000000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region15
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.000000e-03
zmax             -9.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region16
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -9.500000e-04
zmax             -9.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region17
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -9.000000e-04
zmax             -8.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region18
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -8.500000e-04
zmax             -8.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region19
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -8.000000e-04
zmax             -7.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region20
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -7.500000e-04
zmax             -7.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region21
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -7.000000e-04
zmax             -6.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region22
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -6.500000e-04
zmax             -6.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region23
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -6.000000e-04
zmax             -5.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region24
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -5.500000e-04
zmax             -5.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region25
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -5.000000e-04
zmax             -4.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region26
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -4.500000e-04
zmax             -4.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region27
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -4.000000e-04
zmax             -3.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region28
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -3.500000e-04
zmax             -3.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region29
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -3.000000e-04
zmax             -2.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region30
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -2.500000e-04
zmax             -2.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region31
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -2.000000e-04
zmax             -1.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region32
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.500000e-04
zmax             -1.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region33
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -1.000000e-04
zmax             -5.000000e-05
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region34
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             -5.000000e-05
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region35
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             0.000000e+00
zmax             5.000000e-05
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region36
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             5.000000e-05
zmax             1.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region37
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.000000e-04
zmax             1.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region38
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.500000e-04
zmax             2.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region39
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             2.000000e-04
zmax             2.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region40
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             2.500000e-04
zmax             3.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region41
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             3.000000e-04
zmax             3.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region42
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             3.500000e-04
zmax             4.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region43
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             4.000000e-04
zmax             4.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region44
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             4.500000e-04
zmax             5.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region45
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             5.000000e-04
zmax             5.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region46
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             5.500000e-04
zmax             6.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region47
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             6.000000e-04
zmax             6.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region48
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             6.500000e-04
zmax             7.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region49
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             7.000000e-04
zmax             7.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region50
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             7.500000e-04
zmax             8.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region51
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             8.000000e-04
zmax             8.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region52
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             8.500000e-04
zmax             9.000000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region53
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             9.000000e-04
zmax             9.500000e-04
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region54
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             9.500000e-04
zmax             1.000000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region55
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.000000e-03
zmax             1.050000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region56
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.050000e-03
zmax             1.100000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region57
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.100000e-03
zmax             1.150000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region58
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.150000e-03
zmax             1.200000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region59
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.200000e-03
zmax             1.250000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region60
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.250000e-03
zmax             1.300000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region61
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.300000e-03
zmax             1.350000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region62
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.350000e-03
zmax             1.400000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region63
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.400000e-03
zmax             1.450000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region64
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.450000e-03
zmax             1.500000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region65
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.500000e-03
zmax             1.550000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region66
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.550000e-03
zmax             1.600000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region67
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.600000e-03
zmax             1.650000e-03
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;
;
region68
xmin             -4.100000e-03
xmax             9.000000e-04

ymin             -1.700000e-03
ymax             1.700000e-03

zmin             1.650000e-03
zmax             1.700000e-03
;
number_of_domains 62
split_direction XSPLIT
number_of_cells AUTO ; cells = 850000
;


;
;
[Boundaries]
;back this is the laser
outlet
from -4.100000e-03 -1.700000e-03 -1.700000e-03
to   -4.100000e-03 1.700000e-03 1.700000e-03
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
from  9.000000e-04 -1.700000e-03 -1.700000e-03
to    9.000000e-04 1.700000e-03 1.700000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -4.100000e-03  1.700000e-03 -1.700000e-03
to   9.000000e-04  1.700000e-03 1.700000e-03
phase_velocity 1.0
drive_model NONE
;left
outlet
from -4.100000e-03  -1.700000e-03 -1.700000e-03
to   9.000000e-04  -1.700000e-03 1.700000e-03
phase_velocity 1.0
drive_model NONE
;top
outlet
from -4.100000e-03  -1.700000e-03 1.700000e-03
to   9.000000e-04  1.700000e-03 1.700000e-03
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -4.100000e-03  -1.700000e-03 -1.700000e-03
to   9.000000e-04  1.700000e-03 -1.700000e-03
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
from -3.600000e-03  -1.200000e-03  -1.200000e-03
to   4.000000e-04  1.200000e-03  1.200000e-03
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
from -3.600000e-03 -1.200000e-03  -1.200000e-03
to   4.000000e-04 1.200000e-03  1.200000e-03
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
from -3.600000e-03 -1.200000e-03  -1.200000e-03
to   4.000000e-04 1.200000e-03  1.200000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
from -4.100000e-03 -1.700000e-03  -1.700000e-03
to   9.000000e-04 1.700000e-03  1.700000e-03
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
;;at -4.100000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 9.000000e-04 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 1.700000e-03 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -1.700000e-03 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0041 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0009000000000000001 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0017000000000000001 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0017000000000000001 0
 
;
extract5
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.0017000000000000001
 
;
extract6
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.0017000000000000001


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 6.000000e-05
;; Emax, intensity=3.000000e+18 W/cm^2
dependent_variable_multiplier   4.754347e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~4.437499623195583
          ; \lambda spotsize
coefficients 8.000000e-05 2.260000e-04 end

;;
function3 ; electrons

type 50
data_file flashic-20160810.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

;;
function4 ; Oxygen

type 50
data_file flashic-20160810.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 0.33

;;
function5 ; Protons

type 50
data_file flashic-20160810.dat
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
