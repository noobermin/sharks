;;;
;; Use this sandpie for no plasma.

[Title]
simulation_title "Hotwater in 2d, I = 0.000000e+00 W/cm^2"
;
[Control]
;Time-advance
 time_limit   8.0000e-05
 time_step_ns 4.0000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 0.75
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

;;Field Solution and Modification

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
field_dump_interval_ns 2.5e-06
dump_particles_flag ON
particle_dump_interval_ns 2.5e-06

;;pmovies


;
[Grid]
;
grid1
xmin             4.800000e-04
xmax             4.880000e-03
x-cells          440
                                        ;
;
ymin             -5.750000e-04
ymax             5.750000e-04
y-cells          500

;
zmin             -3.000000e-03
zmax             3.000000e-03
z-cells          600

[Regions]
;

;total number of domains: 660

;
region1
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -3.000000e-03
zmax             -2.600000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region2
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -2.600000e-03
zmax             -2.200000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region3
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -2.200000e-03
zmax             -1.800000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region4
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -1.800000e-03
zmax             -1.400000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region5
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -1.400000e-03
zmax             -1.000000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region6
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -1.000000e-03
zmax             -6.000000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region7
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -6.000000e-04
zmax             -2.000000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region8
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             -2.000000e-04
zmax             2.000000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region9
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             2.000000e-04
zmax             6.000000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region10
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             6.000000e-04
zmax             1.000000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region11
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             1.000000e-03
zmax             1.400000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region12
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             1.400000e-03
zmax             1.800000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region13
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             1.800000e-03
zmax             2.200000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region14
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             2.200000e-03
zmax             2.600000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;
;
region15
xmin             4.800000e-04
xmax             4.880000e-03

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             2.600000e-03
zmax             3.000000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 8800000
;


;

;
[Objects]

object1 BLOCK
conductor on medium 0 potential 0
from 3.900000e-04 -5.750000e-04 -3.000000e-03
to   4.900000e-04 5.750000e-04 3.000000e-03

object2 BLOCK
conductor on medium 0 potential 0
from 4.800000e-04 -6.650000e-04 -3.000000e-03
to   4.880000e-03 -5.650000e-04 3.000000e-03

object3 BLOCK
conductor on medium 0 potential 0
from 4.800000e-04 5.650000e-04 -3.000000e-03
to   4.880000e-03 6.650000e-04 3.000000e-03


[Boundaries]
;back this is the laser

;front
outlet
from 4.800000e-04  -5.750000e-04 -3.000000e-03
to   4.800000e-04  5.750000e-04 3.000000e-03
phase_velocity 1.0
drive_model NONE
;back
outlet
from 4.880000e-03  -5.750000e-04 -3.000000e-03
to   4.880000e-03  5.750000e-04 3.000000e-03
phase_velocity 1.0
drive_model NONE
;left
outlet
from 4.800000e-04  -5.750000e-04 -3.000000e-03
to   4.880000e-03  -5.750000e-04 3.000000e-03
phase_velocity 1.0
drive_model NONE
;right
outlet
from 4.800000e-04  5.750000e-04 -3.000000e-03
to   4.880000e-03  5.750000e-04 3.000000e-03
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from 4.800000e-04  -5.750000e-04 -3.000000e-03
to   4.880000e-03  5.750000e-04 -3.000000e-03
phase_velocity 1.0
drive_model NONE
;top
outlet
from 4.800000e-04  -5.750000e-04 3.000000e-03
to   4.880000e-03  5.750000e-04 3.000000e-03
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
selection_ratio 0.25
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
selection_ratio 0.25
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
selection_ratio 0.25
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
from 4.800000e-04  -2.300000e-05  -3.000000e-03
to   4.880000e-03  2.300000e-05  3.000000e-03
species 1
movie_tag 3
unbound off
discrete_numbers 2 1 2
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
plasma ; C
from 4.800000e-04  -2.300000e-05  -3.000000e-03
to   4.880000e-03  2.300000e-05  3.000000e-03
species 10
movie_tag 3
unbound off
discrete_numbers 2 1 2
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
plasma ; H
from 4.800000e-04 -2.300000e-05  -3.000000e-03
to   4.880000e-03 2.300000e-05  3.000000e-03
species 18
movie_tag 3
unbound off
discrete_numbers 2 1 2
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
;; handoff

fileread
from 0.0005 -0.000575 -0.004
to   0.0005 0.000575 0.004
normal X
interval 1
species 17
particle_data_file glysh8-synthpextnewx.p4
temporal_function 6
reference_point 0.0 0.0 0.0
recycle_time 0
time_advance 0



fileread
from 0.0005 -0.000575 -0.004
to   0.0005 0.000575 0.004
normal X
interval 1
species 19
particle_data_file glysh8-synthpext-neutralnewx.p4
temporal_function 6
reference_point 0.0 0.0 0.0
recycle_time 0
time_advance 0




;; emission from conductors
;;e-
emission child-langmuir field-stress
from 4.800000e-04 -5.750000e-04 -3.000000e-03
to   4.880000e-03 5.750000e-04 3.000000e-03
interval 1
species 17
discrete_numbers 2 1 2
inclusion SOLID
threshold 5.000000e+01
thermal_energy 1.0
movie_fraction 0.0

;;p+
emission child-langmuir field-stress
from 4.800000e-04 -5.750000e-04 -3.000000e-03
to   4.880000e-03 5.750000e-04 3.000000e-03
interval 1
species 19
discrete_numbers 2 1 2
inclusion SOLID
threshold 5.000000e+01
thermal_energy 1.0
movie_fraction 0.0

;;O+
emission child-langmuir field-stress
from 4.800000e-04 -5.750000e-04 -3.000000e-03
to   4.880000e-03 5.750000e-04 3.000000e-03
interval 1
species 11
discrete_numbers 2 1 2
inclusion SOLID
threshold 5.000000e+01
thermal_energy 1.0
movie_fraction 0.0

;;C+
emission child-langmuir field-stress
from 4.800000e-04 -5.750000e-04 -3.000000e-03
to   4.880000e-03 5.750000e-04 3.000000e-03
interval 1
species 2
discrete_numbers 2 1 2
inclusion SOLID
threshold 5.000000e+01
thermal_energy 1.0
movie_fraction 0.0

;; ionization states ;;
;; Hydrogen
higherstate              ; H -> p+
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
from 4.800000e-04 -5.750000e-04  -3.000000e-03
to   4.880000e-03 5.750000e-04  3.000000e-03
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
at 0.00048 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.00488 0 0
 
;
extract3
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.000575 0
 
;
extract4
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.000575 0
 
;
extract5
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.003
 
;
extract6
species 17
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.003


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 0.000000e+00
;; Emax, intensity=0.000000e+00 W/cm^2
dependent_variable_multiplier   0.000000e+00

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~0.0
          ; \lambda spotsize
coefficients 1.000000e+02 0.000000e+00 end

;;
function3 ; O

type 30
data_file target_dumb.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function4 ; C

type 30
data_file target_dumb.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function5 ; H

type 30
data_file target_dumb.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 6.0

;;


function6
type 3
coefficients 1 80e-6 ; 80fs


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
