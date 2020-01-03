;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "gauss test, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.000000e-04
 time_step_ns 5.000000e-08

;;Restarts
dump_restart_flag ON
rename_restart_flag ON
restart_interval 20

;;Load Balancing
balance_interval 0
balance_interval_ns 0.0
load_balance_flag OFF

;;Field Solution and Modification
time_bias_coefficient 0.0
time_bias_iterations 1

;;Implicit Field Algorithm (mostly don't touch,for use in high density plasma)
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
;
grid1

xmin             -2.010000e-03
xmax             1.000000e-05
x-cells          400
                                        ;

ymin             -1.320000e-03
ymax             1.320000e-03
y-cells          528


zmin             -1.320000e-03
zmax             1.320000e-03
z-cells          528

[Regions]
;

;total number of domains: 224

;
region1
xmin             -2.010000e-03
xmax             -1.000000e-03

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -2.010000e-03
xmax             -1.000000e-03

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -2.010000e-03
xmax             -1.000000e-03

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -2.010000e-03
xmax             -1.000000e-03

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -1.000000e-03
xmax             1.000000e-05

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region6
xmin             -1.000000e-03
xmax             1.000000e-05

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region7
xmin             -1.000000e-03
xmax             1.000000e-05

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region8
xmin             -1.000000e-03
xmax             1.000000e-05

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 28
split_direction YSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]


[Boundaries]

;laser
outlet
from -2.010000e-03  -1.320000e-03 -1.320000e-03
to   -2.010000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 4
time_delay 0.0

;front
outlet
from -2.010000e-03  -1.320000e-03 -1.320000e-03
to   -2.010000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;back
outlet
from 1.000000e-05  -1.320000e-03 -1.320000e-03
to   1.000000e-05  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;left
outlet
from -2.010000e-03  -1.320000e-03 -1.320000e-03
to   1.000000e-05  -1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -2.010000e-03  1.320000e-03 -1.320000e-03
to   1.000000e-05  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -2.010000e-03  -1.320000e-03 -1.320000e-03
to   1.000000e-05  1.320000e-03 -1.320000e-03
phase_velocity 1.0
drive_model NONE

;top
outlet
from -2.010000e-03  -1.320000e-03 1.320000e-03
to   1.000000e-05  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
;;


function1 ; temporal laser function
type 16
coefficients 6.137836e+07 2.547965e-05 8.000000e-05 -2.000000e-05 end

function2
type 55
data_file gaussreal.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

function3
type 55
data_file gaussimag.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0



function4 ; laser
type 56
laser
  temporal_function 1
  Ey_real 2
  Ey_imag 3
  wavelength 7.800000e-05
  direction 1 0 0
  focal_point 0.0 0.0 0.0

end


[Probes]
;
probe1
energy net_energy
;
probe2
energy total_energy
;
probe3
energy particle_energy
;
probe4
energy field_energy
;
probe5
performance cpu_time

