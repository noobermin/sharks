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

xmin             -2.000000e-03
xmax             1.300010e-03
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

;total number of domains: 264

;
region1
xmin             -2.000000e-03
xmax             -3.499950e-04

ymin             -1.320000e-03
ymax             -4.400000e-04

zmin             -1.320000e-03
zmax             1.320000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -2.000000e-03
xmax             -3.499950e-04

ymin             -4.400000e-04
ymax             4.400000e-04

zmin             -1.320000e-03
zmax             1.320000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -2.000000e-03
xmax             -3.499950e-04

ymin             4.400000e-04
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             1.320000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -3.499950e-04
xmax             1.300010e-03

ymin             -1.320000e-03
ymax             -4.400000e-04

zmin             -1.320000e-03
zmax             1.320000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -3.499950e-04
xmax             1.300010e-03

ymin             -4.400000e-04
ymax             4.400000e-04

zmin             -1.320000e-03
zmax             1.320000e-03
;
number_of_domains 44
split_direction ZSPLIT
number_of_cells AUTO; 
;
;
region6
xmin             -3.499950e-04
xmax             1.300010e-03

ymin             4.400000e-04
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             1.320000e-03
;
number_of_domains 44
split_direction ZSPLIT
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
analytic_function 4
time_delay 0.0

;back
outlet
from 1.300010e-03  -1.320000e-03 -1.320000e-03
to   1.300010e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;left
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   1.300010e-03  -1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -2.000000e-03  1.320000e-03 -1.320000e-03
to   1.300010e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   1.300010e-03  1.320000e-03 -1.320000e-03
phase_velocity 1.0
drive_model NONE

;top
outlet
from -2.000000e-03  -1.320000e-03 1.320000e-03
to   1.300010e-03  1.320000e-03 1.320000e-03
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
to   1.750100e-04 5.000000e-04  5.000000e-04
species 10
movie_tag 5
unbound off
discrete_numbers 2 3 2
density_function 5
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.050
;
plasma ; p+
from -1.000000e-04 -5.000000e-04  -5.000000e-04
to   1.750100e-04 5.000000e-04  5.000000e-04
species 11
movie_tag 3
unbound off
discrete_numbers 2 3 2
density_function 6
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;
plasma ; O+
from -1.000000e-04  -5.000000e-04  -5.000000e-04
to   1.750100e-04  5.000000e-04  5.000000e-04
species 2
movie_tag 3
unbound off
discrete_numbers 2 3 2
density_function 7
reference_point 0.0 0.0 0.0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1.0

movie_fraction 0.000
;

;; emission from conductors
emission child-langmuir field-stress
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to   1.300010e-03 1.320000e-03 1.320000e-03
interval 1
species 10
discrete_numbers 2 3 2
inclusion SOLID
thermal_energy 1.0
movie_fraction 0.0
;; ionization states ;;
higherstate              ; H -> p+
from -2.000000e-03 -1.320000e-03  -1.320000e-03
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
to   1.300010e-03 1.320000e-03  1.320000e-03
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
;;at 1.300010e-03 0 0
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
at -0.0019999999999348234 0 0
 
;
extract2
species 10
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0013000099903484174 0 0
 
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
function1 ; laser temporal function, sine squared
type 23   ; requires new modifications
coefficients 6.137836e+07 6.600000e-05 6.000000e-05 end

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~1.5707963267948963
          ; \lambda spotsize
coefficients 7.800000e-05 7.800000e-05 end

function3 ; laser polarization function
type 88 ;87
coefficients 1 0 0 1 0 end

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
-9.72221212e-05 2.35033780e+17
-9.44442426e-05 3.40397166e+17
-9.16663639e-05 4.92993948e+17
-8.88884852e-05 7.13998401e+17
-8.61106065e-05 1.03407703e+18
-8.33327278e-05 1.49764383e+18
-8.05548491e-05 2.16902318e+18
-7.77769704e-05 3.14137545e+18
-7.49990917e-05 4.54962390e+18
-7.22212130e-05 6.58917661e+18
-6.94433343e-05 9.54304122e+18
-6.66654557e-05 1.38210950e+19
-6.38875770e-05 2.00169592e+19
-6.11096983e-05 2.89903697e+19
-5.83318196e-05 4.19864742e+19
-5.55539409e-05 6.08086074e+19
-5.27760622e-05 8.80685222e+19
-4.99981835e-05 1.27548795e+20
-4.72203048e-05 1.84727695e+20
-4.44424261e-05 2.67539347e+20
-4.16645475e-05 3.87474668e+20
-3.88866688e-05 5.61175842e+20
-3.61087901e-05 8.12745583e+20
-3.33309114e-05 1.17709162e+21
-3.05530327e-05 1.70477050e+21
-2.77751540e-05 2.46900274e+21
-2.49972753e-05 3.57583297e+21
-2.22193966e-05 5.17884455e+21
-1.94415179e-05 7.50047084e+21
-1.66636392e-05 1.08628599e+22
-1.38857606e-05 1.57325757e+22
-1.11078819e-05 2.27853383e+22
-8.33000317e-06 3.29997867e+22
-5.55212448e-06 4.77932743e+22
-2.77424579e-06 6.92185402e+22
3.63289545e-09 1.00200000e+23
2.78151159e-06 1.00200000e+23
5.55939027e-06 1.00200000e+23
8.33726896e-06 1.00200000e+23
1.11151477e-05 1.00200000e+23
1.38930263e-05 1.00200000e+23
1.66709050e-05 1.00200000e+23
1.94487837e-05 1.00200000e+23
2.22266624e-05 1.00200000e+23
2.50045411e-05 1.00200000e+23
2.77824198e-05 1.00200000e+23
3.05602985e-05 1.00200000e+23
3.33381772e-05 1.00200000e+23
3.61160559e-05 1.00200000e+23
3.88939346e-05 1.00200000e+23
4.16718132e-05 1.00200000e+23
4.44496919e-05 1.00200000e+23
4.72275706e-05 1.00200000e+23
5.00054493e-05 1.00200000e+23
5.27833280e-05 1.00200000e+23
5.55612067e-05 1.00200000e+23
5.83390854e-05 1.00200000e+23
6.11169641e-05 1.00200000e+23
6.38948428e-05 1.00200000e+23
6.66727214e-05 1.00200000e+23
6.94506001e-05 1.00200000e+23
7.22284788e-05 1.00200000e+23
7.50063575e-05 1.00200000e+23
7.77842362e-05 1.00200000e+23
8.05621149e-05 1.00200000e+23
8.33399936e-05 1.00200000e+23
8.61178723e-05 1.00200000e+23
8.88957510e-05 1.00200000e+23
9.16736297e-05 1.00200000e+23
9.44515083e-05 1.00200000e+23
9.72293870e-05 1.00200000e+23
1.00007266e-04 1.00054501e+23
1.02785144e-04 5.74054534e+22
1.05563023e-04 3.29359105e+22
1.08340902e-04 1.88967099e+22
1.11118780e-04 1.08418332e+22
1.13896659e-04 6.22041331e+21
1.16674538e-04 3.56891139e+21
1.19452417e-04 2.04763379e+21
1.22230295e-04 1.17481318e+21
1.25008174e-04 6.74039477e+20
1.27786053e-04 3.86724651e+20
1.30563931e-04 2.21880113e+20
1.33341810e-04 1.27301905e+20
1.36119689e-04 7.30384291e+19
1.38897567e-04 4.19052028e+19
1.41675446e-04 2.40427682e+19
1.44453325e-04 1.37943421e+19
1.47231203e-04 7.91439123e+18
1.50009082e-04 4.54081740e+18
1.52786961e-04 2.60525693e+18
1.55564840e-04 1.49474491e+18
1.58342718e-04 8.57597697e+17
1.61120597e-04 4.92039681e+17
1.63898476e-04 2.82303753e+17
1.66676354e-04 1.61969475e+17
1.69454233e-04 9.29286647e+16
1.72232112e-04 5.33170632e+16
1.75009990e-04 3.05902300e+16
end

;;
function6 ; Protons

type 0
data_pairs
-9.99999999e-05 1.08189067e+17
-9.72221212e-05 1.56689186e+17
-9.44442426e-05 2.26931444e+17
-9.16663639e-05 3.28662632e+17
-8.88884852e-05 4.75998934e+17
-8.61106065e-05 6.89384686e+17
-8.33327278e-05 9.98429222e+17
-8.05548491e-05 1.44601546e+18
-7.77769704e-05 2.09425030e+18
-7.49990917e-05 3.03308260e+18
-7.22212130e-05 4.39278441e+18
-6.94433343e-05 6.36202748e+18
-6.66654557e-05 9.21406332e+18
-6.38875770e-05 1.33446394e+19
-6.11096983e-05 1.93269132e+19
-5.83318196e-05 2.79909828e+19
-5.55539409e-05 4.05390716e+19
-5.27760622e-05 5.87123481e+19
-4.99981835e-05 8.50325301e+19
-4.72203048e-05 1.23151797e+20
-4.44424261e-05 1.78359565e+20
-4.16645475e-05 2.58316445e+20
-3.88866688e-05 3.74117228e+20
-3.61087901e-05 5.41830389e+20
-3.33309114e-05 7.84727750e+20
-3.05530327e-05 1.13651367e+21
-2.77751540e-05 1.64600183e+21
-2.49972753e-05 2.38388865e+21
-2.22193966e-05 3.45256304e+21
-1.94415179e-05 5.00031390e+21
-1.66636392e-05 7.24190660e+21
-1.38857606e-05 1.04883838e+22
-1.11078819e-05 1.51902256e+22
-8.33000317e-06 2.19998578e+22
-5.55212448e-06 3.18621829e+22
-2.77424579e-06 4.61456935e+22
3.63289545e-09 6.68000000e+22
2.78151159e-06 6.68000000e+22
5.55939027e-06 6.68000000e+22
8.33726896e-06 6.68000000e+22
1.11151477e-05 6.68000000e+22
1.38930263e-05 6.68000000e+22
1.66709050e-05 6.68000000e+22
1.94487837e-05 6.68000000e+22
2.22266624e-05 6.68000000e+22
2.50045411e-05 6.68000000e+22
2.77824198e-05 6.68000000e+22
3.05602985e-05 6.68000000e+22
3.33381772e-05 6.68000000e+22
3.61160559e-05 6.68000000e+22
3.88939346e-05 6.68000000e+22
4.16718132e-05 6.68000000e+22
4.44496919e-05 6.68000000e+22
4.72275706e-05 6.68000000e+22
5.00054493e-05 6.68000000e+22
5.27833280e-05 6.68000000e+22
5.55612067e-05 6.68000000e+22
5.83390854e-05 6.68000000e+22
6.11169641e-05 6.68000000e+22
6.38948428e-05 6.68000000e+22
6.66727214e-05 6.68000000e+22
6.94506001e-05 6.68000000e+22
7.22284788e-05 6.68000000e+22
7.50063575e-05 6.68000000e+22
7.77842362e-05 6.68000000e+22
8.05621149e-05 6.68000000e+22
8.33399936e-05 6.68000000e+22
8.61178723e-05 6.68000000e+22
8.88957510e-05 6.68000000e+22
9.16736297e-05 6.68000000e+22
9.44515083e-05 6.68000000e+22
9.72293870e-05 6.68000000e+22
1.00007266e-04 6.67030004e+22
1.02785144e-04 3.82703023e+22
1.05563023e-04 2.19572737e+22
1.08340902e-04 1.25978066e+22
1.11118780e-04 7.22788877e+21
1.13896659e-04 4.14694221e+21
1.16674538e-04 2.37927426e+21
1.19452417e-04 1.36508919e+21
1.22230295e-04 7.83208787e+20
1.25008174e-04 4.49359652e+20
1.27786053e-04 2.57816434e+20
1.30563931e-04 1.47920075e+20
1.33341810e-04 8.48679364e+19
1.36119689e-04 4.86922861e+19
1.38897567e-04 2.79368019e+19
1.41675446e-04 1.60285121e+19
1.44453325e-04 9.19622807e+18
1.47231203e-04 5.27626082e+18
1.50009082e-04 3.02721160e+18
1.52786961e-04 1.73683796e+18
1.55564840e-04 9.96496607e+17
1.58342718e-04 5.71731798e+17
1.61120597e-04 3.28026454e+17
1.63898476e-04 1.88202502e+17
1.66676354e-04 1.07979650e+17
1.69454233e-04 6.19524431e+16
1.72232112e-04 3.55447088e+16
1.75009990e-04 2.03934867e+16
end

;;
function7 ; Oxygen

type 0
data_pairs
-9.99999999e-05 5.40945333e+16
-9.72221212e-05 7.83445932e+16
-9.44442426e-05 1.13465722e+17
-9.16663639e-05 1.64331316e+17
-8.88884852e-05 2.37999467e+17
-8.61106065e-05 3.44692343e+17
-8.33327278e-05 4.99214611e+17
-8.05548491e-05 7.23007728e+17
-7.77769704e-05 1.04712515e+18
-7.49990917e-05 1.51654130e+18
-7.22212130e-05 2.19639220e+18
-6.94433343e-05 3.18101374e+18
-6.66654557e-05 4.60703166e+18
-6.38875770e-05 6.67231972e+18
-6.11096983e-05 9.66345658e+18
-5.83318196e-05 1.39954914e+19
-5.55539409e-05 2.02695358e+19
-5.27760622e-05 2.93561741e+19
-4.99981835e-05 4.25162650e+19
-4.72203048e-05 6.15758984e+19
-4.44424261e-05 8.91797825e+19
-4.16645475e-05 1.29158223e+20
-3.88866688e-05 1.87058614e+20
-3.61087901e-05 2.70915194e+20
-3.33309114e-05 3.92363875e+20
-3.05530327e-05 5.68256833e+20
-2.77751540e-05 8.23000915e+20
-2.49972753e-05 1.19194432e+21
-2.22193966e-05 1.72628152e+21
-1.94415179e-05 2.50015695e+21
-1.66636392e-05 3.62095330e+21
-1.38857606e-05 5.24419190e+21
-1.11078819e-05 7.59511278e+21
-8.33000317e-06 1.09999289e+22
-5.55212448e-06 1.59310914e+22
-2.77424579e-06 2.30728467e+22
3.63289545e-09 3.34000000e+22
2.78151159e-06 3.34000000e+22
5.55939027e-06 3.34000000e+22
8.33726896e-06 3.34000000e+22
1.11151477e-05 3.34000000e+22
1.38930263e-05 3.34000000e+22
1.66709050e-05 3.34000000e+22
1.94487837e-05 3.34000000e+22
2.22266624e-05 3.34000000e+22
2.50045411e-05 3.34000000e+22
2.77824198e-05 3.34000000e+22
3.05602985e-05 3.34000000e+22
3.33381772e-05 3.34000000e+22
3.61160559e-05 3.34000000e+22
3.88939346e-05 3.34000000e+22
4.16718132e-05 3.34000000e+22
4.44496919e-05 3.34000000e+22
4.72275706e-05 3.34000000e+22
5.00054493e-05 3.34000000e+22
5.27833280e-05 3.34000000e+22
5.55612067e-05 3.34000000e+22
5.83390854e-05 3.34000000e+22
6.11169641e-05 3.34000000e+22
6.38948428e-05 3.34000000e+22
6.66727214e-05 3.34000000e+22
6.94506001e-05 3.34000000e+22
7.22284788e-05 3.34000000e+22
7.50063575e-05 3.34000000e+22
7.77842362e-05 3.34000000e+22
8.05621149e-05 3.34000000e+22
8.33399936e-05 3.34000000e+22
8.61178723e-05 3.34000000e+22
8.88957510e-05 3.34000000e+22
9.16736297e-05 3.34000000e+22
9.44515083e-05 3.34000000e+22
9.72293870e-05 3.34000000e+22
1.00007266e-04 3.33515002e+22
1.02785144e-04 1.91351511e+22
1.05563023e-04 1.09786368e+22
1.08340902e-04 6.29890331e+21
1.11118780e-04 3.61394438e+21
1.13896659e-04 2.07347110e+21
1.16674538e-04 1.18963713e+21
1.19452417e-04 6.82544597e+20
1.22230295e-04 3.91604394e+20
1.25008174e-04 2.24679826e+20
1.27786053e-04 1.28908217e+20
1.30563931e-04 7.39600377e+19
1.33341810e-04 4.24339682e+19
1.36119689e-04 2.43461430e+19
1.38897567e-04 1.39684009e+19
1.41675446e-04 8.01425607e+18
1.44453325e-04 4.59811403e+18
1.47231203e-04 2.63813041e+18
1.50009082e-04 1.51360580e+18
1.52786961e-04 8.68418978e+17
1.55564840e-04 4.98248303e+17
1.58342718e-04 2.85865899e+17
1.61120597e-04 1.64013227e+17
1.63898476e-04 9.41012509e+16
1.66676354e-04 5.39898250e+16
1.69454233e-04 3.09762216e+16
1.72232112e-04 1.77723544e+16
1.75009990e-04 1.01967433e+16
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
