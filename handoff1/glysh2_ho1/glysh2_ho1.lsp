;;;
;; Use this sandpie for no plasma.

[Title]
simulation_title "bad glysh2 handoff1, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.0000e-03
 time_step_ns 6.0000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 11.8
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
field_dump_interval_ns 2.1e-06
dump_scalars_flag ON
scalar_dump_interval_ns 2.1e-06

;;pmovies


;
[Grid]
;
grid1
xmin             0.000000e+00
xmax             2.000000e-02
x-cells          800
                                        ;
;
ymin             -5.750000e-04
ymax             5.750000e-04
y-cells          500



[Regions]
;

;total number of domains: 44

;
region1
xmin             0.000000e+00
xmax             2.000000e-02

ymin             -5.750000e-04
ymax             5.750000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;


;

;
[Objects]


[Boundaries]
;back this is the laser

;laser
outlet
from 0.000000e+00  -5.750000e-04 0.000000e+00
to   0.000000e+00  5.750000e-04 0.000000e+00
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
from 2.000000e-02  -5.750000e-04 0.000000e+00
to   2.000000e-02  5.750000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE
;left
outlet
from 0.000000e+00  -5.750000e-04 0.000000e+00
to   2.000000e-02  -5.750000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE
;right
outlet
from 0.000000e+00  5.750000e-04 0.000000e+00
to   2.000000e-02  5.750000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
;; O
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
from 4.500000e-03  -2.300000e-05  0.000000e+00
to   2.000000e-02  2.300000e-03  0.000000e+00
species 1
movie_tag 3
unbound off
discrete_numbers 4 3 1
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
plasma ; C
from 4.500000e-03  -2.300000e-05  0.000000e+00
to   2.000000e-02  2.300000e-03  0.000000e+00
species 10
movie_tag 3
unbound off
discrete_numbers 4 3 1
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
plasma ; H
from 4.500000e-03 -2.300000e-05  0.000000e+00
to   2.000000e-02 2.300000e-03  0.000000e+00
species 18
movie_tag 3
unbound off
discrete_numbers 4 3 1
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 0.02

movie_fraction 0.000
;
;; cluster input

;;O0
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 1
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 2
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O++
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 3
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O3+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 4
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O4+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 5
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O5+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 6
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O6+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 7
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O7+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 8
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;O8+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 9
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C0
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 10
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 11
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C++
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 12
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C3+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 13
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C4+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 14
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C5+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 15
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;C6+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 16
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;H0
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 18
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;p+
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 19
electron_species 0
number_of_clusters 1
particle_data_file __handoff_part__
;;e-
cluster
from 0.000000e+00 -5.750000e+00 0.000000e+00
to   4.500000e+01 5.750000e+00 0.000000e+00
ion_species 0
electron_species 17
number_of_clusters 1
particle_data_file __handoff_part__
;; emission from conductors
;;e-
emission child-langmuir field-stress
from 0.000000e+00 -5.750000e-04 0.000000e+00
to   2.000000e-02 5.750000e-04 0.000000e+00
interval 1
species 17
discrete_numbers 4 3 1
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;p+
emission child-langmuir field-stress
from 0.000000e+00 -5.750000e-04 0.000000e+00
to   2.000000e-02 5.750000e-04 0.000000e+00
interval 1
species 19
discrete_numbers 4 3 1
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;O+
emission child-langmuir field-stress
from 0.000000e+00 -5.750000e-04 0.000000e+00
to   2.000000e-02 5.750000e-04 0.000000e+00
interval 1
species 11
discrete_numbers 4 3 1
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;;C+
emission child-langmuir field-stress
from 0.000000e+00 -5.750000e-04 0.000000e+00
to   2.000000e-02 5.750000e-04 0.000000e+00
interval 1
species 2
discrete_numbers 4 3 1
inclusion SOLID
threshold 0.000000e+00
thermal_energy 1.0
movie_fraction 0.0

;; ionization states ;;
;; Hydrogen
higherstate              ; H -> p+
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
from 0.000000e+00 -5.750000e-04  0.000000e+00
to   2.000000e-02 5.750000e-04  0.000000e+00
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
at 0.0 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.02 0 0
 
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
