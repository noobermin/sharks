;;;
;; Use this sandpie for no plasma.

[Title]
simulation_title "ionization dynamics, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   8.4000e-05
 time_step_ns 4.0000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 1000
rename_restart_flag ON
restart_interval 50

;;Load Balancing
balance_interval 0.0
balance_interval_ns 0.0
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

;;Kinematics
plasma_frequency_limit 2.0

;;Diagnostic Dumps
dump_number_densities_flag ON
dump_plasma_quantities_flag ON
dump_time_zero_flag ON
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1

dump_fields_flag ON
field_dump_interval_ns 0.0
dump_scalars_flag ON
scalar_dump_interval_ns 0.0
dump_particles_flag ON
particle_dump_interval_ns 0.0

;;pmovies


;
[Grid]
;
grid1
xmin             -1.600000e-03
xmax             1.600000e-03
x-cells          1600
                                        ;
;
ymin             -1.600000e-03
ymax             1.600000e-03
y-cells          1600

;
zmin             -2.200000e-03
zmax             2.200000e-03
z-cells          880

[Regions]
;

;total number of domains: 5632

;
region1
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region6
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region7
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region8
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region9
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region10
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region11
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region12
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region13
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region14
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region15
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region16
xmin             -1.600000e-03
xmax             -1.200000e-03

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region17
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region18
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region19
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region20
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region21
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region22
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region23
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region24
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region25
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region26
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region27
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region28
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region29
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region30
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region31
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region32
xmin             -1.200000e-03
xmax             -8.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region33
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region34
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region35
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region36
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region37
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region38
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region39
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region40
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region41
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region42
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region43
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region44
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region45
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region46
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region47
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region48
xmin             -8.000000e-04
xmax             -4.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region49
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region50
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region51
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region52
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region53
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region54
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region55
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region56
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region57
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region58
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region59
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region60
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region61
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region62
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region63
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region64
xmin             -4.000000e-04
xmax             0.000000e+00

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region65
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region66
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region67
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region68
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region69
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region70
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region71
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region72
xmin             0.000000e+00
xmax             4.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region73
xmin             0.000000e+00
xmax             4.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region74
xmin             0.000000e+00
xmax             4.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region75
xmin             0.000000e+00
xmax             4.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region76
xmin             0.000000e+00
xmax             4.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region77
xmin             0.000000e+00
xmax             4.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region78
xmin             0.000000e+00
xmax             4.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region79
xmin             0.000000e+00
xmax             4.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region80
xmin             0.000000e+00
xmax             4.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region81
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region82
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region83
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region84
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region85
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region86
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region87
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region88
xmin             4.000000e-04
xmax             8.000000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region89
xmin             4.000000e-04
xmax             8.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region90
xmin             4.000000e-04
xmax             8.000000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region91
xmin             4.000000e-04
xmax             8.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region92
xmin             4.000000e-04
xmax             8.000000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region93
xmin             4.000000e-04
xmax             8.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region94
xmin             4.000000e-04
xmax             8.000000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region95
xmin             4.000000e-04
xmax             8.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region96
xmin             4.000000e-04
xmax             8.000000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region97
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region98
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region99
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region100
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region101
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region102
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region103
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region104
xmin             8.000000e-04
xmax             1.200000e-03

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region105
xmin             8.000000e-04
xmax             1.200000e-03

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region106
xmin             8.000000e-04
xmax             1.200000e-03

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region107
xmin             8.000000e-04
xmax             1.200000e-03

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region108
xmin             8.000000e-04
xmax             1.200000e-03

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region109
xmin             8.000000e-04
xmax             1.200000e-03

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region110
xmin             8.000000e-04
xmax             1.200000e-03

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region111
xmin             8.000000e-04
xmax             1.200000e-03

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region112
xmin             8.000000e-04
xmax             1.200000e-03

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region113
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region114
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region115
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region116
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region117
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region118
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region119
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region120
xmin             1.200000e-03
xmax             1.600000e-03

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region121
xmin             1.200000e-03
xmax             1.600000e-03

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region122
xmin             1.200000e-03
xmax             1.600000e-03

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region123
xmin             1.200000e-03
xmax             1.600000e-03

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region124
xmin             1.200000e-03
xmax             1.600000e-03

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region125
xmin             1.200000e-03
xmax             1.600000e-03

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region126
xmin             1.200000e-03
xmax             1.600000e-03

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region127
xmin             1.200000e-03
xmax             1.600000e-03

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.200000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region128
xmin             1.200000e-03
xmax             1.600000e-03

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             2.200000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]


[Boundaries]
;back this is the laser

;laser
outlet
from -1.600000e-03  -1.600000e-03 -2.200000e-03
to   -1.600000e-03  1.600000e-03 2.200000e-03
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 2
time_delay 0.0

;back
outlet
from 1.600000e-03  -1.600000e-03 -2.200000e-03
to   1.600000e-03  1.600000e-03 2.200000e-03
phase_velocity 1.0
drive_model NONE
;left
outlet
from -1.600000e-03  -1.600000e-03 -2.200000e-03
to   1.600000e-03  -1.600000e-03 2.200000e-03
phase_velocity 1.0
drive_model NONE
;right
outlet
from -1.600000e-03  1.600000e-03 -2.200000e-03
to   1.600000e-03  1.600000e-03 2.200000e-03
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -1.600000e-03  -1.600000e-03 -2.200000e-03
to   1.600000e-03  1.600000e-03 -2.200000e-03
phase_velocity 1.0
drive_model NONE
;top
outlet
from -1.600000e-03  -1.600000e-03 2.200000e-03
to   1.600000e-03  1.600000e-03 2.200000e-03
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
;; O
species1 ; neutral O
charge 0
mass 29158.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species2 ; O+
charge +1
mass 29157.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species3 ; O++
charge +2
mass 29156.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species4 ; O 3+
charge +3
mass 29155.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species5 ; O 4+
charge +4
mass 29154.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species6 ; O 5+
charge +5
mass 29153.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species7 ; O 6+
charge +6
mass 29152.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species8 ; O 7+
charge +7
mass 29151.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species9 ; O 8+
charge +8
mass 29150.7
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
;; C
species10 ; neutral C
charge 0
mass 21887.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species11 ; C+
charge +1
mass 21886.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species12 ; C++
charge +2
mass 21885.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species13 ; C 3+
charge +3
mass 21884.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species14 ; C 4+
charge +4
mass 21883.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species15 ; C 5+
charge +5
mass 21882.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species16 ; C 6+
charge +6
mass 21881.3
atomic_number 6
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0

species17 ; kinetic electrons
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
selection_ratio 1.0
;
species18 ; H atom
charge 0
mass 1837
atomic_number 1
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option PRIMARY
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species19 ; protons
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
selection_ratio 1.0
;                                        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Particle Creation]

;; initial states ;;
plasma ; O
from -1.600000e-03  -1.600000e-03  -2.200000e-03
to   1.600000e-03  1.600000e-03  2.200000e-03
species 1
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.025

movie_fraction 0.000
;
plasma ; C
from -1.600000e-03  -1.600000e-03  -2.200000e-03
to   1.600000e-03  1.600000e-03  2.200000e-03
species 10
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.025

movie_fraction 0.000
;
plasma ; H
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
species 18
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.025

movie_fraction 0.000
;

;; emission from conductors
;;e-
emission child-langmuir field-stress
from -1.600000e-03 -1.600000e-03 -2.200000e-03
to   1.600000e-03 1.600000e-03 2.200000e-03
interval 1
species 17
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;p+
emission child-langmuir field-stress
from -1.600000e-03 -1.600000e-03 -2.200000e-03
to   1.600000e-03 1.600000e-03 2.200000e-03
interval 1
species 19
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;O+
emission child-langmuir field-stress
from -1.600000e-03 -1.600000e-03 -2.200000e-03
to   1.600000e-03 1.600000e-03 2.200000e-03
interval 1
species 11
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;C+
emission child-langmuir field-stress
from -1.600000e-03 -1.600000e-03 -2.200000e-03
to   1.600000e-03 1.600000e-03 2.200000e-03
interval 1
species 2
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;; ionization states ;;
;; Hydrogen
higherstate              ; H -> p+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 18
ion_species 19
movie_tag 5
electron_species 17
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

;; Oxygen
higherstate              ; O -> O+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 1
ion_species 2
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 2
ion_species 3
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 3
ion_species 4
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 4
ion_species 5
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 5
ion_species 6
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 6
ion_species 7
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 7
ion_species 8
movie_tag 5
electron_species 17
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
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 8
ion_species 9
movie_tag 5
electron_species 17
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
;
;; carbon
higherstate              ; C -> C+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 10
ion_species 11
movie_tag 5
electron_species 17
ionization_potential 11.3
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
higherstate              ; C+ -> C++
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 11
ion_species 12
movie_tag 5
electron_species 17
ionization_potential 24.4
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
higherstate              ; C++ -> C 3+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 12
ion_species 13
movie_tag 5
electron_species 17
ionization_potential 47.9
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
higherstate              ; C 3+ -> C 4+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 13
ion_species 14
movie_tag 5
electron_species 17
ionization_potential 64.5
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
higherstate              ; C 4+ -> C 5+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 14
ion_species 15
movie_tag 5
electron_species 17
ionization_potential 392.1
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
higherstate              ; C 5+ -> C 6+
from -1.600000e-03 -1.600000e-03  -2.200000e-03
to   1.600000e-03 1.600000e-03  2.200000e-03
interval 1
species 15
ion_species 16
movie_tag 5
electron_species 17
ionization_potential 490.0
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

;
extract1
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0016 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0016 0 0
 
;
extract3
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0016 0
 
;
extract4
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0016 0
 
;
extract5
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.0022
 
;
extract6
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.0022


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 8.400000e-05
;; Emax, intensity=5.000000e+18 W/cm^2
dependent_variable_multiplier   6.137836e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~3.762878770705575
          ; \lambda spotsize
coefficients 7.800000e-05 1.868508e-04 end

;;
function3 ; O

type 40
data_file target_neutral.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function4 ; C

type 40
data_file target_neutral.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function5 ; H

type 40
data_file target_neutral.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 6.0

;;




[Probes]
;
probe1
energy net_energy
;
probe2
energy particle_energy
;
probe3
energy field_energy
;
probe4
energy total_energy
;
probe5
performance cpu_time
;
