[Title]
simulation_title "Forward too complex with matter, I=1e+20"
;
[Control]
;Time-advance
 time_limit   2.0000e-04
 time_step_ns 2.5000e-08

;;Restarts
dump_restart_flag ON
rename_restart_flag ON
restart_interval_ns 1.0000000000000002e-06

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

;;Numeric Checks
domain_boundary_check ON





[Grid]

xmin             -2.000000e-03
xmax             2.000000e-03
x-cells          800

ymin             -1.320000e-03
ymax             1.320000e-03
y-cells          528

zmin             -1.320000e-03
zmax             1.320000e-03
z-cells          528

[Regions]
;total number of domains: 528
;
region1
xmin             -2.000000e-03
xmax             -6.800000e-04

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -2.000000e-03
xmax             -6.800000e-04

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -2.000000e-03
xmax             -6.800000e-04

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -2.000000e-03
xmax             -6.800000e-04

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -6.800000e-04
xmax             6.800000e-04

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region6
xmin             -6.800000e-04
xmax             6.800000e-04

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region7
xmin             -6.800000e-04
xmax             6.800000e-04

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region8
xmin             -6.800000e-04
xmax             6.800000e-04

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region9
xmin             6.800000e-04
xmax             2.000000e-03

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region10
xmin             6.800000e-04
xmax             2.000000e-03

ymin             -1.320000e-03
ymax             0.000000e+00

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region11
xmin             6.800000e-04
xmax             2.000000e-03

ymin             0.000000e+00
ymax             1.320000e-03

zmin             -1.320000e-03
zmax             0.000000e+00
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region12
xmin             6.800000e-04
xmax             2.000000e-03

ymin             0.000000e+00
ymax             1.320000e-03

zmin             0.000000e+00
zmax             1.320000e-03
;
number_of_domains 44
split_direction XSPLIT
number_of_cells AUTO; 
;

;

[Objects]

		;

[MediumModels]
medium1 ; dieletric material
method 0
type DENSE
dielectric_constant 3.5
surface_conductivity 0.0
permeability 1.0
temperature 300.0
conductivity off
energy_units EV
;
[CircuitModels]

;
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

;back
outlet
from 2.000000e-03  -1.320000e-03 -1.320000e-03
to   2.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;left
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   2.000000e-03  -1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -2.000000e-03  1.320000e-03 -1.320000e-03
to   2.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -2.000000e-03  -1.320000e-03 -1.320000e-03
to   2.000000e-03  1.320000e-03 -1.320000e-03
phase_velocity 1.0
drive_model NONE

;top
outlet
from -2.000000e-03  -1.320000e-03 1.320000e-03
to   2.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;
[Particle Species]
species1 ; Oxygen
charge 0
mass 29164.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag OFF
selection_ratio 1.0

species2 ; O+
charge 1
mass 29163.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species3 ; O++
charge 2
mass 29162.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species4 ; O3+
charge 3
mass 29161.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species5 ; O4+
charge 4
mass 29160.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species6 ; O5+
charge 5
mass 29159.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species7 ; O6+
charge 6
mass 29158.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species8 ; O7+
charge 7
mass 29157.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species9 ; O8+
charge 8
mass 29156.4
atomic_number 8
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species10 ; H
charge 0
mass 1837.4
atomic_number 1
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag OFF
selection_ratio 1.0

species11 ; p
charge 1
mass 1836.2
atomic_number 1
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0

species12 ; e
charge -1
mass 1.0
fluid_species_flag OFF
migrant_species_flag OFF
implicit_species_flag OFF
particle_motion_flag ON
particle_forces_option PRIMARY
transverse_weighting_flag ON
particle_kinematics_option STANDARD
scattering_flag ON
selection_ratio 1.0


;
[Particle Creation]
plasma ; O+
from -1.126611e-04 -5.000000e-04 -5.000000e-04
to 1.751074e-04 5.000000e-04 5.000000e-04
species 2
discrete_numbers 2 2 2
density_function 7
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

plasma ; p
from -1.126611e-04 -5.000000e-04 -5.000000e-04
to 1.751074e-04 5.000000e-04 5.000000e-04
species 11
discrete_numbers 2 2 2
density_function 8
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

plasma ; e
from -1.126611e-04 -5.000000e-04 -5.000000e-04
to 1.751074e-04 5.000000e-04 5.000000e-04
species 12
discrete_numbers 2 2 2
density_function 9
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

higherstate ; O -> O+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 1
ion_species 2
electron_species 12
ionization_potential 13.6
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O+ -> O++
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 2
ion_species 3
electron_species 12
ionization_potential 35.1
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O++ -> O3+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 3
ion_species 4
electron_species 12
ionization_potential 54.9
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O3+ -> O4+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 4
ion_species 5
electron_species 12
ionization_potential 77.4
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O4+ -> O5+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 5
ion_species 6
electron_species 12
ionization_potential 113.9
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O5+ -> O6+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 6
ion_species 7
electron_species 12
ionization_potential 138.1
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O6+ -> O7+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 7
ion_species 8
electron_species 12
ionization_potential 739.4
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O7+ -> O8+
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 8
ion_species 9
electron_species 12
ionization_potential 871.4
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; H -> p
from -2.000000e-03 -1.320000e-03 -1.320000e-03
to 2.000000e-03 1.320000e-03 1.320000e-03
interval 1
species 10
ion_species 11
electron_species 12
ionization_potential 13.6
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end


;
[Particle Extraction]

;
extract1
species 12
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.002 0 0

 
;
extract2
species 12
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.002 0 0

 
;
extract3
species 12
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.00132 0

 
;
extract4
species 12
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.00132 0

 
;
extract5
species 12
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 -0.00132

 
;
extract6
species 12
direction Z
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0 0.00132


;[Particle Collapse]
;collapse1 ; remap
;interval 10
;species 3
;threshold 0
;collapse_type EULERIAN
;target_number 40
;tolerance 1.e-4
;momentum_distribution_type BINNED
;number_of_bins 400
;charge_criterion 1.0E-05
;energy_criterion 1.5
;use_eos_distribution_flag 0
;movie_tag 3
;movie_fraction 0.1
;
;

[Functions]


function1 ; temporal laser function
type 16
coefficients 2.744924e+08 2.547965e-05 8.000000e-05 -2.000000e-05 end

function2
type 55
data_file nour01Ey_real.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

function3
type 55
data_file nour01Ey_imag.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

function4
type 55
data_file nour01Ez_real.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0

function5
type 55
data_file nour01Ez_imag.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1.0



function6 ; laser
type 56
laser
  temporal_function 1
  Ey_real 2
  Ey_imag 3
  Ez_real 4
  Ez_imag 5
  wavelength 8.000000e-05
  direction 1 0 0
  focal_point 0.0 0.0 0.0

end
function7 ; 
type 0
data_pairs
-1.12661110e-04 1.00000000e+16
-1.09754358e-04 1.47339171e+16
-1.06847605e-04 2.17088312e+16
-1.03940852e-04 3.19856119e+16
-1.01034099e-04 4.71273352e+16
-9.81273467e-05 6.94370249e+16
-9.52205941e-05 1.02307937e+17
-9.23138414e-05 1.50739665e+17
-8.94070887e-05 2.22098573e+17
-8.65003360e-05 3.27238195e+17
-8.35935833e-05 4.82150042e+17
-8.06868306e-05 7.10395873e+17
-7.77800779e-05 1.04669139e+18
-7.48733252e-05 1.54218641e+18
-7.19665725e-05 2.27224467e+18
-6.90598198e-05 3.34790645e+18
-6.61530671e-05 4.93277759e+18
-6.32463144e-05 7.26791359e+18
-6.03395617e-05 1.07084836e+19
-5.74328090e-05 1.57777909e+19
-5.45260563e-05 2.32468663e+19
-5.16193036e-05 3.42517400e+19
-4.87125509e-05 5.04662297e+19
-4.58057982e-05 7.43565243e+19
-4.28990455e-05 1.09556286e+20
-3.99922928e-05 1.61419323e+20
-3.70855401e-05 2.37833892e+20
-3.41787874e-05 3.50422485e+20
-3.12720347e-05 5.16309583e+20
-2.83652820e-05 7.60726257e+20
-2.54585293e-05 1.12084776e+21
-2.25517766e-05 1.65144779e+21
-1.96450239e-05 2.43322948e+21
-1.67382712e-05 3.58510013e+21
-1.38315185e-05 5.28225680e+21
-1.09247658e-05 7.78283336e+21
-8.01801312e-06 1.14671621e+22
-5.11126043e-06 1.68956216e+22
-2.20450773e-06 2.48938687e+22
7.02244969e-07 3.34000000e+22
3.60899767e-06 3.34000000e+22
6.51575036e-06 3.34000000e+22
9.42250306e-06 3.34000000e+22
1.23292558e-05 3.34000000e+22
1.52360085e-05 3.34000000e+22
1.81427612e-05 3.34000000e+22
2.10495139e-05 3.34000000e+22
2.39562665e-05 3.34000000e+22
2.68630192e-05 3.34000000e+22
2.97697719e-05 3.34000000e+22
3.26765246e-05 3.34000000e+22
3.55832773e-05 3.34000000e+22
3.84900300e-05 3.34000000e+22
4.13967827e-05 3.34000000e+22
4.43035354e-05 3.34000000e+22
4.72102881e-05 3.34000000e+22
5.01170408e-05 3.34000000e+22
5.30237935e-05 3.34000000e+22
5.59305462e-05 3.34000000e+22
5.88372989e-05 3.34000000e+22
6.17440516e-05 3.34000000e+22
6.46508043e-05 3.34000000e+22
6.75575570e-05 3.34000000e+22
7.04643097e-05 3.34000000e+22
7.33710624e-05 3.34000000e+22
7.62778151e-05 3.34000000e+22
7.91845678e-05 3.34000000e+22
8.20913205e-05 3.34000000e+22
8.49980732e-05 3.34000000e+22
8.79048259e-05 3.34000000e+22
9.08115786e-05 3.34000000e+22
9.37183313e-05 3.34000000e+22
9.66250840e-05 3.34000000e+22
9.95318367e-05 3.34000000e+22
1.02438589e-04 2.05084711e+22
1.05345342e-04 1.14671621e+22
1.08252095e-04 6.41178013e+21
1.11158847e-04 3.58510013e+21
1.14065600e-04 2.00458261e+21
1.16972353e-04 1.12084776e+21
1.19879106e-04 6.26713855e+20
1.22785858e-04 3.50422485e+20
1.25692611e-04 1.95936178e+20
1.28599364e-04 1.09556286e+20
1.31506116e-04 6.12575990e+19
1.34412869e-04 3.42517400e+19
1.37319622e-04 1.91516108e+19
1.40226374e-04 1.07084836e+19
1.43133127e-04 5.98757057e+18
1.46039880e-04 3.34790645e+18
1.48946633e-04 1.87195749e+18
1.51853385e-04 1.04669139e+18
1.54760138e-04 5.85249861e+17
1.57666891e-04 3.27238195e+17
1.60573643e-04 1.82972852e+17
1.63480396e-04 1.02307937e+17
1.66387149e-04 5.72047371e+16
1.69293901e-04 3.19856119e+16
1.72200654e-04 1.78845218e+16
1.75107407e-04 1.00000000e+16

end
function8 ; 
type 0
data_pairs
-1.12661110e-04 2.00000000e+16
-1.09754358e-04 2.94678341e+16
-1.06847605e-04 4.34176624e+16
-1.03940852e-04 6.39712237e+16
-1.01034099e-04 9.42546704e+16
-9.81273467e-05 1.38874050e+17
-9.52205941e-05 2.04615873e+17
-9.23138414e-05 3.01479330e+17
-8.94070887e-05 4.44197145e+17
-8.65003360e-05 6.54476390e+17
-8.35935833e-05 9.64300084e+17
-8.06868306e-05 1.42079175e+18
-7.77800779e-05 2.09338278e+18
-7.48733252e-05 3.08437282e+18
-7.19665725e-05 4.54448933e+18
-6.90598198e-05 6.69581289e+18
-6.61530671e-05 9.86555518e+18
-6.32463144e-05 1.45358272e+19
-6.03395617e-05 2.14169672e+19
-5.74328090e-05 3.15555819e+19
-5.45260563e-05 4.64937326e+19
-5.16193036e-05 6.85034801e+19
-4.87125509e-05 1.00932459e+20
-4.58057982e-05 1.48713049e+20
-4.28990455e-05 2.19112572e+20
-3.99922928e-05 3.22838647e+20
-3.70855401e-05 4.75667785e+20
-3.41787874e-05 7.00844969e+20
-3.12720347e-05 1.03261917e+21
-2.83652820e-05 1.52145251e+21
-2.54585293e-05 2.24169552e+21
-2.25517766e-05 3.30289558e+21
-1.96450239e-05 4.86645896e+21
-1.67382712e-05 7.17020026e+21
-1.38315185e-05 1.05645136e+22
-1.09247658e-05 1.55656667e+22
-8.01801312e-06 2.29343243e+22
-5.11126043e-06 3.37912431e+22
-2.20450773e-06 4.97877374e+22
7.02244969e-07 6.68000000e+22
3.60899767e-06 6.68000000e+22
6.51575036e-06 6.68000000e+22
9.42250306e-06 6.68000000e+22
1.23292558e-05 6.68000000e+22
1.52360085e-05 6.68000000e+22
1.81427612e-05 6.68000000e+22
2.10495139e-05 6.68000000e+22
2.39562665e-05 6.68000000e+22
2.68630192e-05 6.68000000e+22
2.97697719e-05 6.68000000e+22
3.26765246e-05 6.68000000e+22
3.55832773e-05 6.68000000e+22
3.84900300e-05 6.68000000e+22
4.13967827e-05 6.68000000e+22
4.43035354e-05 6.68000000e+22
4.72102881e-05 6.68000000e+22
5.01170408e-05 6.68000000e+22
5.30237935e-05 6.68000000e+22
5.59305462e-05 6.68000000e+22
5.88372989e-05 6.68000000e+22
6.17440516e-05 6.68000000e+22
6.46508043e-05 6.68000000e+22
6.75575570e-05 6.68000000e+22
7.04643097e-05 6.68000000e+22
7.33710624e-05 6.68000000e+22
7.62778151e-05 6.68000000e+22
7.91845678e-05 6.68000000e+22
8.20913205e-05 6.68000000e+22
8.49980732e-05 6.68000000e+22
8.79048259e-05 6.68000000e+22
9.08115786e-05 6.68000000e+22
9.37183313e-05 6.68000000e+22
9.66250840e-05 6.68000000e+22
9.95318367e-05 6.68000000e+22
1.02438589e-04 4.10169421e+22
1.05345342e-04 2.29343243e+22
1.08252095e-04 1.28235603e+22
1.11158847e-04 7.17020026e+21
1.14065600e-04 4.00916522e+21
1.16972353e-04 2.24169552e+21
1.19879106e-04 1.25342771e+21
1.22785858e-04 7.00844969e+20
1.25692611e-04 3.91872357e+20
1.28599364e-04 2.19112572e+20
1.31506116e-04 1.22515198e+20
1.34412869e-04 6.85034801e+19
1.37319622e-04 3.83032216e+19
1.40226374e-04 2.14169672e+19
1.43133127e-04 1.19751411e+19
1.46039880e-04 6.69581289e+18
1.48946633e-04 3.74391498e+18
1.51853385e-04 2.09338278e+18
1.54760138e-04 1.17049972e+18
1.57666891e-04 6.54476390e+17
1.60573643e-04 3.65945703e+17
1.63480396e-04 2.04615873e+17
1.66387149e-04 1.14409474e+17
1.69293901e-04 6.39712237e+16
1.72200654e-04 3.57690435e+16
1.75107407e-04 2.00000000e+16

end
function9 ; 
type 0
data_pairs
-1.12661110e-04 3.00000000e+16
-1.09754358e-04 4.42017512e+16
-1.06847605e-04 6.51264936e+16
-1.03940852e-04 9.59568356e+16
-1.01034099e-04 1.41382006e+17
-9.81273467e-05 2.08311075e+17
-9.52205941e-05 3.06923810e+17
-9.23138414e-05 4.52218996e+17
-8.94070887e-05 6.66295718e+17
-8.65003360e-05 9.81714584e+17
-8.35935833e-05 1.44645013e+18
-8.06868306e-05 2.13118762e+18
-7.77800779e-05 3.14007416e+18
-7.48733252e-05 4.62655923e+18
-7.19665725e-05 6.81673400e+18
-6.90598198e-05 1.00437193e+19
-6.61530671e-05 1.47983328e+19
-6.32463144e-05 2.18037408e+19
-6.03395617e-05 3.21254508e+19
-5.74328090e-05 4.73333728e+19
-5.45260563e-05 6.97405990e+19
-5.16193036e-05 1.02755220e+20
-4.87125509e-05 1.51398689e+20
-4.58057982e-05 2.23069573e+20
-4.28990455e-05 3.28668859e+20
-3.99922928e-05 4.84257970e+20
-3.70855401e-05 7.13501677e+20
-3.41787874e-05 1.05126745e+21
-3.12720347e-05 1.54892875e+21
-2.83652820e-05 2.28217877e+21
-2.54585293e-05 3.36254327e+21
-2.25517766e-05 4.95434337e+21
-1.96450239e-05 7.29968843e+21
-1.67382712e-05 1.07553004e+22
-1.38315185e-05 1.58467704e+22
-1.09247658e-05 2.33485001e+22
-8.01801312e-06 3.44014864e+22
-5.11126043e-06 5.06868647e+22
-2.20450773e-06 7.46816061e+22
7.02244969e-07 1.00200000e+23
3.60899767e-06 1.00200000e+23
6.51575036e-06 1.00200000e+23
9.42250306e-06 1.00200000e+23
1.23292558e-05 1.00200000e+23
1.52360085e-05 1.00200000e+23
1.81427612e-05 1.00200000e+23
2.10495139e-05 1.00200000e+23
2.39562665e-05 1.00200000e+23
2.68630192e-05 1.00200000e+23
2.97697719e-05 1.00200000e+23
3.26765246e-05 1.00200000e+23
3.55832773e-05 1.00200000e+23
3.84900300e-05 1.00200000e+23
4.13967827e-05 1.00200000e+23
4.43035354e-05 1.00200000e+23
4.72102881e-05 1.00200000e+23
5.01170408e-05 1.00200000e+23
5.30237935e-05 1.00200000e+23
5.59305462e-05 1.00200000e+23
5.88372989e-05 1.00200000e+23
6.17440516e-05 1.00200000e+23
6.46508043e-05 1.00200000e+23
6.75575570e-05 1.00200000e+23
7.04643097e-05 1.00200000e+23
7.33710624e-05 1.00200000e+23
7.62778151e-05 1.00200000e+23
7.91845678e-05 1.00200000e+23
8.20913205e-05 1.00200000e+23
8.49980732e-05 1.00200000e+23
8.79048259e-05 1.00200000e+23
9.08115786e-05 1.00200000e+23
9.37183313e-05 1.00200000e+23
9.66250840e-05 1.00200000e+23
9.95318367e-05 1.00200000e+23
1.02438589e-04 6.15254132e+22
1.05345342e-04 3.44014864e+22
1.08252095e-04 1.92353404e+22
1.11158847e-04 1.07553004e+22
1.14065600e-04 6.01374783e+21
1.16972353e-04 3.36254327e+21
1.19879106e-04 1.88014157e+21
1.22785858e-04 1.05126745e+21
1.25692611e-04 5.87808535e+20
1.28599364e-04 3.28668859e+20
1.31506116e-04 1.83772797e+20
1.34412869e-04 1.02755220e+20
1.37319622e-04 5.74548324e+19
1.40226374e-04 3.21254508e+19
1.43133127e-04 1.79627117e+19
1.46039880e-04 1.00437193e+19
1.48946633e-04 5.61587247e+18
1.51853385e-04 3.14007416e+18
1.54760138e-04 1.75574958e+18
1.57666891e-04 9.81714584e+17
1.60573643e-04 5.48918555e+17
1.63480396e-04 3.06923810e+17
1.66387149e-04 1.71614211e+17
1.69293901e-04 9.59568356e+16
1.72200654e-04 5.36535653e+16
1.75107407e-04 3.00000000e+16

end

;
[Probes];
probe1
energy net_energy

probe2
energy total_energy

probe3
energy particle_energy

probe4
energy field_energy

probe5
performance cpu_time


;
