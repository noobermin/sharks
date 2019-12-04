;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "lsp reference, I = 5.000000e+18 W/cm^2"
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
probe_interval 1
spatial_skip_x 1
spatial_skip_y 1
spatial_skip_z 1


;;pmovies

;
[Grid]
;
grid1

xmin             -1.400000e-03
xmax             8.000000e-04
x-cells          440
                                        ;

ymin             -1.100000e-03
ymax             1.100000e-03
y-cells          440



[Regions]
;

;total number of domains: 88

;
region1
xmin             -1.400000e-03
xmax             8.000000e-04

ymin             -1.100000e-03
ymax             1.100000e-03

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 88
split_direction YSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]


[Boundaries]

;laser
outlet
from -1.400000e-03  -1.100000e-03 0.000000e+00
to   -1.400000e-03  1.100000e-03 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 4
analytic_function 6
time_delay 0.0

;back
outlet
from 8.000000e-04  -1.100000e-03 0.000000e+00
to   8.000000e-04  1.100000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;left
outlet
from -1.400000e-03  -1.100000e-03 0.000000e+00
to   8.000000e-04  -1.100000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;right
outlet
from -1.400000e-03  1.100000e-03 0.000000e+00
to   8.000000e-04  1.100000e-03 0.000000e+00
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
from -1.200000e-03 -9.000000e-04  0.000000e+00
to   3.000000e-04 9.000000e-04  0.000000e+00
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
from -1.200000e-03 -9.000000e-04  0.000000e+00
to   3.000000e-04 9.000000e-04  0.000000e+00
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
from -1.200000e-03  -9.000000e-04  0.000000e+00
to   3.000000e-04  9.000000e-04  0.000000e+00
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
from -1.400000e-03 -1.100000e-03 0.000000e+00
to   8.000000e-04 1.100000e-03 0.000000e+00
interval 1
species 10
discrete_numbers 2 2 2
inclusion SOLID
thermal_energy 1.0
movie_fraction 0.0
;; ionization states ;;
higherstate              ; H -> p+
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
from -1.400000e-03 -1.100000e-03  0.000000e+00
to   8.000000e-04 1.100000e-03  0.000000e+00
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
;;at -1.400000e-03 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 8.000000e-04 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 1.100000e-03 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 -1.100000e-03 0
;

;
extract1
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0014 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0008 0 0
 
;
extract3
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0011 0
 
;
extract4
species 10
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0011 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
;;
function1 ; electrons

type 0
data_pairs
-1.20000000e-03 1.00000000e+16
-1.18484848e-03 1.00000000e+16
-1.16969697e-03 1.00000000e+16
-1.15454545e-03 1.07349729e+16
-1.13939394e-03 1.28569187e+16
-1.12424242e-03 1.53983024e+16
-1.10909091e-03 1.84420327e+16
-1.09393939e-03 2.20874070e+16
-1.07878788e-03 2.64533501e+16
-1.06363636e-03 3.16822944e+16
-1.04848485e-03 3.79448264e+16
-1.03333333e-03 4.54452520e+16
-1.01818182e-03 5.44282614e+16
-1.00303030e-03 6.51869118e+16
-9.87878788e-04 7.80721884e+16
-9.72727273e-04 9.35044539e+16
-9.57575758e-04 1.11987163e+17
-9.42424242e-04 1.34123287e+17
-9.27272727e-04 1.60634984e+17
-9.12121212e-04 1.92387159e+17
-8.96969697e-04 2.30415678e+17
-8.81818182e-04 2.75961166e+17
-8.66666667e-04 3.30509477e+17
-8.51515152e-04 3.95840168e+17
-8.36363636e-04 4.74084556e+17
-8.21212121e-04 5.67795248e+17
-8.06060606e-04 6.80029415e+17
-7.90909091e-04 8.14448531e+17
-7.75757576e-04 9.75437819e+17
-7.60606061e-04 1.16824932e+18
-7.45454545e-04 1.39917321e+18
-7.30303030e-04 1.67574305e+18
-7.15151515e-04 2.00698151e+18
-7.00000000e-04 2.40369476e+18
-6.84848485e-04 2.87882498e+18
-6.69696970e-04 3.44787259e+18
-6.54545455e-04 4.12940191e+18
-6.39393939e-04 4.94564682e+18
-6.24242424e-04 5.92323611e+18
-6.09090909e-04 7.09406218e+18
-5.93939394e-04 8.49632147e+18
-5.78787879e-04 1.01757606e+19
-5.63636364e-04 1.21871688e+19
-5.48484848e-04 1.45961653e+19
-5.33333333e-04 1.74813399e+19
-5.18181818e-04 2.09368173e+19
-5.03030303e-04 2.50753272e+19
-4.87878788e-04 3.00318824e+19
-4.72727273e-04 3.59681831e+19
-4.57575758e-04 4.30778922e+19
-4.42424242e-04 5.15929536e+19
-4.27272727e-04 6.17911583e+19
-4.12121212e-04 7.40052078e+19
-3.96969697e-04 8.86335670e+19
-3.81818182e-04 1.06153465e+20
-3.66666667e-04 1.27136461e+20
-3.51515152e-04 1.52267096e+20
-3.36363636e-04 1.82365218e+20
-3.21212121e-04 2.18412734e+20
-3.06060606e-04 2.61585641e+20
-2.90909091e-04 3.13292390e+20
-2.75757576e-04 3.75219838e+20
-2.60606061e-04 4.49388275e+20
-2.45454545e-04 5.38217337e+20
-2.30303030e-04 6.44604938e+20
-2.15151515e-04 7.72021818e+20
-2.00000000e-04 9.24624761e+20
-1.84848485e-04 1.10739221e+21
-1.69696970e-04 1.32628669e+21
-1.54545455e-04 1.58844929e+21
-1.39393939e-04 1.90243270e+21
-1.24242424e-04 2.27848014e+21
-1.09090909e-04 2.72885960e+21
-9.39393939e-05 3.26826406e+21
-7.87878788e-05 3.91429077e+21
-6.36363636e-05 4.68801539e+21
-4.84848485e-05 5.61467955e+21
-3.33333333e-05 6.72451428e+21
-1.81818182e-05 8.05372628e+21
-3.03030303e-06 9.64567913e+21
1.21212121e-05 1.00000000e+22
2.72727273e-05 1.00000000e+22
4.24242424e-05 1.00000000e+22
5.75757576e-05 1.00000000e+22
7.27272727e-05 1.00000000e+22
8.78787879e-05 1.00000000e+22
1.03030303e-04 7.38576715e+21
1.18181818e-04 1.62320611e+21
1.33333333e-04 3.56739933e+20
1.48484848e-04 7.84024772e+19
1.63636364e-04 1.72308953e+19
1.78787879e-04 3.78691799e+18
1.93939394e-04 8.32269459e+17
2.09090909e-04 1.82911923e+17
2.24242424e-04 4.01994465e+16
2.39393939e-04 1.00000000e+16
2.54545455e-04 1.00000000e+16
2.69696970e-04 1.00000000e+16
2.84848485e-04 1.00000000e+16
3.00000000e-04 1.00000000e+16

end

;;
function2 ; Protons

type 0
data_pairs
-1.20000000e-03 1.00000000e+16
-1.18484848e-03 1.00000000e+16
-1.16969697e-03 1.00000000e+16
-1.15454545e-03 1.07349729e+16
-1.13939394e-03 1.28569187e+16
-1.12424242e-03 1.53983024e+16
-1.10909091e-03 1.84420327e+16
-1.09393939e-03 2.20874070e+16
-1.07878788e-03 2.64533501e+16
-1.06363636e-03 3.16822944e+16
-1.04848485e-03 3.79448264e+16
-1.03333333e-03 4.54452520e+16
-1.01818182e-03 5.44282614e+16
-1.00303030e-03 6.51869118e+16
-9.87878788e-04 7.80721884e+16
-9.72727273e-04 9.35044539e+16
-9.57575758e-04 1.11987163e+17
-9.42424242e-04 1.34123287e+17
-9.27272727e-04 1.60634984e+17
-9.12121212e-04 1.92387159e+17
-8.96969697e-04 2.30415678e+17
-8.81818182e-04 2.75961166e+17
-8.66666667e-04 3.30509477e+17
-8.51515152e-04 3.95840168e+17
-8.36363636e-04 4.74084556e+17
-8.21212121e-04 5.67795248e+17
-8.06060606e-04 6.80029415e+17
-7.90909091e-04 8.14448531e+17
-7.75757576e-04 9.75437819e+17
-7.60606061e-04 1.16824932e+18
-7.45454545e-04 1.39917321e+18
-7.30303030e-04 1.67574305e+18
-7.15151515e-04 2.00698151e+18
-7.00000000e-04 2.40369476e+18
-6.84848485e-04 2.87882498e+18
-6.69696970e-04 3.44787259e+18
-6.54545455e-04 4.12940191e+18
-6.39393939e-04 4.94564682e+18
-6.24242424e-04 5.92323611e+18
-6.09090909e-04 7.09406218e+18
-5.93939394e-04 8.49632147e+18
-5.78787879e-04 1.01757606e+19
-5.63636364e-04 1.21871688e+19
-5.48484848e-04 1.45961653e+19
-5.33333333e-04 1.74813399e+19
-5.18181818e-04 2.09368173e+19
-5.03030303e-04 2.50753272e+19
-4.87878788e-04 3.00318824e+19
-4.72727273e-04 3.59681831e+19
-4.57575758e-04 4.30778922e+19
-4.42424242e-04 5.15929536e+19
-4.27272727e-04 6.17911583e+19
-4.12121212e-04 7.40052078e+19
-3.96969697e-04 8.86335670e+19
-3.81818182e-04 1.06153465e+20
-3.66666667e-04 1.27136461e+20
-3.51515152e-04 1.52267096e+20
-3.36363636e-04 1.82365218e+20
-3.21212121e-04 2.18412734e+20
-3.06060606e-04 2.61585641e+20
-2.90909091e-04 3.13292390e+20
-2.75757576e-04 3.75219838e+20
-2.60606061e-04 4.49388275e+20
-2.45454545e-04 5.38217337e+20
-2.30303030e-04 6.44604938e+20
-2.15151515e-04 7.72021818e+20
-2.00000000e-04 9.24624761e+20
-1.84848485e-04 1.10739221e+21
-1.69696970e-04 1.32628669e+21
-1.54545455e-04 1.58844929e+21
-1.39393939e-04 1.90243270e+21
-1.24242424e-04 2.27848014e+21
-1.09090909e-04 2.72885960e+21
-9.39393939e-05 3.26826406e+21
-7.87878788e-05 3.91429077e+21
-6.36363636e-05 4.68801539e+21
-4.84848485e-05 5.61467955e+21
-3.33333333e-05 6.72451428e+21
-1.81818182e-05 8.05372628e+21
-3.03030303e-06 9.64567913e+21
1.21212121e-05 1.00000000e+22
2.72727273e-05 1.00000000e+22
4.24242424e-05 1.00000000e+22
5.75757576e-05 1.00000000e+22
7.27272727e-05 1.00000000e+22
8.78787879e-05 1.00000000e+22
1.03030303e-04 7.38576715e+21
1.18181818e-04 1.62320611e+21
1.33333333e-04 3.56739933e+20
1.48484848e-04 7.84024772e+19
1.63636364e-04 1.72308953e+19
1.78787879e-04 3.78691799e+18
1.93939394e-04 8.32269459e+17
2.09090909e-04 1.82911923e+17
2.24242424e-04 4.01994465e+16
2.39393939e-04 1.00000000e+16
2.54545455e-04 1.00000000e+16
2.69696970e-04 1.00000000e+16
2.84848485e-04 1.00000000e+16
3.00000000e-04 1.00000000e+16

end

;;
function3 ; Oxygen

type 0
data_pairs
-1.20000000e-03 0.00000000e+00
-1.18484848e-03 0.00000000e+00
-1.16969697e-03 0.00000000e+00
-1.15454545e-03 0.00000000e+00
-1.13939394e-03 0.00000000e+00
-1.12424242e-03 0.00000000e+00
-1.10909091e-03 0.00000000e+00
-1.09393939e-03 0.00000000e+00
-1.07878788e-03 0.00000000e+00
-1.06363636e-03 0.00000000e+00
-1.04848485e-03 0.00000000e+00
-1.03333333e-03 0.00000000e+00
-1.01818182e-03 0.00000000e+00
-1.00303030e-03 0.00000000e+00
-9.87878788e-04 0.00000000e+00
-9.72727273e-04 0.00000000e+00
-9.57575758e-04 0.00000000e+00
-9.42424242e-04 0.00000000e+00
-9.27272727e-04 0.00000000e+00
-9.12121212e-04 0.00000000e+00
-8.96969697e-04 0.00000000e+00
-8.81818182e-04 0.00000000e+00
-8.66666667e-04 0.00000000e+00
-8.51515152e-04 0.00000000e+00
-8.36363636e-04 0.00000000e+00
-8.21212121e-04 0.00000000e+00
-8.06060606e-04 0.00000000e+00
-7.90909091e-04 0.00000000e+00
-7.75757576e-04 0.00000000e+00
-7.60606061e-04 0.00000000e+00
-7.45454545e-04 0.00000000e+00
-7.30303030e-04 0.00000000e+00
-7.15151515e-04 0.00000000e+00
-7.00000000e-04 0.00000000e+00
-6.84848485e-04 0.00000000e+00
-6.69696970e-04 0.00000000e+00
-6.54545455e-04 0.00000000e+00
-6.39393939e-04 0.00000000e+00
-6.24242424e-04 0.00000000e+00
-6.09090909e-04 0.00000000e+00
-5.93939394e-04 0.00000000e+00
-5.78787879e-04 0.00000000e+00
-5.63636364e-04 0.00000000e+00
-5.48484848e-04 0.00000000e+00
-5.33333333e-04 0.00000000e+00
-5.18181818e-04 0.00000000e+00
-5.03030303e-04 0.00000000e+00
-4.87878788e-04 0.00000000e+00
-4.72727273e-04 0.00000000e+00
-4.57575758e-04 0.00000000e+00
-4.42424242e-04 0.00000000e+00
-4.27272727e-04 0.00000000e+00
-4.12121212e-04 0.00000000e+00
-3.96969697e-04 0.00000000e+00
-3.81818182e-04 0.00000000e+00
-3.66666667e-04 0.00000000e+00
-3.51515152e-04 0.00000000e+00
-3.36363636e-04 0.00000000e+00
-3.21212121e-04 0.00000000e+00
-3.06060606e-04 0.00000000e+00
-2.90909091e-04 0.00000000e+00
-2.75757576e-04 0.00000000e+00
-2.60606061e-04 0.00000000e+00
-2.45454545e-04 0.00000000e+00
-2.30303030e-04 0.00000000e+00
-2.15151515e-04 0.00000000e+00
-2.00000000e-04 0.00000000e+00
-1.84848485e-04 0.00000000e+00
-1.69696970e-04 0.00000000e+00
-1.54545455e-04 0.00000000e+00
-1.39393939e-04 0.00000000e+00
-1.24242424e-04 0.00000000e+00
-1.09090909e-04 0.00000000e+00
-9.39393939e-05 0.00000000e+00
-7.87878788e-05 0.00000000e+00
-6.36363636e-05 0.00000000e+00
-4.84848485e-05 0.00000000e+00
-3.33333333e-05 0.00000000e+00
-1.81818182e-05 0.00000000e+00
-3.03030303e-06 0.00000000e+00
1.21212121e-05 0.00000000e+00
2.72727273e-05 0.00000000e+00
4.24242424e-05 0.00000000e+00
5.75757576e-05 0.00000000e+00
7.27272727e-05 0.00000000e+00
8.78787879e-05 0.00000000e+00
1.03030303e-04 0.00000000e+00
1.18181818e-04 0.00000000e+00
1.33333333e-04 0.00000000e+00
1.48484848e-04 0.00000000e+00
1.63636364e-04 0.00000000e+00
1.78787879e-04 0.00000000e+00
1.93939394e-04 0.00000000e+00
2.09090909e-04 0.00000000e+00
2.24242424e-04 0.00000000e+00
2.39393939e-04 0.00000000e+00
2.54545455e-04 0.00000000e+00
2.69696970e-04 0.00000000e+00
2.84848485e-04 0.00000000e+00
3.00000000e-04 0.00000000e+00

end

;;

function4 ; laser temporal function, sine squared
type 16   ; requires new modifications
coefficients 6.137836e+07 2.972626e-05 1.000000e-04 4.669897e-05 end

function5 ; laser polarization function
type 87
coefficients 0 1 0 end

function6 ; laser
type 86
laser
temporal_function 4
polarization_function 5
wavelength 8.000000e-05
spotsize 1.527800e-04
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

