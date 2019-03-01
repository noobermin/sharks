;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "complex beam target interaction, I = 5.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.2500e-04
 time_step_ns 7.5000e-08

;;Restarts
dump_restart_flag ON
maximum_restart_dump_time 1000
rename_restart_flag ON
restart_interval 15

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

xmin             -1.060000e-03
xmax             7.000000e-04
x-cells          440
                                        ;

ymin             -6.600000e-04
ymax             6.600000e-04
y-cells          165


zmin             -6.600000e-04
zmax             6.600000e-04
z-cells          165

[Regions]
;

;total number of domains: 88

;
region1
xmin             -1.060000e-03
xmax             -1.800000e-04

ymin             -6.600000e-04
ymax             6.600000e-04

zmin             -6.600000e-04
zmax             6.600000e-04
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -1.800000e-04
xmax             7.000000e-04

ymin             -6.600000e-04
ymax             6.600000e-04

zmin             -6.600000e-04
zmax             6.600000e-04
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
from -1.060000e-03  -6.600000e-04 -6.600000e-04
to   -1.060000e-03  6.600000e-04 6.600000e-04
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
from 7.000000e-04  -6.600000e-04 -6.600000e-04
to   7.000000e-04  6.600000e-04 6.600000e-04
phase_velocity 1.0
drive_model NONE

;left
outlet
from -1.060000e-03  -6.600000e-04 -6.600000e-04
to   7.000000e-04  -6.600000e-04 6.600000e-04
phase_velocity 1.0
drive_model NONE

;right
outlet
from -1.060000e-03  6.600000e-04 -6.600000e-04
to   7.000000e-04  6.600000e-04 6.600000e-04
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -1.060000e-03  -6.600000e-04 -6.600000e-04
to   7.000000e-04  6.600000e-04 -6.600000e-04
phase_velocity 1.0
drive_model NONE

;top
outlet
from -1.060000e-03  -6.600000e-04 6.600000e-04
to   7.000000e-04  6.600000e-04 6.600000e-04
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
from -1.000000e-04 -6.600000e-04  -6.600000e-04
to   8.000000e-05 6.600000e-04  6.600000e-04
species 10
movie_tag 5
unbound off
discrete_numbers 2 2 2
density_function 5
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.050
;
plasma ; p+
from -1.000000e-04 -6.600000e-04  -6.600000e-04
to   8.000000e-05 6.600000e-04  6.600000e-04
species 11
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 6
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;
plasma ; O+
from -1.000000e-04  -6.600000e-04  -6.600000e-04
to   8.000000e-05  6.600000e-04  6.600000e-04
species 2
movie_tag 3
unbound off
discrete_numbers 2 2 2
density_function 7
reference_point 0.0 0.0 0.0
density_flags 1 1 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;

;; emission from conductors
emission child-langmuir field-stress
from -1.060000e-03 -6.600000e-04 -6.600000e-04
to   7.000000e-04 6.600000e-04 6.600000e-04
interval 1
species 10
discrete_numbers 2 2 2
inclusion SOLID
thermal_energy 1.0
movie_fraction 0.0
;; ionization states ;;
higherstate              ; H -> p+
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
from -1.060000e-03 -6.600000e-04  -6.600000e-04
to   7.000000e-04 6.600000e-04  6.600000e-04
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
;;at -1.060000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 7.000000e-04 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 6.600000e-04 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -6.600000e-04 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0010599999999348236 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0007 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.00066 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.00066 0
 
;
extract5
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.00066
 
;
extract6
species 10
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.00066


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function, sine squared
type 23   ; requires new modifications
coefficients 6.137836e+07 0.000000e+00 6.000000e-15 end

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~3.4207988824596125
          ; \lambda spotsize
coefficients 7.800000e-05 1.698644e-04 end

function3 ; laser polarization function
type 87
coefficients 0 1 0 end

function4 ; laser
type 86
laser
temporal_function 1
polarization_function 3
wavelength 7.800000e-05
spotsize 1.698644e-04
lp_mode 0 0
direction 1 0 0
focal_point 0.0 0.0 0.0
end

;;
function5 ; electrons

type 0
data_pairs
-9.99999999e-05 0.00000000e+00
-9.81818181e-05 2.06803624e+17
-9.63636363e-05 2.63537035e+17
-9.45454545e-05 3.35834389e+17
-9.27272727e-05 4.27965417e+17
-9.09090908e-05 5.45371184e+17
-8.90909090e-05 6.94985426e+17
-8.72727272e-05 8.85644048e+17
-8.54545454e-05 1.12860695e+18
-8.36363636e-05 1.43822300e+18
-8.18181818e-05 1.83277748e+18
-7.99999999e-05 2.33557195e+18
-7.81818181e-05 2.97630039e+18
-7.63636363e-05 3.79280289e+18
-7.45454545e-05 4.83330035e+18
-7.27272727e-05 6.15924237e+18
-7.09090909e-05 7.84893631e+18
-6.90909090e-05 1.00021719e+19
-6.72727272e-05 1.27461148e+19
-6.54545454e-05 1.62428165e+19
-6.36363636e-05 2.06987847e+19
-6.18181818e-05 2.63771797e+19
-5.99999999e-05 3.36133555e+19
-5.81818181e-05 4.28346655e+19
-5.63636363e-05 5.45857008e+19
-5.45454545e-05 6.95604530e+19
-5.27272727e-05 8.86432993e+19
-5.09090909e-05 1.12961233e+20
-4.90909090e-05 1.43950419e+20
-4.72727272e-05 1.83441015e+20
-4.54545454e-05 2.33765251e+20
-4.36363636e-05 2.97895173e+20
-4.18181818e-05 3.79618157e+20
-4.00000000e-05 4.83760592e+20
-3.81818181e-05 6.16472911e+20
-3.63636363e-05 7.85592826e+20
-3.45454545e-05 1.00110820e+21
-3.27272727e-05 1.27574692e+21
-3.09090909e-05 1.62572858e+21
-2.90909091e-05 2.07172235e+21
-2.72727272e-05 2.64006769e+21
-2.54545454e-05 3.36432988e+21
-2.36363636e-05 4.28728233e+21
-2.18181818e-05 5.46343266e+21
-2.00000000e-05 6.96224185e+21
-1.81818181e-05 8.87222641e+21
-1.63636363e-05 1.13061860e+22
-1.45454545e-05 1.44078652e+22
-1.27272727e-05 1.83604427e+22
-1.09090909e-05 2.33973493e+22
-9.09090906e-06 2.98160542e+22
-7.27272724e-06 3.79956327e+22
-5.45454542e-06 4.84191533e+22
-3.63636361e-06 6.17022075e+22
-1.81818179e-06 7.86292644e+22
2.89673342e-14 1.00200000e+23
1.81818185e-06 1.00200000e+23
3.63636366e-06 1.00200000e+23
5.45454548e-06 1.00200000e+23
7.27272730e-06 1.00200000e+23
9.09090912e-06 1.00200000e+23
1.09090909e-05 1.00200000e+23
1.27272728e-05 1.00200000e+23
1.45454546e-05 1.00200000e+23
1.63636364e-05 1.00200000e+23
1.81818182e-05 1.00200000e+23
2.00000000e-05 1.00200000e+23
2.18181818e-05 1.00200000e+23
2.36363637e-05 1.00200000e+23
2.54545455e-05 1.00200000e+23
2.72727273e-05 1.00200000e+23
2.90909091e-05 1.00200000e+23
3.09090909e-05 1.00200000e+23
3.27272727e-05 1.00200000e+23
3.45454546e-05 1.00200000e+23
3.63636364e-05 1.00200000e+23
3.81818182e-05 1.00200000e+23
4.00000000e-05 1.00200000e+23
4.18181818e-05 1.00200000e+23
4.36363636e-05 1.00200000e+23
4.54545455e-05 1.00200000e+23
4.72727273e-05 1.00200000e+23
4.90909091e-05 1.00200000e+23
5.09090909e-05 1.00200000e+23
5.27272727e-05 1.00200000e+23
5.45454546e-05 1.00200000e+23
5.63636364e-05 1.00200000e+23
5.81818182e-05 1.00200000e+23
6.00000000e-05 1.00200000e+23
6.18181818e-05 1.00200000e+23
6.36363636e-05 1.00200000e+23
6.54545455e-05 1.00200000e+23
6.72727273e-05 1.00200000e+23
6.90909091e-05 1.00200000e+23
7.09090909e-05 1.00200000e+23
7.27272727e-05 1.00200000e+23
7.45454545e-05 1.00200000e+23
7.63636364e-05 1.00200000e+23
7.81818182e-05 1.00200000e+23
8.00000000e-05 0.00000000e+00

end

;;
function6 ; Protons

type 0
data_pairs
-9.99999999e-05 0.00000000e+00
-9.81818181e-05 1.37869082e+17
-9.63636363e-05 1.75691356e+17
-9.45454545e-05 2.23889593e+17
-9.27272727e-05 2.85310278e+17
-9.09090908e-05 3.63580789e+17
-8.90909090e-05 4.63323618e+17
-8.72727272e-05 5.90429365e+17
-8.54545454e-05 7.52404631e+17
-8.36363636e-05 9.58815334e+17
-8.18181818e-05 1.22185166e+18
-7.99999999e-05 1.55704797e+18
-7.81818181e-05 1.98420026e+18
-7.63636363e-05 2.52853526e+18
-7.45454545e-05 3.22220023e+18
-7.27272727e-05 4.10616158e+18
-7.09090909e-05 5.23262420e+18
-6.90909090e-05 6.66811462e+18
-6.72727272e-05 8.49740988e+18
-6.54545454e-05 1.08285443e+19
-6.36363636e-05 1.37991898e+19
-6.18181818e-05 1.75847865e+19
-5.99999999e-05 2.24089037e+19
-5.81818181e-05 2.85564437e+19
-5.63636363e-05 3.63904672e+19
-5.45454545e-05 4.63736353e+19
-5.27272727e-05 5.90955329e+19
-5.09090909e-05 7.53074884e+19
-4.90909090e-05 9.59669461e+19
-4.72727272e-05 1.22294010e+20
-4.54545454e-05 1.55843501e+20
-4.36363636e-05 1.98596782e+20
-4.18181818e-05 2.53078771e+20
-4.00000000e-05 3.22507061e+20
-3.81818181e-05 4.10981941e+20
-3.63636363e-05 5.23728550e+20
-3.45454545e-05 6.67405468e+20
-3.27272727e-05 8.50497950e+20
-3.09090909e-05 1.08381905e+21
-2.90909091e-05 1.38114823e+21
-2.72727272e-05 1.76004513e+21
-2.54545454e-05 2.24288659e+21
-2.36363636e-05 2.85818822e+21
-2.18181818e-05 3.64228844e+21
-2.00000000e-05 4.64149456e+21
-1.81818181e-05 5.91481761e+21
-1.63636363e-05 7.53745735e+21
-1.45454545e-05 9.60524348e+21
-1.27272727e-05 1.22402951e+22
-1.09090909e-05 1.55982329e+22
-9.09090906e-06 1.98773695e+22
-7.27272724e-06 2.53304218e+22
-5.45454542e-06 3.22794356e+22
-3.63636361e-06 4.11348050e+22
-1.81818179e-06 5.24195096e+22
2.89673342e-14 6.68000000e+22
1.81818185e-06 6.68000000e+22
3.63636366e-06 6.68000000e+22
5.45454548e-06 6.68000000e+22
7.27272730e-06 6.68000000e+22
9.09090912e-06 6.68000000e+22
1.09090909e-05 6.68000000e+22
1.27272728e-05 6.68000000e+22
1.45454546e-05 6.68000000e+22
1.63636364e-05 6.68000000e+22
1.81818182e-05 6.68000000e+22
2.00000000e-05 6.68000000e+22
2.18181818e-05 6.68000000e+22
2.36363637e-05 6.68000000e+22
2.54545455e-05 6.68000000e+22
2.72727273e-05 6.68000000e+22
2.90909091e-05 6.68000000e+22
3.09090909e-05 6.68000000e+22
3.27272727e-05 6.68000000e+22
3.45454546e-05 6.68000000e+22
3.63636364e-05 6.68000000e+22
3.81818182e-05 6.68000000e+22
4.00000000e-05 6.68000000e+22
4.18181818e-05 6.68000000e+22
4.36363636e-05 6.68000000e+22
4.54545455e-05 6.68000000e+22
4.72727273e-05 6.68000000e+22
4.90909091e-05 6.68000000e+22
5.09090909e-05 6.68000000e+22
5.27272727e-05 6.68000000e+22
5.45454546e-05 6.68000000e+22
5.63636364e-05 6.68000000e+22
5.81818182e-05 6.68000000e+22
6.00000000e-05 6.68000000e+22
6.18181818e-05 6.68000000e+22
6.36363636e-05 6.68000000e+22
6.54545455e-05 6.68000000e+22
6.72727273e-05 6.68000000e+22
6.90909091e-05 6.68000000e+22
7.09090909e-05 6.68000000e+22
7.27272727e-05 6.68000000e+22
7.45454545e-05 6.68000000e+22
7.63636364e-05 6.68000000e+22
7.81818182e-05 6.68000000e+22
8.00000000e-05 0.00000000e+00

end

;;
function7 ; Oxygen

type 0
data_pairs
-9.99999999e-05 0.00000000e+00
-9.81818181e-05 6.89345412e+16
-9.63636363e-05 8.78456782e+16
-9.45454545e-05 1.11944796e+17
-9.27272727e-05 1.42655139e+17
-9.09090908e-05 1.81790395e+17
-8.90909090e-05 2.31661809e+17
-8.72727272e-05 2.95214683e+17
-8.54545454e-05 3.76202316e+17
-8.36363636e-05 4.79407667e+17
-8.18181818e-05 6.10925828e+17
-7.99999999e-05 7.78523984e+17
-7.81818181e-05 9.92100132e+17
-7.63636363e-05 1.26426763e+18
-7.45454545e-05 1.61110012e+18
-7.27272727e-05 2.05308079e+18
-7.09090909e-05 2.61631210e+18
-6.90909090e-05 3.33405731e+18
-6.72727272e-05 4.24870494e+18
-6.54545454e-05 5.41427216e+18
-6.36363636e-05 6.89959491e+18
-6.18181818e-05 8.79239324e+18
-5.99999999e-05 1.12044518e+19
-5.81818181e-05 1.42782218e+19
-5.63636363e-05 1.81952336e+19
-5.45454545e-05 2.31868177e+19
-5.27272727e-05 2.95477664e+19
-5.09090909e-05 3.76537442e+19
-4.90909090e-05 4.79834730e+19
-4.72727272e-05 6.11470049e+19
-4.54545454e-05 7.79217505e+19
-4.36363636e-05 9.92983909e+19
-4.18181818e-05 1.26539386e+20
-4.00000000e-05 1.61253531e+20
-3.81818181e-05 2.05490970e+20
-3.63636363e-05 2.61864275e+20
-3.45454545e-05 3.33702734e+20
-3.27272727e-05 4.25248975e+20
-3.09090909e-05 5.41909527e+20
-2.90909091e-05 6.90574117e+20
-2.72727272e-05 8.80022564e+20
-2.54545454e-05 1.12144329e+21
-2.36363636e-05 1.42909411e+21
-2.18181818e-05 1.82114422e+21
-2.00000000e-05 2.32074728e+21
-1.81818181e-05 2.95740880e+21
-1.63636363e-05 3.76872867e+21
-1.45454545e-05 4.80262174e+21
-1.27272727e-05 6.12014756e+21
-1.09090909e-05 7.79911644e+21
-9.09090906e-06 9.93868474e+21
-7.27272724e-06 1.26652109e+22
-5.45454542e-06 1.61397178e+22
-3.63636361e-06 2.05674025e+22
-1.81818179e-06 2.62097548e+22
2.89673342e-14 3.34000000e+22
1.81818185e-06 3.34000000e+22
3.63636366e-06 3.34000000e+22
5.45454548e-06 3.34000000e+22
7.27272730e-06 3.34000000e+22
9.09090912e-06 3.34000000e+22
1.09090909e-05 3.34000000e+22
1.27272728e-05 3.34000000e+22
1.45454546e-05 3.34000000e+22
1.63636364e-05 3.34000000e+22
1.81818182e-05 3.34000000e+22
2.00000000e-05 3.34000000e+22
2.18181818e-05 3.34000000e+22
2.36363637e-05 3.34000000e+22
2.54545455e-05 3.34000000e+22
2.72727273e-05 3.34000000e+22
2.90909091e-05 3.34000000e+22
3.09090909e-05 3.34000000e+22
3.27272727e-05 3.34000000e+22
3.45454546e-05 3.34000000e+22
3.63636364e-05 3.34000000e+22
3.81818182e-05 3.34000000e+22
4.00000000e-05 3.34000000e+22
4.18181818e-05 3.34000000e+22
4.36363636e-05 3.34000000e+22
4.54545455e-05 3.34000000e+22
4.72727273e-05 3.34000000e+22
4.90909091e-05 3.34000000e+22
5.09090909e-05 3.34000000e+22
5.27272727e-05 3.34000000e+22
5.45454546e-05 3.34000000e+22
5.63636364e-05 3.34000000e+22
5.81818182e-05 3.34000000e+22
6.00000000e-05 3.34000000e+22
6.18181818e-05 3.34000000e+22
6.36363636e-05 3.34000000e+22
6.54545455e-05 3.34000000e+22
6.72727273e-05 3.34000000e+22
6.90909091e-05 3.34000000e+22
7.09090909e-05 3.34000000e+22
7.27272727e-05 3.34000000e+22
7.45454545e-05 3.34000000e+22
7.63636364e-05 3.34000000e+22
7.81818182e-05 3.34000000e+22
8.00000000e-05 0.00000000e+00

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
performance cpu_time
