[Title]
simulation_title "10um-2e+17-L=1.5-fn=4.4-cs=1, I = 1.560481e+17 W/cm^2"
;
[Control]
;Time-advance
 time_limit   3.5897e-03
 time_step_ns 1.2829e-06

;;Restarts
dump_restart_flag OFF
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
field_dump_interval_ns 2.5658776553704005e-06
dump_scalars_flag ON
scalar_dump_interval_ns 2.5658776553704005e-06

;;pmovies

;
[Grid]
;
grid1
xmin             -4.000000e-03
xmax             2.500000e-03
x-cells          130
                                        ;
;
ymin             -1.440000e-02
ymax             1.440000e-02
y-cells          576



[Regions]
;

;total number of domains: 64

;
region1
xmin             -4.000000e-03
xmax             2.500000e-03

ymin             -1.440000e-02
ymax             1.440000e-02

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 64
split_direction YSPLIT
number_of_cells AUTO ; cells = 0
;


;
;
[Boundaries]
;back this is the laser
outlet
from -4.000000e-03 -1.440000e-02 0.000000e+00
to   -4.000000e-03 1.440000e-02 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point -0.002365242431 0.0 0.0 ; focal point position
components 0 1 0
phases 0 0 0 ; polarization 1.1781
temporal_function 1
analytic_function 2
time_delay 0.0
;front (back of the target)
outlet
from  2.500000e-03 -1.440000e-02 0.000000e+00
to    2.500000e-03 1.440000e-02 0.000000e+00
phase_velocity 1.0
drive_model NONE

;right
outlet
from -4.000000e-03  1.440000e-02 0.000000e+00
to   2.500000e-03  1.440000e-02 0.000000e+00
phase_velocity 1.0
drive_model NONE
;left
outlet
from -4.000000e-03  -1.440000e-02 0.000000e+00
to   2.500000e-03  -1.440000e-02 0.000000e+00
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
species1 ; neutral O
charge 0
mass 29392
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
mass 29391
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
mass 29390
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
mass 29389
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
mass 29388
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
mass 29387
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
mass 29386
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
mass 29385
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
mass 29384
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
selection_ratio 0.01
;
species11 ; protons
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
from -2.500000e-03  -1.290000e-02  0.000000e+00
to   1.000000e-03  1.290000e-02  0.000000e+00
species 2
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 4
reference_point -2.500000e-03 -1.290000e-02 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
plasma ; e-
from -2.500000e-03 -1.290000e-02  0.000000e+00
to   1.000000e-03 1.290000e-02  0.000000e+00
species 10
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 3
reference_point -2.500000e-03 -1.290000e-02 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.050
;
plasma ; p+
from -2.500000e-03 -1.290000e-02  0.000000e+00
to   1.000000e-03 1.290000e-02  0.000000e+00
species 11
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 5
reference_point -2.500000e-03 -1.290000e-02 0.000000e+00
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000

;; ionization states ;;
;
higherstate              ; O -> O+
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
from -4.000000e-03 -1.440000e-02  0.000000e+00
to   2.500000e-03 1.440000e-02  0.000000e+00
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
;;at -4.000000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 2.500000e-03 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 1.440000e-02 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -1.440000e-02 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.004 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0025 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0144 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0144 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier 1.025641e-03
;; Emax, intensity=1.560481e+17 W/cm^2
dependent_variable_multiplier   1.084325e+07

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~4.430451178139451
          ; \lambda spotsize
coefficients 1.000000e-03 2.820513e-03 end

;;
function3 ; electrons

type 30
data_file 1.50um.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

;;
function4 ; Oxygen

type 30
data_file 1.50um.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 0.33

;;
function5 ; Protons

type 30
data_file 1.50um.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 0.67

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
