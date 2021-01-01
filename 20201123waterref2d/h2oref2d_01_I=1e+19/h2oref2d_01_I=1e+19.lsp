[Title]
simulation_title "Water reference with 60fs pulse, I=1"
;
[Control]
;Time-advance
 time_limit   1.0000e-03
 time_step_ns 4.0000e-08

;;Restarts
dump_restart_flag ON
rename_restart_flag ON
restart_interval 25

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

xmin             -1.100000e-03
xmax             1.100000e-03
x-cells          1100

ymin             -1.100000e-03
ymax             1.100000e-03
y-cells          1100


[Regions]
;total number of domains: 200
;
region1
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -1.100000e-03
ymax             -6.600000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 40
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region2
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -6.600000e-04
ymax             -2.200000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 40
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region3
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             -2.200000e-04
ymax             2.200000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 40
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region4
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             2.200000e-04
ymax             6.600000e-04

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 40
split_direction XSPLIT
number_of_cells AUTO; 
;
;
region5
xmin             -1.100000e-03
xmax             1.100000e-03

ymin             6.600000e-04
ymax             1.100000e-03

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 40
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
from -1.100000e-03  -1.100000e-03 -0.000000e+00
to   -1.100000e-03  1.100000e-03 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point 7.071067811865475e-05 7.071067811865475e-05 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 3
time_delay 0.0

;back
outlet
from 1.100000e-03  -1.100000e-03 -0.000000e+00
to   1.100000e-03  1.100000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;left
outlet
from -1.100000e-03  -1.100000e-03 -0.000000e+00
to   1.100000e-03  -1.100000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;right
outlet
from -1.100000e-03  1.100000e-03 -0.000000e+00
to   1.100000e-03  1.100000e-03 0.000000e+00
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
mass 1837.2
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
from -6.717514e-04 -6.717514e-04 -0.000000e+00
to 6.717514e-04 6.717514e-04 0.000000e+00
species 2
discrete_numbers 3 3 1
density_function 4
reference_point 0 0 0
density_flags 1 1 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

plasma ; p
from -6.717514e-04 -6.717514e-04 -0.000000e+00
to 6.717514e-04 6.717514e-04 0.000000e+00
species 11
discrete_numbers 3 3 1
density_function 5
reference_point 0 0 0
density_flags 1 1 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

plasma ; e
from -6.717514e-04 -6.717514e-04 -0.000000e+00
to 6.717514e-04 6.717514e-04 0.000000e+00
species 12
discrete_numbers 3 3 1
density_function 6
reference_point 0 0 0
density_flags 1 1 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

higherstate ; O -> O+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 1
ion_species 2
electron_species 12
ionization_potential 13.6
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O+ -> O++
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 2
ion_species 3
electron_species 12
ionization_potential 35.1
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O++ -> O3+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 3
ion_species 4
electron_species 12
ionization_potential 54.9
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O3+ -> O4+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 4
ion_species 5
electron_species 12
ionization_potential 77.4
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O4+ -> O5+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 5
ion_species 6
electron_species 12
ionization_potential 113.9
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O5+ -> O6+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 6
ion_species 7
electron_species 12
ionization_potential 138.1
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O6+ -> O7+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 7
ion_species 8
electron_species 12
ionization_potential 739.4
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; O7+ -> O8+
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
interval 1
species 8
ion_species 9
electron_species 12
ionization_potential 871.4
cross_sections 0 0 0 0 0 0 0 0 0 0 0 0 end

higherstate ; H -> p
from -1.100000e-03 -1.100000e-03 -0.000000e+00
to 1.100000e-03 1.100000e-03 0.000000e+00
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
species 11
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0011 0 0

 
;
extract2
species 11
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0011 0 0

 
;
extract3
species 11
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0011 0

 
;
extract4
species 11
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0011 0

 
;
extract5
species 12
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.0011 0 0

 
;
extract6
species 12
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.0011 0 0

 
;
extract7
species 12
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.0011 0

 
;
extract8
species 12
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.0011 0


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
coefficients 8.680211e+07 2.547965e-05 9.000000e-05 5.330795e-05 end


function2 ; 
type 87
coefficients 0.000000e+00 1.000000e+00 0.000000e+00 end



function3 ; laser
type 85
laser
  temporal_function     1
  polarization_function 2
  wavelength     8.000000e-05
  spotsize       1.527887e-04
  phase          0.000000e+00
  timeshift_type 0.0
  lp_mode        0 0
  focal_point    7.071067811865475e-05 7.071067811865475e-05 0.0
  direction      1 0 0

end
function4 ; 
type 40
data_file dens.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1
function5 ; 
type 40
data_file dens.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 2
function6 ; 
type 40
data_file dens.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 3

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
