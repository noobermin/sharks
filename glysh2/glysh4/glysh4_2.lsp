;;;
;; Use this sandpie for no plasma.

[Title]
simulation_title "After TNSA expansion, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.5000e-04
 time_step_ns 4.0000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 11.95
rename_restart_flag ON

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
dump_number_densities_flag OFF
dump_plasma_quantities_flag OFF
dump_time_zero_flag ON
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1

dump_fields_flag ON
field_dump_interval_ns 5e-06
dump_particles_flag ON
particle_dump_interval_ns 2.0000000000000003e-06

;;pmovies


;
[Grid]
;
grid1
xmin             -2.600000e-03
xmax             2.600000e-03
x-cells          2600
                                        ;
;
ymin             -2.600000e-03
ymax             2.600000e-03
y-cells          2600

;
zmin             -1.000000e-03
zmax             1.000000e-03
z-cells          400

[Regions]
;

;total number of domains: 6600

;
region1
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.600000e-03
ymax             -2.530667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region2
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.530667e-03
ymax             -2.461333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region3
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.461333e-03
ymax             -2.392000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region4
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.392000e-03
ymax             -2.322667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region5
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.322667e-03
ymax             -2.253333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region6
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.253333e-03
ymax             -2.184000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region7
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.184000e-03
ymax             -2.114667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region8
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.114667e-03
ymax             -2.045333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region9
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.045333e-03
ymax             -1.976000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region10
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.976000e-03
ymax             -1.906667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region11
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.906667e-03
ymax             -1.837333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region12
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.837333e-03
ymax             -1.768000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region13
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.768000e-03
ymax             -1.698667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region14
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.698667e-03
ymax             -1.629333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region15
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.629333e-03
ymax             -1.560000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region16
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.560000e-03
ymax             -1.490667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region17
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.490667e-03
ymax             -1.421333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region18
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.421333e-03
ymax             -1.352000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region19
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.352000e-03
ymax             -1.282667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region20
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.282667e-03
ymax             -1.213333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region21
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.213333e-03
ymax             -1.144000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region22
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.144000e-03
ymax             -1.074667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region23
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.074667e-03
ymax             -1.005333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region24
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.005333e-03
ymax             -9.360000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region25
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -9.360000e-04
ymax             -8.666667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region26
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -8.666667e-04
ymax             -7.973333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region27
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -7.973333e-04
ymax             -7.280000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region28
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -7.280000e-04
ymax             -6.586667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region29
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -6.586667e-04
ymax             -5.893333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region30
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -5.893333e-04
ymax             -5.200000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region31
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -5.200000e-04
ymax             -4.506667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region32
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -4.506667e-04
ymax             -3.813333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region33
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -3.813333e-04
ymax             -3.120000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region34
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -3.120000e-04
ymax             -2.426667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region35
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -2.426667e-04
ymax             -1.733333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region36
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.733333e-04
ymax             -1.040000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region37
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -1.040000e-04
ymax             -3.466667e-05

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region38
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             -3.466667e-05
ymax             3.466667e-05

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region39
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             3.466667e-05
ymax             1.040000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region40
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.040000e-04
ymax             1.733333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region41
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.733333e-04
ymax             2.426667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region42
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.426667e-04
ymax             3.120000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region43
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             3.120000e-04
ymax             3.813333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region44
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             3.813333e-04
ymax             4.506667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region45
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             4.506667e-04
ymax             5.200000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region46
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             5.200000e-04
ymax             5.893333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region47
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             5.893333e-04
ymax             6.586667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region48
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             6.586667e-04
ymax             7.280000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region49
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             7.280000e-04
ymax             7.973333e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region50
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             7.973333e-04
ymax             8.666667e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region51
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             8.666667e-04
ymax             9.360000e-04

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region52
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             9.360000e-04
ymax             1.005333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region53
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.005333e-03
ymax             1.074667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region54
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.074667e-03
ymax             1.144000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region55
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.144000e-03
ymax             1.213333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region56
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.213333e-03
ymax             1.282667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region57
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.282667e-03
ymax             1.352000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region58
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.352000e-03
ymax             1.421333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region59
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.421333e-03
ymax             1.490667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region60
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.490667e-03
ymax             1.560000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region61
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.560000e-03
ymax             1.629333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region62
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.629333e-03
ymax             1.698667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region63
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.698667e-03
ymax             1.768000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region64
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.768000e-03
ymax             1.837333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region65
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.837333e-03
ymax             1.906667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region66
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.906667e-03
ymax             1.976000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region67
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             1.976000e-03
ymax             2.045333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region68
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.045333e-03
ymax             2.114667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region69
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.114667e-03
ymax             2.184000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region70
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.184000e-03
ymax             2.253333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region71
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.253333e-03
ymax             2.322667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region72
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.322667e-03
ymax             2.392000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region73
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.392000e-03
ymax             2.461333e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region74
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.461333e-03
ymax             2.530667e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 33800000
;
;
region75
xmin             -2.600000e-03
xmax             2.600000e-03

ymin             2.530667e-03
ymax             2.600000e-03

zmin             -1.000000e-03
zmax             1.000000e-03
;
number_of_domains 88
split_direction XSPLIT
number_of_cells AUTO ; cells = 202800000
;


;

;
[Objects]

object1 TRILATERAL
conductor on medium 0 potential 0
from -2.700000e-03 -2.700000e-03 0.000000e+00
to   -2.400000e-03 -2.700000e-03 0.000000e+00
to   -2.700000e-03 -2.400000e-03 0.000000e+00
sweep_direction Z

object2 TRILATERAL
conductor on medium 0 potential 0
from 2.700000e-03 2.700000e-03 0.000000e+00
to   2.400000e-03 2.700000e-03 0.000000e+00
to   2.700000e-03 2.400000e-03 0.000000e+00
sweep_direction Z

object3 BLOCK
conductor on medium 0 potential 0
from -2.600000e-03 -2.600000e-03 1.000005e-03
to   2.600000e-03 2.600000e-03 1.000015e-03

object4 BLOCK
conductor on medium 0 potential 0
from -2.600000e-03 -2.600000e-03 -1.000015e-03
to   2.600000e-03 2.600000e-03 -1.000005e-03


[Boundaries]
;back this is the laser

;laser
outlet
from -2.600000e-03  -2.600000e-03 -1.000000e-03
to   -2.600000e-03  2.600000e-03 1.000000e-03
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
from 2.600000e-03  -2.600000e-03 -1.000000e-03
to   2.600000e-03  2.600000e-03 1.000000e-03
phase_velocity 1.0
drive_model NONE
;left
outlet
from -2.600000e-03  -2.600000e-03 -1.000000e-03
to   2.600000e-03  -2.600000e-03 1.000000e-03
phase_velocity 1.0
drive_model NONE
;right
outlet
from -2.600000e-03  2.600000e-03 -1.000000e-03
to   2.600000e-03  2.600000e-03 1.000000e-03
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -2.600000e-03  -2.600000e-03 -1.000000e-03
to   2.600000e-03  2.600000e-03 -1.000000e-03
phase_velocity 1.0
drive_model NONE
;top
outlet
from -2.600000e-03  -2.600000e-03 1.000000e-03
to   2.600000e-03  2.600000e-03 1.000000e-03
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
from -2.600000e-03  -2.600000e-03  -1.000000e-03
to   2.600000e-03  2.600000e-03  1.000000e-03
species 1
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
plasma ; C
from -2.600000e-03  -2.600000e-03  -1.000000e-03
to   2.600000e-03  2.600000e-03  1.000000e-03
species 10
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
plasma ; H
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
species 18
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;

;; emission from conductors
;;e-
emission child-langmuir field-stress
from -2.600000e-03 -2.600000e-03 -1.000000e-03
to   2.600000e-03 2.600000e-03 1.000000e-03
interval 1
species 17
discrete_numbers 2 2 2
inclusion SOLID
threshold 5.000000e+05
thermal_energy 1.0
movie_fraction 0.0

;;p+
emission child-langmuir field-stress
from -2.600000e-03 -2.600000e-03 -1.000000e-03
to   2.600000e-03 2.600000e-03 1.000000e-03
interval 1
species 19
discrete_numbers 2 2 2
inclusion SOLID
threshold 5.000000e+05
thermal_energy 1.0
movie_fraction 0.0

;;O+
emission child-langmuir field-stress
from -2.600000e-03 -2.600000e-03 -1.000000e-03
to   2.600000e-03 2.600000e-03 1.000000e-03
interval 1
species 11
discrete_numbers 2 2 2
inclusion SOLID
threshold 5.000000e+05
thermal_energy 1.0
movie_fraction 0.0

;;C+
emission child-langmuir field-stress
from -2.600000e-03 -2.600000e-03 -1.000000e-03
to   2.600000e-03 2.600000e-03 1.000000e-03
interval 1
species 2
discrete_numbers 2 2 2
inclusion SOLID
threshold 5.000000e+05
thermal_energy 1.0
movie_fraction 0.0

;; ionization states ;;
;; Hydrogen
higherstate              ; H -> p+
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
from -2.600000e-03 -2.600000e-03  -1.000000e-03
to   2.600000e-03 2.600000e-03  1.000000e-03
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
at -0.0026000000000000003 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0026000000000000003 0 0
 
;
extract3
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0026000000000000003 0
 
;
extract4
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0026000000000000003 0
 
;
extract5
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.001
 
;
extract6
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.001


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
energy total_energy
;
probe3
performance cpu_time
