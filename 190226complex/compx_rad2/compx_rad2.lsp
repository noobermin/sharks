;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "actual complex beam target interaction, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.0000e-04
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

xmin             -9.600000e-04
xmax             8.000100e-04
x-cells          440
                                        ;

ymin             -8.800000e-04
ymax             8.800000e-04
y-cells          220


zmin             -8.800000e-04
zmax             8.800000e-04
z-cells          220

[Regions]
;

;total number of domains: 176

;
region1
xmin             -9.600000e-04
xmax             8.000100e-04

ymin             -8.800000e-04
ymax             0.000000e+00

zmin             -8.800000e-04
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -9.600000e-04
xmax             8.000100e-04

ymin             -8.800000e-04
ymax             0.000000e+00

zmin             0.000000e+00
zmax             8.800000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -9.600000e-04
xmax             8.000100e-04

ymin             0.000000e+00
ymax             8.800000e-04

zmin             -8.800000e-04
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -9.600000e-04
xmax             8.000100e-04

ymin             0.000000e+00
ymax             8.800000e-04

zmin             0.000000e+00
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
from -9.600000e-04  -8.800000e-04 -8.800000e-04
to   -9.600000e-04  8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 4
time_delay 0.0

;back
outlet
from 8.000100e-04  -8.800000e-04 -8.800000e-04
to   8.000100e-04  8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model NONE

;left
outlet
from -9.600000e-04  -8.800000e-04 -8.800000e-04
to   8.000100e-04  -8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model NONE

;right
outlet
from -9.600000e-04  8.800000e-04 -8.800000e-04
to   8.000100e-04  8.800000e-04 8.800000e-04
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -9.600000e-04  -8.800000e-04 -8.800000e-04
to   8.000100e-04  8.800000e-04 -8.800000e-04
phase_velocity 1.0
drive_model NONE

;top
outlet
from -9.600000e-04  -8.800000e-04 8.800000e-04
to   8.000100e-04  8.800000e-04 8.800000e-04
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
from -1.000000e-04 -5.000000e-04  -5.000000e-04
to   1.550100e-04 5.000000e-04  5.000000e-04
species 10
movie_tag 5
unbound off
discrete_numbers 2 4 2
density_function 5
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.050
;
plasma ; p+
from -1.000000e-04 -5.000000e-04  -5.000000e-04
to   1.550100e-04 5.000000e-04  5.000000e-04
species 11
movie_tag 3
unbound off
discrete_numbers 2 4 2
density_function 6
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;
plasma ; O+
from -1.000000e-04  -5.000000e-04  -5.000000e-04
to   1.550100e-04  5.000000e-04  5.000000e-04
species 2
movie_tag 3
unbound off
discrete_numbers 2 4 2
density_function 7
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;

;; emission from conductors
emission child-langmuir field-stress
from -9.600000e-04 -8.800000e-04 -8.800000e-04
to   8.000100e-04 8.800000e-04 8.800000e-04
interval 1
species 10
discrete_numbers 2 4 2
inclusion SOLID
thermal_energy 1.0
movie_fraction 0.0
;; ionization states ;;
higherstate              ; H -> p+
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
from -9.600000e-04 -8.800000e-04  -8.800000e-04
to   8.000100e-04 8.800000e-04  8.800000e-04
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
;;at -9.600000e-04 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 8.000100e-04 0 0
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
at -0.0009599999999348235 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0008000099903484175 0 0
 
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
function1 ; laser temporal function, sine squared
type 23   ; requires new modifications
coefficients 6.137836e+07 3.500000e-05 6.000000e-05 end

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~1.5707963267948963
          ; \lambda spotsize
coefficients 7.800000e-05 7.800000e-05 end

function3 ; laser polarization function
type 87
coefficients 0 1 0 end

function4 ; laser
type 86
laser
temporal_function 1
polarization_function 3
wavelength 7.800000e-05
spotsize 7.800000e-05
lp_mode 0 0
direction 1 0 0
focal_point 0.0 0.0 0.0
end

;;
function5 ; electrons

type 0
data_pairs
-9.99999999e-05 1.62283600e+17
-9.74241414e-05 2.28787407e+17
-9.48482830e-05 3.22544470e+17
-9.22724245e-05 4.54723170e+17
-8.96965660e-05 6.41068692e+17
-8.71207075e-05 9.03778595e+17
-8.45448490e-05 1.27414700e+18
-8.19689905e-05 1.79629234e+18
-7.93931320e-05 2.53241281e+18
-7.68172735e-05 3.57019540e+18
-7.42414151e-05 5.03326121e+18
-7.16655566e-05 7.09589129e+18
-6.90896981e-05 1.00037870e+19
-6.65138396e-05 1.41033382e+19
-6.39379811e-05 1.98828852e+19
-6.13621226e-05 2.80308901e+19
-5.87862641e-05 3.95179467e+19
-5.62104056e-05 5.57123984e+19
-5.36345472e-05 7.85433352e+19
-5.10586887e-05 1.10730388e+20
-4.84828302e-05 1.56107693e+20
-4.59069717e-05 2.20080614e+20
-4.33311132e-05 3.10269634e+20
-4.07552547e-05 4.37418107e+20
-3.81793962e-05 6.16672016e+20
-3.56035377e-05 8.69384163e+20
-3.30276793e-05 1.22565773e+21
-3.04518208e-05 1.72793218e+21
-2.78759623e-05 2.43603866e+21
-2.53001038e-05 3.43432712e+21
-2.27242453e-05 4.84171412e+21
-2.01483868e-05 6.82584821e+21
-1.75725283e-05 9.62308031e+21
-1.49966698e-05 1.35666179e+22
-1.24208114e-05 1.91262169e+22
-9.84495286e-06 2.69641392e+22
-7.26909438e-06 3.80140415e+22
-4.69323589e-06 5.35921929e+22
-2.11737740e-06 7.55542697e+22
4.58481086e-07 1.00200000e+23
3.03433957e-06 1.00200000e+23
5.61019806e-06 1.00200000e+23
8.18605655e-06 1.00200000e+23
1.07619150e-05 1.00200000e+23
1.33377735e-05 1.00200000e+23
1.59136320e-05 1.00200000e+23
1.84894905e-05 1.00200000e+23
2.10653490e-05 1.00200000e+23
2.36412075e-05 1.00200000e+23
2.62170660e-05 1.00200000e+23
2.87929245e-05 1.00200000e+23
3.13687829e-05 1.00200000e+23
3.39446414e-05 1.00200000e+23
3.65204999e-05 1.00200000e+23
3.90963584e-05 1.00200000e+23
4.16722169e-05 1.00200000e+23
4.42480754e-05 1.00200000e+23
4.68239339e-05 1.00200000e+23
4.93997924e-05 1.00200000e+23
5.19756508e-05 1.00200000e+23
5.45515093e-05 1.00200000e+23
5.71273678e-05 1.00200000e+23
5.97032263e-05 1.00200000e+23
6.22790848e-05 1.00200000e+23
6.48549433e-05 1.00200000e+23
6.74308018e-05 1.00200000e+23
7.00066603e-05 1.00200000e+23
7.25825187e-05 1.00200000e+23
7.51583772e-05 1.00200000e+23
7.77342357e-05 1.00200000e+23
8.03100942e-05 9.41744909e+22
8.28859527e-05 5.62596538e+22
8.54618112e-05 3.36094055e+22
8.80376697e-05 2.00781921e+22
9.06135282e-05 1.19946721e+22
9.31893866e-05 7.16559328e+21
9.57652451e-05 4.28071119e+21
9.83411036e-05 2.55728837e+21
1.00916962e-04 1.52771899e+21
1.03492821e-04 9.12656291e+20
1.06068679e-04 5.45219056e+20
1.08644538e-04 3.25712781e+20
1.11220396e-04 1.94580169e+20
1.13796255e-04 1.16241806e+20
1.16372113e-04 6.94426242e+19
1.18947972e-04 4.14848858e+19
1.21523830e-04 2.47829884e+19
1.24099688e-04 1.48053080e+19
1.26675547e-04 8.84466163e+18
1.29251405e-04 5.28378329e+18
1.31827264e-04 3.15652164e+18
1.34403122e-04 1.88569976e+18
1.36978981e-04 1.12651329e+18
1.39554839e-04 6.72976804e+17
1.42130698e-04 4.02035006e+17
1.44706556e-04 2.40174914e+17
1.47282415e-04 1.43480017e+17
1.49858273e-04 8.57146771e+16
1.52434132e-04 5.12057779e+16
1.55009990e-04 3.05902300e+16
end

;;
function6 ; Protons

type 0
data_pairs
-9.99999999e-05 1.08189067e+17
-9.74241414e-05 1.52524938e+17
-9.48482830e-05 2.15029647e+17
-9.22724245e-05 3.03148780e+17
-8.96965660e-05 4.27379128e+17
-8.71207075e-05 6.02519064e+17
-8.45448490e-05 8.49431332e+17
-8.19689905e-05 1.19752823e+18
-7.93931320e-05 1.68827521e+18
-7.68172735e-05 2.38013027e+18
-7.42414151e-05 3.35550748e+18
-7.16655566e-05 4.73059419e+18
-6.90896981e-05 6.66919135e+18
-6.65138396e-05 9.40222547e+18
-6.39379811e-05 1.32552568e+19
-6.13621226e-05 1.86872600e+19
-5.87862641e-05 2.63452978e+19
-5.62104056e-05 3.71415990e+19
-5.36345472e-05 5.23622235e+19
-5.10586887e-05 7.38202588e+19
-4.84828302e-05 1.04071795e+20
-4.59069717e-05 1.46720410e+20
-4.33311132e-05 2.06846423e+20
-4.07552547e-05 2.91612072e+20
-3.81793962e-05 4.11114677e+20
-3.56035377e-05 5.79589442e+20
-3.30276793e-05 8.17105153e+20
-3.04518208e-05 1.15195478e+21
-2.78759623e-05 1.62402577e+21
-2.53001038e-05 2.28955141e+21
-2.27242453e-05 3.22780941e+21
-2.01483868e-05 4.55056547e+21
-1.75725283e-05 6.41538687e+21
-1.49966698e-05 9.04441194e+21
-1.24208114e-05 1.27508113e+22
-9.84495286e-06 1.79760928e+22
-7.26909438e-06 2.53426943e+22
-4.69323589e-06 3.57281286e+22
-2.11737740e-06 5.03695131e+22
4.58481086e-07 6.68000000e+22
3.03433957e-06 6.68000000e+22
5.61019806e-06 6.68000000e+22
8.18605655e-06 6.68000000e+22
1.07619150e-05 6.68000000e+22
1.33377735e-05 6.68000000e+22
1.59136320e-05 6.68000000e+22
1.84894905e-05 6.68000000e+22
2.10653490e-05 6.68000000e+22
2.36412075e-05 6.68000000e+22
2.62170660e-05 6.68000000e+22
2.87929245e-05 6.68000000e+22
3.13687829e-05 6.68000000e+22
3.39446414e-05 6.68000000e+22
3.65204999e-05 6.68000000e+22
3.90963584e-05 6.68000000e+22
4.16722169e-05 6.68000000e+22
4.42480754e-05 6.68000000e+22
4.68239339e-05 6.68000000e+22
4.93997924e-05 6.68000000e+22
5.19756508e-05 6.68000000e+22
5.45515093e-05 6.68000000e+22
5.71273678e-05 6.68000000e+22
5.97032263e-05 6.68000000e+22
6.22790848e-05 6.68000000e+22
6.48549433e-05 6.68000000e+22
6.74308018e-05 6.68000000e+22
7.00066603e-05 6.68000000e+22
7.25825187e-05 6.68000000e+22
7.51583772e-05 6.68000000e+22
7.77342357e-05 6.68000000e+22
8.03100942e-05 6.27829939e+22
8.28859527e-05 3.75064359e+22
8.54618112e-05 2.24062703e+22
8.80376697e-05 1.33854614e+22
9.06135282e-05 7.99644805e+21
9.31893866e-05 4.77706218e+21
9.57652451e-05 2.85380746e+21
9.83411036e-05 1.70485891e+21
1.00916962e-04 1.01847933e+21
1.03492821e-04 6.08437527e+20
1.06068679e-04 3.63479371e+20
1.08644538e-04 2.17141854e+20
1.11220396e-04 1.29720112e+20
1.13796255e-04 7.74945375e+19
1.16372113e-04 4.62950828e+19
1.18947972e-04 2.76565905e+19
1.21523830e-04 1.65219923e+19
1.24099688e-04 9.87020537e+18
1.26675547e-04 5.89644108e+18
1.29251405e-04 3.52252219e+18
1.31827264e-04 2.10434776e+18
1.34403122e-04 1.25713317e+18
1.36978981e-04 7.51008862e+17
1.39554839e-04 4.48651203e+17
1.42130698e-04 2.68023337e+17
1.44706556e-04 1.60116609e+17
1.47282415e-04 9.56533445e+16
1.49858273e-04 5.71431180e+16
1.52434132e-04 3.41371852e+16
1.55009990e-04 2.03934867e+16
end

;;
function7 ; Oxygen

type 0
data_pairs
-9.99999999e-05 5.40945333e+16
-9.74241414e-05 7.62624691e+16
-9.48482830e-05 1.07514823e+17
-9.22724245e-05 1.51574390e+17
-8.96965660e-05 2.13689564e+17
-8.71207075e-05 3.01259532e+17
-8.45448490e-05 4.24715666e+17
-8.19689905e-05 5.98764115e+17
-7.93931320e-05 8.44137605e+17
-7.68172735e-05 1.19006513e+18
-7.42414151e-05 1.67775374e+18
-7.16655566e-05 2.36529710e+18
-6.90896981e-05 3.33459567e+18
-6.65138396e-05 4.70111274e+18
-6.39379811e-05 6.62762839e+18
-6.13621226e-05 9.34363002e+18
-5.87862641e-05 1.31726489e+19
-5.62104056e-05 1.85707995e+19
-5.36345472e-05 2.61811117e+19
-5.10586887e-05 3.69101294e+19
-4.84828302e-05 5.20358977e+19
-4.59069717e-05 7.33602048e+19
-4.33311132e-05 1.03423211e+20
-4.07552547e-05 1.45806036e+20
-3.81793962e-05 2.05557339e+20
-3.56035377e-05 2.89794721e+20
-3.30276793e-05 4.08552576e+20
-3.04518208e-05 5.75977392e+20
-2.78759623e-05 8.12012885e+20
-2.53001038e-05 1.14477571e+21
-2.27242453e-05 1.61390471e+21
-2.01483868e-05 2.27528274e+21
-1.75725283e-05 3.20769344e+21
-1.49966698e-05 4.52220597e+21
-1.24208114e-05 6.37540565e+21
-9.84495286e-06 8.98804641e+21
-7.26909438e-06 1.26713472e+22
-4.69323589e-06 1.78640643e+22
-2.11737740e-06 2.51847566e+22
4.58481086e-07 3.34000000e+22
3.03433957e-06 3.34000000e+22
5.61019806e-06 3.34000000e+22
8.18605655e-06 3.34000000e+22
1.07619150e-05 3.34000000e+22
1.33377735e-05 3.34000000e+22
1.59136320e-05 3.34000000e+22
1.84894905e-05 3.34000000e+22
2.10653490e-05 3.34000000e+22
2.36412075e-05 3.34000000e+22
2.62170660e-05 3.34000000e+22
2.87929245e-05 3.34000000e+22
3.13687829e-05 3.34000000e+22
3.39446414e-05 3.34000000e+22
3.65204999e-05 3.34000000e+22
3.90963584e-05 3.34000000e+22
4.16722169e-05 3.34000000e+22
4.42480754e-05 3.34000000e+22
4.68239339e-05 3.34000000e+22
4.93997924e-05 3.34000000e+22
5.19756508e-05 3.34000000e+22
5.45515093e-05 3.34000000e+22
5.71273678e-05 3.34000000e+22
5.97032263e-05 3.34000000e+22
6.22790848e-05 3.34000000e+22
6.48549433e-05 3.34000000e+22
6.74308018e-05 3.34000000e+22
7.00066603e-05 3.34000000e+22
7.25825187e-05 3.34000000e+22
7.51583772e-05 3.34000000e+22
7.77342357e-05 3.34000000e+22
8.03100942e-05 3.13914970e+22
8.28859527e-05 1.87532179e+22
8.54618112e-05 1.12031352e+22
8.80376697e-05 6.69273069e+21
9.06135282e-05 3.99822403e+21
9.31893866e-05 2.38853109e+21
9.57652451e-05 1.42690373e+21
9.83411036e-05 8.52429455e+20
1.00916962e-04 5.09239664e+20
1.03492821e-04 3.04218764e+20
1.06068679e-04 1.81739685e+20
1.08644538e-04 1.08570927e+20
1.11220396e-04 6.48600562e+19
1.13796255e-04 3.87472688e+19
1.16372113e-04 2.31475414e+19
1.18947972e-04 1.38282953e+19
1.21523830e-04 8.26099613e+18
1.24099688e-04 4.93510268e+18
1.26675547e-04 2.94822054e+18
1.29251405e-04 1.76126110e+18
1.31827264e-04 1.05217388e+18
1.34403122e-04 6.28566587e+17
1.36978981e-04 3.75504431e+17
1.39554839e-04 2.24325601e+17
1.42130698e-04 1.34011669e+17
1.44706556e-04 8.00583047e+16
1.47282415e-04 4.78266723e+16
1.49858273e-04 2.85715590e+16
1.52434132e-04 1.70685926e+16
1.55009990e-04 1.01967433e+16
end

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
energy particle_energy
;
probe4
energy field_energy
;
probe5
performance cpu_time
