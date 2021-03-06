;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "gauss test, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.0000e-04
 time_step_ns 5.0000e-08

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

xmin             -2.000000e-03
xmax             1.300000e-03
x-cells          660
                                        ;

ymin             -1.320000e-03
ymax             1.320000e-03
y-cells          528


zmin             -1.320000e-03
zmax             1.320000e-03
z-cells          528

[Regions]
;

;total number of domains: 352

;
region1
xmin             -2.000000e-03
xmax             -3.500000e-04

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -2.000000e-03
xmax             -3.500000e-04

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -2.000000e-03
xmax             -3.500000e-04

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -2.000000e-03
xmax             -3.500000e-04

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -3.500000e-04
xmax             1.300000e-03

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region6
xmin             -3.500000e-04
xmax             1.300000e-03

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region7
xmin             -3.500000e-04
xmax             1.300000e-03

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;
;
region8
xmin             -3.500000e-04
xmax             1.300000e-03

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction YSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]


[Boundaries]

;laser
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   -2.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 6
time_delay 0.0

;front
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   -2.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;back
outlet
from 1.300000e-03  -1.320000e-03 -1.320000e-03
to   1.300000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;left
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   1.300000e-03  -1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -2.000000e-03  1.320000e-03 -1.320000e-03
to   1.300000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   1.300000e-03  1.320000e-03 -1.320000e-03
phase_velocity 1.0
drive_model NONE

;top
outlet
from -2.000000e-03  -1.320000e-03 1.320000e-03
to   1.300000e-03  1.320000e-03 1.320000e-03
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
from -2.000000e-04 -5.000000e-04  -5.000000e-04
to   1.800000e-04 5.000000e-04  5.000000e-04
species 10
movie_tag 5
unbound off
discrete_numbers 2 2 2
density_function 1
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.050
;
plasma ; p+
from -2.000000e-04 -5.000000e-04  -5.000000e-04
to   1.800000e-04 5.000000e-04  5.000000e-04
species 11
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 2
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;
plasma ; O+
from -2.000000e-04  -5.000000e-04  -5.000000e-04
to   1.800000e-04  5.000000e-04  5.000000e-04
species 2
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 3
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;

;; emission from conductors
emission child-langmuir field-stress
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to   1.300000e-03 1.320000e-03 1.320000e-03
interval 1
species 10
discrete_numbers 2 2 2
inclusion SOLID
thermal_energy 1.0
movie_fraction 0.0
;; ionization states ;;
higherstate              ; H -> p+
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300000e-03 1.320000e-03  1.320000e-03
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
;;at -2.000000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 1.300000e-03 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 1.320000e-03 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -1.320000e-03 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.002 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0013 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.00132 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.00132 0
 
;
extract5
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.00132
 
;
extract6
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.00132


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
;;
function1 ; electrons

type 1
coefficients 0.000000e+00 end

;;
function2 ; Protons

type 1
coefficients 0.000000e+00 end

;;
function3 ; Oxygen

type 1
coefficients 0.000000e+00 end

;;


function4 ; temporal laser function
type 16
coefficients 6.137836e+07 2.547965e-05 8.000000e-05 -2.000000e-05 end


function5 ; 
type 87
coefficients 0.000000e+00 1.000000e+00 0.000000e+00 end



function6 ; laser
type 86
laser
  temporal_function 4
  polarization_function 5
  wavelength 7.800000e-05
  spotsize 7.800000e-05
  lp_mode 0 0
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

