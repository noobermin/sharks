;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "lasertests: angle test, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   1.2000e-04
 time_step_ns 1.0000e-07

;;Restarts
dump_restart_flag ON
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
xmin             -3.000000e-04
xmax             0.000000e+00
x-cells          60
                                        ;
;
ymin             -1.000000e-03
ymax             1.000000e-03
y-cells          400

;
zmin             -4.000000e-04
zmax             4.000000e-04
z-cells          80

[Regions]
;

;total number of domains: 44

;
region1
xmin             -3.000000e-04
xmax             0.000000e+00

ymin             -1.000000e-03
ymax             1.000000e-03

zmin             -4.000000e-04
zmax             4.000000e-04
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;

;
[Objects]


[Boundaries]

;laser
outlet
from -3.000000e-04  -1.000000e-03 -4.000000e-04
to   -3.000000e-04  1.000000e-03 4.000000e-04
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0.7853981633974483 0.0 -0.001
temporal_function 1
analytic_function 2
time_delay 0.0

;freespace boundaries
freespace
from -3.200000e-04  -1.000000e-03 -4.000000e-04
to   2.000000e-05  1.000000e-03 4.000000e-04
model_type CFSPML
number_of_cells 8
phase_velocity 1.0
reference_point 0.0 0.0 0.0

;back
outlet
from 0.000000e+00  -1.000000e-03 -4.000000e-04
to   0.000000e+00  1.000000e-03 4.000000e-04
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 3.000000e-05
;; Emax, intensity=5.000000e+18 W/cm^2
dependent_variable_multiplier   6.137836e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~2.668223128318498
          ; \lambda spotsize
coefficients 8.000000e-05 1.358915e-04 end



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
