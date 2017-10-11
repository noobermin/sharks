;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "intensity background pressure scans, I = 1.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   3.0000e-04
 time_step_ns 7.5000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 23.95
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
dump_number_densities_flag ON
dump_plasma_quantities_flag ON
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1

dump_fields_flag ON
field_dump_interval_ns 1.5e-07
dump_scalars_flag ON
scalar_dump_interval_ns 1.5e-07

;;pmovies

particle_movie_interval_ns 1.5e-07
particle_movie_components Q X Y Z VX VY VZ XI YI ZI

;
[Grid]
;
grid1
xmin             -4.500000e-03
xmax             1.000000e-03
x-cells          2200
                                        ;
;
ymin             -2.000000e-03
ymax             2.000000e-03
y-cells          1600



[Regions]
;

;total number of domains: 66

;
region1
xmin             -4.500000e-03
xmax             1.000000e-03

ymin             -2.000000e-03
ymax             2.000000e-03

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 66
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;


;

;
[Objects]

object1 BLOCK
conductor on medium 0 potential 0
from 2.400000e-04  -1.100000e-03 0.000000e+00
to   1.100000e-03  1.100000e-03 0.000000e+00


[Boundaries]

;laser
outlet
from -4.500000e-03  -2.000000e-03 0.000000e+00
to   -4.500000e-03  2.000000e-03 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point -0.001 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 2
time_delay 0.0

;back
outlet
from 1.000000e-03  -2.000000e-03 0.000000e+00
to   1.000000e-03  2.000000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE
;left
outlet
from -4.500000e-03  -2.000000e-03 0.000000e+00
to   1.000000e-03  -2.000000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE
;right
outlet
from -4.500000e-03  2.000000e-03 0.000000e+00
to   1.000000e-03  2.000000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
species1 ; neutral O
charge 0
mass 29164.4
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
mass 29163.4
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
mass 29162.4
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
mass 29161.4
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
mass 29160.4
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
mass 29159.4
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
mass 29158.4
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
mass 29157.4
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
mass 29156.4
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
selection_ratio 1.0
;
species11 ; protons
charge +1
mass 1836.2
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
species12 ; H atom
charge 0
mass 1837.4
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Particle Creation]

;; initial states ;;

plasma ; O+
from -4.400000e-03  -3.400000e-03  0.000000e+00
to   9.000000e-04  3.400000e-03  0.000000e+00
species 2
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;
plasma ; e-
from -4.400000e-03 -3.400000e-03  0.000000e+00
to   9.000000e-04 3.400000e-03  0.000000e+00
species 10
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.050
;
plasma ; p+
from -4.400000e-03 -3.400000e-03  0.000000e+00
to   9.000000e-04 3.400000e-03  0.000000e+00
species 11
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000

;; ionization states ;;
higherstate              ; H -> p+
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
interval 1
species 12
ion_species 11
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
higherstate              ; O -> O+
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
from -4.500000e-03 -2.000000e-03  0.000000e+00
to   1.000000e-03 2.000000e-03  0.000000e+00
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
;;at -4.500000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 1.000000e-03 0 0
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
at -0.0045000000000000005 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.001 0 0
 
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 2.100000e-05
;; Emax, intensity=1.000000e+18 W/cm^2
dependent_variable_multiplier   2.744924e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~3.762878770705575
          ; \lambda spotsize
coefficients 7.800000e-05 1.868508e-04 end

;;
function3 ; electrons

type 40
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 3.0

;;
function4 ; Oxygen

type 40
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

;;
function5 ; Protons

type 40
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

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
