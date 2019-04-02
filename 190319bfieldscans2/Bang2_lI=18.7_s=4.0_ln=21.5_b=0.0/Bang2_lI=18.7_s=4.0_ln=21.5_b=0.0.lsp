;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title " bfield linear scans, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   3.0000e-04
 time_step_ns 5.0000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 1000
rename_restart_flag ON
restart_interval 20

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
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1


;;pmovies

;
[Grid]
;
grid1

xmin             -1.100000e-03
xmax             1.100000e-03
x-cells          440
                                        ;

ymin             -8.800000e-04
ymax             8.800000e-04
y-cells          352


zmin             -8.800000e-04
zmax             8.800000e-04
z-cells          220

[Regions]
;

;total number of domains: 176

;
region1
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -8.800000e-04
ymax             8.800000e-04

zmin             -8.800000e-04
zmax             -4.400000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -8.800000e-04
ymax             8.800000e-04

zmin             -4.400000e-04
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -8.800000e-04
ymax             8.800000e-04

zmin             0.000000e+00
zmax             4.400000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -8.800000e-04
ymax             8.800000e-04

zmin             4.400000e-04
zmax             8.800000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]


[Boundaries]

;laser
outlet
from -1.100000e-03  -8.800000e-04 -8.800000e-04
to   -1.100000e-03  8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 4
analytic_function 6
time_delay 0.0

;laser
outlet
from 1.100000e-03  -8.800000e-04 -8.800000e-04
to   1.100000e-03  8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 7
analytic_function 9
time_delay 0.0

;left
outlet
from -1.100000e-03  -8.800000e-04 -8.800000e-04
to   1.100000e-03  -8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model NONE

;right
outlet
from -1.100000e-03  8.800000e-04 -8.800000e-04
to   1.100000e-03  8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -1.100000e-03  -8.800000e-04 -8.800000e-04
to   1.100000e-03  8.800000e-04 -8.800000e-04
phase_velocity 1.0
drive_model NONE

;top
outlet
from -1.100000e-03  -8.800000e-04 8.800000e-04
to   1.100000e-03  8.800000e-04 8.800000e-04
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
plasma ; e-
from -8.000000e-04 -7.000000e-04  -7.000000e-04
to   8.000000e-04 7.000000e-04  7.000000e-04
species 10
movie_tag 5
unbound off
discrete_numbers 2 2 2
density_function 1
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.050
;
plasma ; p+
from -8.000000e-04 -7.000000e-04  -7.000000e-04
to   8.000000e-04 7.000000e-04  7.000000e-04
species 11
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 2
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;
plasma ; O+
from -8.000000e-04  -7.000000e-04  -7.000000e-04
to   8.000000e-04  7.000000e-04  7.000000e-04
species 2
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 3
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;

;; emission from conductors
emission child-langmuir field-stress
from -1.100000e-03 -8.800000e-04 -8.800000e-04
to   1.100000e-03 8.800000e-04 8.800000e-04
interval 1
species 10
discrete_numbers 2 2 2
inclusion SOLID
thermal_energy 1.0
movie_fraction 0.0
;; ionization states ;;
higherstate              ; H -> p+
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
from -1.100000e-03 -8.800000e-04  -8.800000e-04
to   1.100000e-03 8.800000e-04  8.800000e-04
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
;;at -1.100000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 1.100000e-03 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 8.800000e-04 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -8.800000e-04 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0011 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0011 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.00088 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.00088 0
 
;
extract5
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.00088
 
;
extract6
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.00088


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
;;
function1 ; electrons

type 40
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 3.0

;;
function2 ; Protons

type 40
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function3 ; Oxygen

type 40
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

;;

function4 ; laser temporal function, sine squared
type 23   ; requires new modifications
coefficients 6.137836e+07 3.500000e-05 6.000000e-05 end

function5 ; laser polarization function
type 87
coefficients 0 1 0 end

function6 ; laser
type 86
laser
temporal_function 4
polarization_function 5
wavelength 7.800000e-05
spotsize 1.490000e-04
lp_mode 0 0
direction 1 0 0
focal_point 0.0 0.0 0.0
end

function7 ; laser temporal function, sine squared
type 23   ; requires new modifications
coefficients 6.137836e+07 3.500000e-05 6.000000e-05 end

function8 ; laser polarization function
type 87
coefficients 0 -1 0 end

function9 ; laser
type 86
laser
temporal_function 7
polarization_function 8
wavelength 7.800000e-05
spotsize 1.490000e-04
lp_mode 0 0
direction -1 0 0
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

