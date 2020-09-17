[Title]
simulation_title "attempt to use nour's stuff"
;
[Control]
;Time-advance
 time_limit   2.0000e-04
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

xmin             -1.320000e-03
xmax             1.320000e-03
x-cells          660

ymin             -1.320000e-03
ymax             1.320000e-03
y-cells          660


[Regions]
;total number of domains: 44
;
region1
xmin             -1.320000e-03
xmax             1.320000e-03

ymin             -1.320000e-03
ymax             1.320000e-03

zmin             0.000000e+00
zmax             0.000000e+00
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
from -1.320000e-03  -1.320000e-03 0.000000e+00
to   -1.320000e-03  1.320000e-03 0.000000e+00
phase_velocity 1.0
drive_model LASER
reference_point 0.0 0.0 0.0
components 0 1 0
phases 0 0 0
temporal_function 1
analytic_function 3
time_delay 0.0

;back
outlet
from 1.320000e-03  -1.320000e-03 0.000000e+00
to   1.320000e-03  1.320000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;left
outlet
from -1.320000e-03  -1.320000e-03 0.000000e+00
to   1.320000e-03  -1.320000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;right
outlet
from -1.320000e-03  1.320000e-03 0.000000e+00
to   1.320000e-03  1.320000e-03 0.000000e+00
phase_velocity 1.0
drive_model NONE

;
[Particle Species]
species1 ; H
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

species2 ; p
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

species3 ; e
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
plasma ; H
from -4.500000e-04 -9.500000e-04 0.000000e+00
to 4.500000e-04 9.500000e-04 0.000000e+00
species 1
discrete_numbers 3 3 1
density_function 4
reference_point 0 0 0
density_flags 1 1 0
momentum_flags 0 0 0
drift_momentum 0 0 0
thermal_energy 1.0

higherstate ; H -> p
from -1.320000e-03 -1.320000e-03 0.000000e+00
to 1.320000e-03 1.320000e-03 0.000000e+00
interval 1
species 1
ion_species 2
electron_species 3
ionization_potential 13.6
cross_sections 0 0 0 end


;
[Particle Extraction]

;
extract1
species 3
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at -0.00132 0 0

 
;
extract2
species 3
direction X
maximum_number  1000000000
start_time 0
stop_time  1
at 0.00132 0 0

 
;
extract3
species 3
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 -0.00132 0

 
;
extract4
species 3
direction Y
maximum_number  1000000000
start_time 0
stop_time  1
at 0 0.00132 0


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
coefficients 8.680211e+07 2.547965e-05 8.000000e-05 -2.000000e-05 end


function2 ; 
type 87
coefficients 0.000000e+00 1.000000e+00 0.000000e+00 end



function3 ; laser
type 85
laser
  temporal_function 1
  polarization_function 2
  wavelength 8.000000e-05
  spotsize 1.018592e-04
  phase    0.000000e+00
  lp_mode 0 0
  focal_point 0.0 0.0 0.0
  direction 1 0 0

end
function4 ; 
type 40
data_file dens.dat
independent_variable_multiplier 1.0
dependent_variable_multiplier 1

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
