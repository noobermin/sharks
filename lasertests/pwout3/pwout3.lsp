;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "lasertests: angle test, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   1.1000e-04
 time_step_ns 1.0000e-07

;;Restarts
dump_restart_flag ON
rename_restart_flag ON

;;Load Balancing
balance_interval 0.0
balance_interval_ns 0.0
load_balance_flag OFF

;;Field Solution and Modification
time_bias_coefficient 0.0
time_bias_iterations 0

;Don't touch? Hmm...
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
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1

dump_fields_flag ON
field_dump_interval_ns 1.0000000000000002e-06

;;pmovies

;
[Grid]
;
grid1
xmin             -2.000000e-04
xmax             2.000000e-04
x-cells          80
                                        ;
;
ymin             -1.500000e-03
ymax             1.500000e-03
y-cells          600

;
zmin             -6.000000e-04
zmax             6.000000e-04
z-cells          120

[Regions]
;

;total number of domains: 44

;
region1
xmin             -2.000000e-04
xmax             2.000000e-04

ymin             -1.500000e-03
ymax             1.500000e-03

zmin             -6.000000e-04
zmax             6.000000e-04
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;

;
[Objects]

object1 BLOCK
conductor on medium 0 potential 0
from -2.100000e-04 -1.500000e-03 -6.000000e-04
to   -2.000000e-04 1.500000e-03 6.000000e-04

object2 BLOCK
conductor on medium 0 potential 0
from 2.000000e-04 -1.500000e-03 -6.000000e-04
to   2.100000e-04 1.500000e-03 6.000000e-04

object3 BLOCK
conductor on medium 0 potential 0
from -2.000000e-04 1.500000e-03 -6.000000e-04
to   2.000000e-04 1.510000e-03 6.000000e-04

object4 BLOCK
conductor on medium 0 potential 0
from -2.000000e-04 -1.510000e-03 -6.000000e-04
to   2.000000e-04 -1.500000e-03 6.000000e-04

object5 BLOCK
conductor on medium 0 potential 0
from -2.000000e-04 -1.500000e-03 6.000000e-04
to   2.000000e-04 1.500000e-03 6.100000e-04

object6 BLOCK
conductor on medium 0 potential 0
from -2.000000e-04 -1.500000e-03 -6.100000e-04
to   2.000000e-04 1.500000e-03 -6.000000e-04


[Boundaries]

;freespace boundaries
freespace
from -2.000000e-04  -1.500000e-03 -6.000000e-04
to   2.000000e-04  1.500000e-03 6.000000e-04
model_type CFSPML
number_of_cells 8
phase_velocity 1.0
reference_point 0.0 0.0 0.0

planewave
from -1.500000e-04  -1.600000e-03 -7.000000e-04
to   3.000000e-04  1.600000e-03 7.000000e-04
reference_point 0.0 0.0 0.0
polar_angle 90          
azimuthal_angle  45
rotation_angle 0
frequency 1000.0
temporal_function 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 2.000000e-05
;; Emax, intensity=5.000000e+18 W/cm^2
dependent_variable_multiplier   6.137836e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~2.668223128318498
          ; \lambda spotsize
coefficients 8.000000e-05 1.358915e-04 end

function3
type 83
temporal 1
spatial 2
end



[Probes]
;
probe1
energy net_energy
;
probe2
energy field_energy
;
probe3
energy total_energy
;
probe4
performance cpu_time
