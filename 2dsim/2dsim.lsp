[Title]
simulation_title "hot water = laser experiment at Wright Patt, I = 1e18 W cm-2 "
;
[Control]
;Time-advance
 time_limit 500e-6 ;
; time_limit 0.2e-6 
;number_of_steps 2
 time_step_ns 0.110e-6 ; 1/30th optical cycle for 1um laser light
;Restarts
 restart_interval_ns 99e-6 ; probably much longer than max dump time
 maximum_restart_dump_time 11.95 ;in hours
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
 dump_number_densities_flag ON
 dump_plasma_quantities_flag ON
 dump_velocities_flag ON
 extract_photons_flag ON
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 1e-6
 dump_steps
1 
end
 spatial_skip_x 1
 spatial_skip_z 1
 probe_interval 100
;(Diagnostic Output) Formats
 photon_output_format ASCII
 target_output_format ASCII
 use_its_format_flag OFF
 print_region_flag OFF
;(Diagnostic Output) Movie Controls
 particle_movie_interval_ns 0.5e-6
 particle_movie_components Q X Z VX VZ XI ZI
;Numerical Checks and Reports
 domain_boundary_check ON
 report_timing_flag ON
 dump_timing_flag ON
;
[Grid]
;
grid1
xmin             -0.0030
xmax              0.0030
x-cells           1200
;
zmin             -0.0030
zmax              0.0030
z-cells           1200
;
[Regions]
;
region1
xmin -0.0030
xmax  0.0030
zmin -0.0030
zmax  0.0030
number_of_domains 48
split_direction ZSPLIT 
number_of_cells AUTO
;
;[Objects]
;
;object1 BLOCK ;
;conductor off medium 1 potential 0
;  from -0.0030 0 -0.0030
;  to    0.0030 0 0.0030
;
;[MediumModels]
;
;medium1 ; Oxygen
;method 4
;type TENUOUS
;dielectric_constant 1.0
;permeability 1.0
;species 10
;conductivity off
;electron_density 0.0
;initial_temperature 300.0
;xgen_data_file H2O.its
;;electron_cutoff_energy 100
;;photon_cutoff_energy 100
;electron_transport_flag 1
;photon_probability_factor 10.0
;diagnostic_flag on
;components 
;oxygen fraction 1.0
;end
;energy_units EV
;
[Boundaries]
;
outlet
from -0.003 0 -0.003
to -0.003 0 0.003
phase_velocity 1.0
drive_model LASER
reference_point 0 0 0
components 0 0 1
phases 0 0 0
temporal_function 1
analytic_function 2
time_delay 0.0
;
outlet
from -0.003 0 0.003
to 0.003 0 0.003
phase_velocity 1.0
drive_model NONE
;
outlet
from 0.003 0 0.003
to 0.003 0 -0.003
phase_velocity 1.0
drive_model NONE
;
outlet
from 0.003 0 -0.003
to -0.003 0 -0.003
phase_velocity 1.0
drive_model NONE
;
[Materials]
;
material oxygen
atomic_number 8
atomic_weight 16
;ionization_potential 35.1; eV
ionization_potential 13.6; eV
specific_heat 4.186; J/gK
thermal_conductivity 0.0058; (W / mK)/100 
;
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
;
[Particle Creation]
;
;plasma ; O+
;from -0.001 0 -0.001
;to 0.001 0 0.001
;species 2
;movie_tag 3
;unbound off
;discrete_numbers 7 1 7
;density_function 4
;reference_point 0 0 0
;density_flags 1 0 1
;momentum_flags 0 0 0
;thermal_energy 1
;movie_fraction 0.010
;
;plasma ; e-
;from -0.001 0 -0.001
;to 0.001 0 0.001
;species 10
;movie_tag 3
;unbound off
;discrete_numbers 7 1 7
;density_function 4
;reference_point 0 0 0
;density_flags 1 0 1
;momentum_flags 0 0 0
;thermal_energy 1
;movie_fraction 0.010
;
plasma ; O+
from -0.0030 0 -0.0015
to 0.0000 0 0.0015
species 2
movie_tag 3
unbound off
discrete_numbers 7 1 7
density_function 6
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
plasma ; e-
from -0.0030 0 -0.0015
to 0.0000 0 0.0015
species 10
movie_tag 3
unbound off
discrete_numbers 7 1 7
density_function 5
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.050
;
plasma ; p
from -0.0030 0 -0.0015
to 0.0000 0 0.0015
species 11
movie_tag 3
unbound off
discrete_numbers 7 1 7
density_function 7
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
higherstate              ; O -> O+
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
from -0.0030 0 -0.0030
to 0.0030 0 0.0030
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
;
;
[Particle Extraction]
;
extract1
species 10
direction X
maximum_number 1000000000
start_time 0.0
stop_time 1
at -0.0030 0 0
;
extract2
species 10
direction X
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0.0030 0 0
;
extract3
species 10
direction Z
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0 0 0.0030
;
extract4
species 10
direction Z
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0 0 -0.0030
;
[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
independent_variable_multiplier 60.0e-6 ; =2xFWHM,  70 fs FWHM pulse
;dependent_variable_multiplier 1.736e8  ; = Emax in kV/cm units, 1.736e8 => 4*10^19 W/cm^2
;dependent_variable_multiplier 8.68e5  ; = Emax in kV/cm units, 8.68e5 => 10^15 W/cm^2
dependent_variable_multiplier 2.75e7  ; = Emax in kV/cm units, 2.75e7 => 10^18 W/cm^2
;
function2 ; laser analytic function
type 19
coefficients 0.8e-4 1.27e-4 end
;
function3 ; Oxygen number dens
type 1
coefficients 3.33E+22 end 
;
function4 ; Electron number dens
type 1
coefficients 1.00E+23 end 
;
function5 ; proton number dens
type 1
coefficients 6.67e+22 end 
;
function5
type 0
data_pairs
0       1.0e23
5.00000000000000e-05    1.0e23
0.000100000000000000    1.0e23
0.000150000000000000    1.0e23
0.000200000000000000    1.0e23
0.000250000000000000    1.0e23
0.000300000000000000    1.0e23
0.000350000000000000    1.0e23
0.000400000000000000    1.0e23
0.000450000000000000    1.0e23
0.000500000000000000    1.0e23
0.000550000000000000    1.0e23
0.000600000000000000    1.0e23
0.000650000000000000    1.0e23
0.000700000000000000    1.0e23
0.000750000000000000    1.0e23
0.000800000000000000    1.0e23
0.000850000000000000    1.0e23
0.000900000000000000    1.0e23
0.000950000000000000    1.0e23
0.001000000000000000    1.0e23
0.001050000000000000    7.16531e22
0.001100000000000000    5.13417e22
0.001150000000000000    3.67879e22
0.001200000000000000    2.63597e22
0.001250000000000000    1.88876e22
0.001300000000000000    1.35335e22
0.001350000000000000    9.69720e21
0.001400000000000000    6.94835e21
0.001450000000000000    4.97871e21
0.001500000000000000    3.56740e21
0.001550000000000000    2.55615e21
0.001600000000000000    1.83156e21
0.001650000000000000    1.31237e21
0.001700000000000000    9.40356e20
0.001750000000000000    6.73795e20
0.001800000000000000    4.82795e20
0.001850000000000000    3.45938e20
0.001900000000000000    2.47875e20
0.001950000000000000    1.77610e20
0.002000000000000000    1.27263e20
0.002050000000000000    9.11882e19
0.002100000000000000    6.53392e19
0.002150000000000000    4.68176e19
0.002200000000000000    3.35463e19
0.002250000000000000    2.40369e19
0.002300000000000000    1.72232e19
0.002350000000000000    1.23410e19
0.002400000000000000    8.84270e18
0.002450000000000000    6.33607e18
0.002500000000000000    4.53999e18
0.002550000000000000    3.25305e18
0.002600000000000000    2.33091e18
0.002650000000000000    1.67017e18
0.002700000000000000    1.19673e18
0.002750000000000000    0.0
end
;
function6
type 0
data_pairs
0       3.3e22
5.00000000000000e-05    3.3e22
0.000100000000000000    3.3e22
0.000150000000000000    3.3e22
0.000200000000000000    3.3e22
0.000250000000000000    3.3e22
0.000300000000000000    3.3e22
0.000350000000000000    3.3e22
0.000400000000000000    3.3e22
0.000450000000000000    3.3e22
0.000500000000000000    3.3e22
0.000550000000000000    3.3e22
0.000600000000000000    3.3e22
0.000650000000000000    3.3e22
0.000700000000000000    3.3e22
0.000750000000000000    3.3e22
0.000800000000000000    3.3e22
0.000850000000000000    3.3e22
0.000900000000000000    3.3e22
0.000950000000000000    3.3e22
0.001000000000000000    3.30000e22
0.001050000000000000    2.36455e22
0.001100000000000000    1.69428e22
0.001150000000000000    1.21400e22
0.001200000000000000    8.69871e21
0.001250000000000000    6.23289e21
0.001300000000000000    4.46606e21
0.001350000000000000    3.20007e21
0.001400000000000000    2.29295e21
0.001450000000000000    1.64297e21
0.001500000000000000    1.17724e21
0.001550000000000000    8.43531e20
0.001600000000000000    6.04416e20
0.001650000000000000    4.33083e20
0.001700000000000000    3.10318e20
0.001750000000000000    2.22352e20
0.001800000000000000    1.59322e20
0.001850000000000000    1.14159e20
0.001900000000000000    8.17988e19
0.001950000000000000    5.86114e19
0.002000000000000000    4.19969e19
0.002050000000000000    3.00921e19
0.002100000000000000    2.15619e19
0.002150000000000000    1.54498e19
0.002200000000000000    1.10703e19
0.002250000000000000    7.93219e18
0.002300000000000000    5.68366e18
0.002350000000000000    4.07252e18
0.002400000000000000    2.91809e18
0.002450000000000000    2.09090e18
0.002500000000000000    1.49820e18
0.002550000000000000    1.07351e18
0.002600000000000000    7.69200e17
0.002650000000000000    5.51156e17
0.002700000000000000    3.94921e17
0.002750000000000000    0.0
end
;
function7
type 0
data_pairs
0       6.7e22
5.00000000000000e-05    6.7e22
0.000100000000000000    6.7e22
0.000150000000000000    6.7e22
0.000200000000000000    6.7e22
0.000250000000000000    6.7e22
0.000300000000000000    6.7e22
0.000350000000000000    6.7e22
0.000400000000000000    6.7e22
0.000450000000000000    6.7e22
0.000500000000000000    6.7e22
0.000550000000000000    6.7e22
0.000600000000000000    6.7e22
0.000650000000000000    6.7e22
0.000700000000000000    6.7e22
0.000750000000000000    6.7e22
0.000800000000000000    6.7e22
0.000850000000000000    6.7e22
0.000900000000000000    6.7e22
0.000950000000000000    6.7e22
0.001000000000000000    6.70000e22
0.001050000000000000    4.80076e22
0.001100000000000000    3.43989e22
0.001150000000000000    2.46479e22
0.001200000000000000    1.76610e22
0.001250000000000000    1.26547e22
0.001300000000000000    9.06746e21
0.001350000000000000    6.49712e21
0.001400000000000000    4.65539e21
0.001450000000000000    3.33573e21
0.001500000000000000    2.39016e21
0.001550000000000000    1.71262e21
0.001600000000000000    1.22715e21
0.001650000000000000    8.79290e20
0.001700000000000000    6.30039e20
0.001750000000000000    4.51442e20
0.001800000000000000    3.23473e20
0.001850000000000000    2.31778e20
0.001900000000000000    1.66076e20
0.001950000000000000    1.18999e20
0.002000000000000000    8.52665e19
0.002050000000000000    6.10961e19
0.002100000000000000    4.37773e19
0.002150000000000000    3.13678e19
0.002200000000000000    2.24760e19
0.002250000000000000    1.61048e19
0.002300000000000000    1.15396e19
0.002350000000000000    8.26846e18
0.002400000000000000    5.92461e18
0.002450000000000000    4.24517e18
0.002500000000000000    3.04180e18
0.002550000000000000    2.17954e18
0.002600000000000000    1.56171e18
0.002650000000000000    1.11901e18
0.002700000000000000    8.01809e17
0.002750000000000000    0.0
end
;
;
[Probes]
;
probe1 ; ocmax1
global ocmax species 1
;
probe2 ; ocmax2
global ocmax species 2
;
probe3 ; ocmax3
global ocmax species 3
;
probe4 ; ocmax10
global ocmax species 10
;
probe5 ; ocmax11
global ocmax species 11
;
probe6 ; opmax1
global opmax species 1
;
probe7 ; opmax2
global opmax species 2
;
probe8 ; opmax3
global opmax species 3
;
probe9 ; opmax10
global opmax species 10
;
probe10 ; opmax11
global opmax species 11
;
probe11 ; number1
global number species 1
;
probe12 ; number2
global number species 2
;
probe13 ; number3
global number species 3
;
probe14 ; number10
global number species 10
;
probe15 ; number11
global number species 11
;
probe16 ; charge1
global charge species 1
;
probe17 ; charge2
global charge species 2
;
probe18 ; charge3
global charge species 3
;
probe19 ; charge10
global charge species 10
;
probe20 ; ketot1
global ketot species 1
;
probe21 ; ketot2
global ketot species 2
;
probe22 ; ketot3
global ketot species 3
;
probe23 ; ketot10
global ketot species 10
;
probe24 ; ketot11
global ketot species 11
;
probe25 ; vxtot1
global vxtot species 1
;
probe26 ; vxtot2
global vxtot species 2
;
probe27 ; vxtot3
global vxtot species 3
;
probe28 ; vxtot10
global vxtot species 10
;
probe29 ; vxtot11
global vxtot species 11
;
probe30 ; 
energy total_energy
;
probe31 ; 
energy particle_energy
;
probe32 ; 
energy field_energy
;
probe33 ; 
energy net_energy
;
probe34 ; 
energy dedx_loss
;
probe35 ; 
energy total_dedx_loss
;
probe36 ;
performance cpu_time
;

