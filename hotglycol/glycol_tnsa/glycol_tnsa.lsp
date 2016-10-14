[Title]
simulation_title "hotglycol TNSA stage 1, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   7.0000e-05
 time_step_ns 1.0000e-08
;Restart

;Parallel Processing
 balance_interval_ns 0
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
;(Diagnostic Output) Flags
 dump_current_density_flag OFF
 dump_fields_flag ON
 dump_scalars_flag ON
 dump_plasma_quantities_flag ON
 dump_velocities_flag OFF
 dump_particles_flag OFF
 dump_number_densities_flag ON
 ;dump_time_zero_flag ON ; dump the results of the 'zeroth' time step...does it actually start?
 extract_photons_flag OFF
 dump_particles_flag OFF
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 5e-08
 dump_steps
1 
end
 spatial_skip_x 1
 spatial_skip_y 1
 spatial_skip_z 1
 probe_interval 1
;(Diagnostic Output) Formats
 photon_output_format ASCII
 target_output_format ASCII
 use_its_format_flag OFF
 print_region_flag OFF
;(Diagnostic Output) Movie Controls
;particle_movie_interval_ns 5e-08
;particle_movie_components Q X Y Z VX VY VZ XI YI ZI

particle_movie_interval_ns 5e-08
particle_movie_components Q X Y Z VX VY VZ XI YI ZI

;Numerical Checks and Reports
 domain_boundary_check ON
 report_timing_flag ON
 dump_timing_flag ON
;
[Grid]
;
grid1
xmin             -2.500000e-04
xmax             2.500000e-04
x-cells          1000
                                        ;
;
ymin             -8.500000e-04
ymax             8.500000e-04
y-cells          3400



[Regions]
;

;total number of domains: 384

;
region1
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             -8.500000e-04
ymax             -6.375000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region2
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             -6.375000e-04
ymax             -4.250000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region3
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             -4.250000e-04
ymax             -2.125000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region4
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             -2.125000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region5
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             0.000000e+00
ymax             2.125000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region6
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             2.125000e-04
ymax             4.250000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region7
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             4.250000e-04
ymax             6.375000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;
;
region8
xmin             -2.500000e-04
xmax             2.500000e-04

ymin             6.375000e-04
ymax             8.500000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 48
split_direction XSPLIT
number_of_cells AUTO ; cells = 0
;


;
;
[Boundaries]
;back this is the laser
outlet
from -2.500000e-04 -8.500000e-04 0.000000e+00
to   -2.500000e-04 8.500000e-04 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point -1e-05 0.0 0.0 ; focal point position
components 0 1 0
phases 0 0 0 ; polarization 1.1781
temporal_function 1
analytic_function 2
time_delay 0.0
;front (back of the target)
outlet
from  2.500000e-04 -8.500000e-04 0.000000e+00
to    2.500000e-04 8.500000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE

;right
outlet
from -2.500000e-04  8.500000e-04 0.000000e+00
to   2.500000e-04  8.500000e-04 0.000000e+00
phase_velocity 1.0
drive_model NONE
;left
outlet
from -2.500000e-04  -8.500000e-04 0.000000e+00
to   2.500000e-04  -8.500000e-04 0.000000e+00
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
selection_ratio 0.05
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.05
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01
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
selection_ratio 0.01

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
selection_ratio 0.01
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
selection_ratio 0.01

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Particle Creation]

;; initial states ;;

plasma ; O+
from -1.000000e-05  -6.000000e-04  0.000000e+00
to   1.000000e-05  6.000000e-04  0.000000e+00
species 2
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 4
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
plasma ; C+
from -1.000000e-05  -6.000000e-04  0.000000e+00
to   1.000000e-05  6.000000e-04  0.000000e+00
species 11
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 5
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;

plasma ; e-
from -1.000000e-05 -6.000000e-04  0.000000e+00
to   1.000000e-05 6.000000e-04  0.000000e+00
species 17
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 3
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.050
;
plasma ; p+
from -1.000000e-05 -6.000000e-04  0.000000e+00
to   1.000000e-05 6.000000e-04  0.000000e+00
species 18
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 6
reference_point 0.000000e+00 0.000000e+00 0.000000e+00
density_flags 1 1 1
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000

;; ionization states ;;
;; Oxygen
higherstate              ; O -> O+
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
from -2.500000e-04 -8.500000e-04  0.000000e+00
to   2.500000e-04 8.500000e-04  0.000000e+00
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
at -0.00025 0 0
 
;
extract2
species 17
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.00025 0 0
 
;
extract3
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0008500000000000001 0
 
;
extract4
species 17
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0008500000000000001 0
 
;
extract5
species 18
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.00025 0 0
 
;
extract6
species 18
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.00025 0 0
 
;
extract7
species 18
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0008500000000000001 0
 
;
extract8
species 18
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0008500000000000001 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 4.405673e-05
;; Emax, intensity=5.000000e+18 W/cm^2
dependent_variable_multiplier   6.137836e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~3.4235304558350315
          ; \lambda spotsize
coefficients 7.800000e-05 1.700000e-04 end

;;
function3 ; electrons

type 30
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 10.0

;;
function4 ; Oxygen

type 30
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function5 ; Carbon

type 30
data_file target.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2.0

;;
function6 ; Protons

type 30
data_file target.dat
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