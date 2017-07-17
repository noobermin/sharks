[Title]
simulation_title "hotglycol TNSA absorption, I = 1.000000e+14 W/cm^2"
;
[Control]
;Time-advance
 time_limit   1.4000e-04
 time_step_ns 2.0000e-08

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
dump_number_densities_flag ON
dump_plasma_quantities_flag ON
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1

dump_fields_flag ON
field_dump_interval_ns 5.000000000000001e-07
dump_scalars_flag ON
scalar_dump_interval_ns 5.000000000000001e-07
dump_particles_flag ON
particle_dump_interval_ns 0.0
particle_dump_times_ns 0.0001 0.00011 0.00014 end

;;pmovies

particle_movie_interval_ns 5.000000000000001e-07
particle_movie_components Q X Y Z VX VY VZ XI YI ZI


;
[Grid]
;
grid1
xmin             -7.000000e-04
xmax             7.000000e-04
x-cells          1400
                                        ;
;
ymin             -7.000000e-04
ymax             7.000000e-04
y-cells          1400



[Regions]
;

;total number of domains: 196

;
region1
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -7.000000e-04
ymax             -6.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region2
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -6.000000e-04
ymax             -5.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region3
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -5.000000e-04
ymax             -4.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region4
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -4.000000e-04
ymax             -3.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region5
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -3.000000e-04
ymax             -2.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region6
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -2.000000e-04
ymax             -1.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region7
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             -1.000000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region8
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             0.000000e+00
ymax             1.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region9
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             1.000000e-04
ymax             2.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region10
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             2.000000e-04
ymax             3.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region11
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             3.000000e-04
ymax             4.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region12
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             4.000000e-04
ymax             5.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region13
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             5.000000e-04
ymax             6.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region14
xmin             -7.000000e-04
xmax             7.000000e-04

ymin             6.000000e-04
ymax             7.000000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 14
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;


;
;
[Boundaries]
;back this is the laser

;laser
outlet
from -7.000000e-04  -7.000000e-04 0.000000e+00
to   -7.000000e-04  7.000000e-04 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point -0.0001 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 2
time_delay 0.0

;back
outlet
from 7.000000e-04  -7.000000e-04 0.000000e+00
to   7.000000e-04  7.000000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE
;left
outlet
from -7.000000e-04  -7.000000e-04 0.000000e+00
to   7.000000e-04  -7.000000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE
;right
outlet
from -7.000000e-04  7.000000e-04 0.000000e+00
to   7.000000e-04  7.000000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
;; O
species1 ; neutral O
charge 0
mass 29165
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
mass 29164
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
mass 29163
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
mass 29162
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
mass 29161
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
mass 29160
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
mass 29159
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
mass 29158
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
mass 29157
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
mass 21874.6
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
mass 21783.6
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
mass 21782.6
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
mass 21781.6
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
mass 21780.6
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
mass 21779.6
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
mass 21778.6
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
species18 ; protons
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Particle Creation]

;; initial states ;;

plasma ; O+
from -5.000000e-04  -5.000000e-04  0.000000e+00
to   5.000000e-04  5.000000e-04  0.000000e+00
species 2
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.01

movie_fraction 0.000
;
plasma ; C+
from -5.000000e-04  -5.000000e-04  0.000000e+00
to   5.000000e-04  5.000000e-04  0.000000e+00
species 11
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.01

movie_fraction 0.000
;

plasma ; e-
from -5.000000e-04 -5.000000e-04  0.000000e+00
to   5.000000e-04 5.000000e-04  0.000000e+00
species 17
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.01

movie_fraction 0.050
;
plasma ; p+
from -5.000000e-04 -5.000000e-04  0.000000e+00
to   5.000000e-04 5.000000e-04  0.000000e+00
species 18
movie_tag 3
unbound off
discrete_numbers 3 3 1
density_function 6
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 0.01

movie_fraction 0.000

;; ionization states ;;
;; Oxygen
higherstate              ; O -> O+
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 1
ion_species 2
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 2
ion_species 3
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 3
ion_species 4
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 4
ion_species 5
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 5
ion_species 6
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 6
ion_species 7
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 7
ion_species 8
movie_tag 5
electron_species 17
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 8
ion_species 9
movie_tag 5
electron_species 17
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
;
;; carbon
higherstate              ; C -> C+
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 10
ion_species 11
movie_tag 5
electron_species 17
movie_tag 3
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 11
ion_species 12
movie_tag 5
electron_species 17
movie_tag 3
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 12
ion_species 13
movie_tag 5
electron_species 17
movie_tag 3
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 13
ion_species 14
movie_tag 5
electron_species 17
movie_tag 3
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 14
ion_species 15
movie_tag 5
electron_species 17
movie_tag 3
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
from -7.000000e-04 -7.000000e-04  0.000000e+00
to   7.000000e-04 7.000000e-04  0.000000e+00
interval 1
species 15
ion_species 16
movie_tag 5
electron_species 17
movie_tag 3
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
at -0.0007 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0007 0 0
 
;
extract3
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0007 0
 
;
extract4
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0007 0
 
;
extract5
species 18
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0007 0 0
 
;
extract6
species 18
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0007 0 0
 
;
extract7
species 18
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0007 0
 
;
extract8
species 18
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0007 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 8.400000e-05
;; Emax, intensity=1.000000e+14 W/cm^2
dependent_variable_multiplier   2.744924e+05

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~3.762878770705575
          ; \lambda spotsize
coefficients 7.800000e-05 1.868508e-04 end

;;
function3 ; electrons

type 40
data_file target45.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 10.0

;;
function4 ; Oxygen

type 40
data_file target45.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function5 ; Carbon

type 40
data_file target45.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function6 ; Protons

type 40
data_file target45.dat
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
