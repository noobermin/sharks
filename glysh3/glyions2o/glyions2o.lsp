;;;
;; Use this sandpie for no plasma.

[Title]
simulation_title "ionization dynamics, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.0000e-04
 time_step_ns 2.5000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 1000
rename_restart_flag ON
restart_interval 40

;;Load Balancing
balance_interval 0
balance_interval_ns 0.0
load_balance_flag OFF

;;Field Solution and Modification
time_bias_coefficient 0.0
time_bias_iterations 1

;;Implicit Field Algorithm (mostly don't touch, for use in high density plasma)
error_current_filtering_parameter 0.95
implicit_iterations 10
implicit_tolerance 1e-05

;;Matrix Solution Algorithm (mostly don't touch, for use in multi-domain decks)
linear_solution GMRES
preconditioner JACOBI

;;Kinematics
plasma_frequency_limit 2.0

;;Collision Algorithm
electron_stimulation_factor 0.5
ion_stimulation_factor 1.0
ionization_interval 1
scattering_interval 1

;;Fluid Physics Algorithm
eulerian_maximum_temperature 10000.0
fluid_electron_streaming_factor 0.1
fluid_ion_streaming_factor 0.01
fluid_streaming_factor 0.1

;;Diagnostic Dumps
dump_number_densities_flag OFF
dump_plasma_quantities_flag OFF
dump_time_zero_flag OFF
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1


;;pmovies


;
[Grid]
grid1


xmin             -8.000000e-04
xmax             7.500000e-04
x-cells          1550

ymin             -2.000000e-03
ymax             2.000000e-03
y-cells          1600

zmin             -2.000000e-03
zmax             2.000000e-03
z-cells          800

[Regions]
;

;total number of domains: 6600

;
region1
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region6
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region7
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region8
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region9
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region10
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -2.000000e-03
ymax             -1.600000e-03

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region11
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region12
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region13
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region14
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region15
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region16
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region17
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region18
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region19
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region20
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.600000e-03
ymax             -1.200000e-03

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region21
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region22
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region23
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region24
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region25
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region26
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region27
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region28
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region29
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region30
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -1.200000e-03
ymax             -8.000000e-04

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region31
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region32
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region33
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region34
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region35
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region36
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region37
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region38
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region39
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region40
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -8.000000e-04
ymax             -4.000000e-04

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region41
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region42
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region43
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region44
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region45
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region46
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region47
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region48
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region49
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region50
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             -4.000000e-04
ymax             0.000000e+00

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region51
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region52
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region53
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region54
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region55
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region56
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region57
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region58
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region59
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region60
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             0.000000e+00
ymax             4.000000e-04

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region61
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region62
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region63
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region64
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region65
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region66
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region67
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region68
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region69
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region70
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             4.000000e-04
ymax             8.000000e-04

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region71
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region72
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region73
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region74
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region75
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region76
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region77
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region78
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region79
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region80
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             8.000000e-04
ymax             1.200000e-03

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region81
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region82
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region83
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region84
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region85
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region86
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region87
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region88
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region89
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region90
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.200000e-03
ymax             1.600000e-03

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region91
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             -2.000000e-03
zmax             -1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region92
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             -1.600000e-03
zmax             -1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region93
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             -1.200000e-03
zmax             -8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region94
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             -8.000000e-04
zmax             -4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region95
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             -4.000000e-04
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region96
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             0.000000e+00
zmax             4.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region97
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             4.000000e-04
zmax             8.000000e-04
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region98
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             8.000000e-04
zmax             1.200000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region99
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             1.200000e-03
zmax             1.600000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region100
xmin             -8.000000e-04
xmax             7.500000e-04

ymin             1.600000e-03
ymax             2.000000e-03

zmin             1.600000e-03
zmax             2.000000e-03
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]


[Boundaries]

;laser
outlet
from -8.000000e-04  -2.000000e-03 -2.000000e-03
to   -8.000000e-04  2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0.7853981633974483 0.0 -0.002
temporal_function 1
analytic_function 2
time_delay 0.0

;back
outlet
from 7.500000e-04  -2.000000e-03 -2.000000e-03
to   7.500000e-04  2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE

;left
outlet
from -8.000000e-04  -2.000000e-03 -2.000000e-03
to   7.500000e-04  -2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -8.000000e-04  2.000000e-03 -2.000000e-03
to   7.500000e-04  2.000000e-03 2.000000e-03
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -8.000000e-04  -2.000000e-03 -2.000000e-03
to   7.500000e-04  2.000000e-03 -2.000000e-03
phase_velocity 1.0
drive_model NONE

;top
outlet
from -8.000000e-04  -2.000000e-03 2.000000e-03
to   7.500000e-04  2.000000e-03 2.000000e-03
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
from -2.300000e-05  -2.000000e-03  -2.000000e-03
to   2.300000e-05  2.000000e-03  2.000000e-03
species 1
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 3
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.025

movie_fraction 0.000
;
plasma ; C
from -2.300000e-05  -2.000000e-03  -2.000000e-03
to   2.300000e-05  2.000000e-03  2.000000e-03
species 10
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 4
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.025

movie_fraction 0.000
;
plasma ; H
from -2.300000e-05 -2.000000e-03  -2.000000e-03
to   2.300000e-05 2.000000e-03  2.000000e-03
species 18
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 5
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.025

movie_fraction 0.000
;

;; emission from conductors
;;e-
emission child-langmuir field-stress
from -8.000000e-04 -2.000000e-03 -2.000000e-03
to   7.500000e-04 2.000000e-03 2.000000e-03
interval 1
species 17
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;p+
emission child-langmuir field-stress
from -8.000000e-04 -2.000000e-03 -2.000000e-03
to   7.500000e-04 2.000000e-03 2.000000e-03
interval 1
species 19
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;O+
emission child-langmuir field-stress
from -8.000000e-04 -2.000000e-03 -2.000000e-03
to   7.500000e-04 2.000000e-03 2.000000e-03
interval 1
species 11
discrete_numbers 2 2 2
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;C+
emission child-langmuir field-stress
from -8.000000e-04 -2.000000e-03 -2.000000e-03
to   7.500000e-04 2.000000e-03 2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
from -8.000000e-04 -2.000000e-03  -2.000000e-03
to   7.500000e-04 2.000000e-03  2.000000e-03
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
at -0.0008 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.00075 0 0
 
;
extract3
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.002 0
 
;
extract4
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.002 0
 
;
extract5
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.002
 
;
extract6
species 17
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
;; Emax, intensity=5.000000e+18 W/cm^2
dependent_variable_multiplier   6.137836e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~3.762878770705575
          ; \lambda spotsize
coefficients 7.800000e-05 1.868508e-04 end

;;
function3 ; O
type 1
coefficients 2.16e+22 end

;;
function4 ; C
type 1
coefficients 2.16e+22 end

;;
function5 ; H
type 1
coefficients 6.48e+22 end

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
