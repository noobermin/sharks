[Title]
simulation_title "Forward too complex with matter, I=5e+19"
;
[Control]
;Time-advance
 time_limit   4.0000e-04
 time_step_ns 5.0000e-08

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

xmin             -1.000000e-03
xmax             1.000000e-03
x-cells          400

ymin             -1.320000e-03
ymax             1.320000e-03
y-cells          528

zmin             -1.320000e-03
zmax             1.320000e-03
z-cells          528

[Regions]
;total number of domains: 352
;
region1
xmin             -1.000000e-03
xmax             0.000000e+00

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
xmin             -1.000000e-03
xmax             0.000000e+00

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
xmin             -1.000000e-03
xmax             0.000000e+00

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
xmin             -1.000000e-03
xmax             0.000000e+00

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
xmin             0.000000e+00
xmax             1.000000e-03

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
xmin             0.000000e+00
xmax             1.000000e-03

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
xmin             0.000000e+00
xmax             1.000000e-03

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
xmin             0.000000e+00
xmax             1.000000e-03

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
from -1.000000e-03  -1.320000e-03 -1.320000e-03
to   -1.000000e-03  1.320000e-03 1.320000e-03
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
from 1.000000e-03  -1.320000e-03 -1.320000e-03
to   1.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;left
outlet
from -1.000000e-03  -1.320000e-03 -1.320000e-03
to   1.000000e-03  -1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;right
outlet
from -1.000000e-03  1.320000e-03 -1.320000e-03
to   1.000000e-03  1.320000e-03 1.320000e-03
phase_velocity 1.0
drive_model NONE

;bottom
outlet
from -1.000000e-03  -1.320000e-03 -1.320000e-03
to   1.000000e-03  1.320000e-03 -1.320000e-03
phase_velocity 1.0
drive_model NONE

;top
outlet
from -1.000000e-03  -1.320000e-03 1.320000e-03
to   1.000000e-03  1.320000e-03 1.320000e-03
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

;
[Particle Extraction]

;
extract1
species 12
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.001 0 0

 
;
extract2
species 12
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.001 0 0

 
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
coefficients 1.940954e+08 2.547965e-05 8.000000e-05 -2.000000e-05 end

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
