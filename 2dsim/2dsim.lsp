[Title]
simulation_title "Hotwater in 2d I = 3e18 W cm-2 "
;
[Control]
;Time-advance
time_limit 60e-6 ;
;time_limit 200e-6 ;
;time_limit 0.2e-6 
;number_of_steps 2

 time_step_ns 0.10e-6 ; 1/30th optical cycle for 1um laser light
;Restarts
 restart_interval_ns 75e-6 ; probably much longer than max dump time
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
 ;dump_time_zero_flag ON ; dump the results of the 'zeroth' time step...does it actually start?
 extract_photons_flag ON
 dump_particles_flag OFF
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 0.1e-6
 dump_steps
1 
end
 spatial_skip_x 1
; spatial_skip_y 1
 spatial_skip_z 1
 probe_interval 1
;(Diagnostic Output) Formats
 photon_output_format ASCII
 target_output_format ASCII
 use_its_format_flag OFF
 print_region_flag OFF
;(Diagnostic Output) Movie Controls
 particle_movie_interval_ns 0.5e-6
;particle_movie_components Q X Y Z VX VY VZ XI YI ZI
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
xmax              0.0005
x-cells           700
;
zmin             -0.0020
zmax              0.0020
z-cells           400
;
[Regions]
;
region1
xmin -0.0030
xmax  0.0005

zmin -0.0020
zmax  0.0020

number_of_domains 48
split_direction ZSPLIT ;split into planes instead of lines
number_of_cells AUTO
;

;
[Boundaries]
;back this is the laser
outlet
from -0.0030  0 -0.0020
to   -0.0030  0  0.0020
phase_velocity 1.0
drive_model LASER
reference_point 0 0 0 ; focal point position
direction 1 0 0
magnitude 1.0
wavelength 0.8e-4 ; 800 nm
spotsize 2.26e-4 ;these replace the laser analytic function
components 0 0 1
phases 0 0 0 ; polarization
temporal_function 1
time_delay 0
;time_delay 98.807e-6
;front
outlet
from  0.0005  0 -0.0020
to    0.0005  0  0.0020
phase_velocity 1.0
drive_model NONE
;top
outlet
from -0.0030  0 0.0020
to    0.0005  0 0.0020
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -0.0030  0 -0.0020
to    0.0005  0 -0.0020
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
from -0.0030  0 -0.0015
to    0.0000  0  0.0015
species 2
movie_tag 3
unbound off
discrete_numbers 7 7 7
density_function 3
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
plasma ; e-
from -0.0030  0 -0.0015
to    0.0000  0  0.0015
species 10
movie_tag 3
unbound off
discrete_numbers 7 7 7
density_function 2
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.050
;
plasma ; p
from -0.0030  0 -0.0015
to    0.0000  0  0.0015
species 11
movie_tag 3
unbound off
discrete_numbers 7 7 7
density_function 4
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000

;; ionization states ;;
;
higherstate              ; O -> O+
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 1
ion_species 2
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 2
ion_species 3
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 3
ion_species 4
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 4
ion_species 5
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 5
ion_species 6
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 6
ion_species 7
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 7
ion_species 8
movie_tag 5
electron_species 10
;movie_tag 3
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
from -0.0030  0 -0.0020
to    0.0005  0  0.0020
interval 1
species 8
ion_species 9
movie_tag 5
electron_species 10
;movie_tag 3
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
at 0.0005 0 0
;
extract3
species 10
direction Z
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0 0 0.0020
;
extract4
species 10
direction Z
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0 0 -0.0020
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
independent_variable_multiplier 60.0e-6 ; =2xFWHM,  30 fs FWHM pulse
;dependent_variable_multiplier 1.736e8  ; = Emax in kV/cm units, 1.736e8 => 4*10^19 W/cm^2
;dependent_variable_multiplier 8.68e5  ; = Emax in kV/cm units, 8.68e5 => 10^15 W/cm^2
;dependent_variable_multiplier 2.75e7  ; = Emax in kV/cm units, 2.75e7 => 10^18 W/cm^2
dependent_variable_multiplier 4.763e7  ; = Emax in kV/cm units, 4.763e7 => 3 x 10^18 W/cm^2

function 2
type 0
data_pairs
-0.00275   0.0
-0.00270   1.19673e18
-0.00265   1.67017e18
-0.00260   2.33091e18
-0.00255   3.25305e18
-0.00250   4.53999e18
-0.00245   6.33607e18
-0.00240   8.84270e18
-0.00235   1.23410e19
-0.00230   1.72232e19
-0.00225   2.40369e19
-0.00220   3.35463e19
-0.00215   4.68176e19
-0.00210   6.53392e19
-0.00205   9.11882e19
-0.00200   1.27263e20
-0.00195   1.77610e20
-0.00190   2.47875e20
-0.00185   3.45938e20
-0.00180   4.82795e20
-0.00175   6.73795e20
-0.00170   9.40356e20
-0.00165   1.31237e21
-0.00160   1.83156e21
-0.00155   2.55615e21
-0.00150   3.56740e21
-0.00145   4.97871e21
-0.00140   6.94835e21
-0.00135   9.69720e21
-0.00130   1.35335e22
-0.00125   1.88876e22
-0.00120   2.63597e22
-0.00115   3.67879e22
-0.00110   5.13417e22
-0.00105   7.16531e22
-0.00100   1.0e23
-0.00095   1.0e23
-0.00090   1.0e23
-0.00085   1.0e23
-0.00080   1.0e23
-0.00075   1.0e23
-0.00070   1.0e23
-0.00065   1.0e23
-0.00060   1.0e23
-0.00055   1.0e23
-0.00050   1.0e23
-0.00045   1.0e23
-0.00040   1.0e23
-0.00035   1.0e23
-0.00030   1.0e23
-0.00025   1.0e23
-0.00020   1.0e23
-0.00015   1.0e23
-0.00010   1.0e23
-0.00005   1.0e23
0          1.0e23
end
;
function 3
type 0
data_pairs
-0.00275   0.0
-0.00270   3.94921e17
-0.00265   5.51156e17
-0.00260   7.69200e17
-0.00255   1.07351e18
-0.00250   1.49820e18
-0.00245   2.09090e18
-0.00240   2.91809e18
-0.00235   4.07252e18
-0.00230   5.68366e18
-0.00225   7.93219e18
-0.00220   1.10703e19
-0.00215   1.54498e19
-0.00210   2.15619e19
-0.00205   3.00921e19
-0.00200   4.19969e19
-0.00195   5.86114e19
-0.00190   8.17988e19
-0.00185   1.14159e20
-0.00180   1.59322e20
-0.00175   2.22352e20
-0.00170   3.10318e20
-0.00165   4.33083e20
-0.00160   6.04416e20
-0.00155   8.43531e20
-0.00150   1.17724e21
-0.00145   1.64297e21
-0.00140   2.29295e21
-0.00135   3.20007e21
-0.00130   4.46606e21
-0.00125   6.23289e21
-0.00120   8.69871e21
-0.00115   1.21400e22
-0.00110   1.69428e22
-0.00105   2.36455e22
-0.00100   3.30000e22
-0.00095   3.3e22
-0.00090   3.3e22
-0.00085   3.3e22
-0.00080   3.3e22
-0.00075   3.3e22
-0.00070   3.3e22
-0.00065   3.3e22
-0.00060   3.3e22
-0.00055   3.3e22
-0.00050   3.3e22
-0.00045   3.3e22
-0.00040   3.3e22
-0.00035   3.3e22
-0.00030   3.3e22
-0.00025   3.3e22
-0.00020   3.3e22
-0.00015   3.3e22
-0.00010   3.3e22
-0.00005   3.3e22
0          3.3e22
end
;
function 4
type 0
data_pairs
-0.00275   0.0
-0.00270   8.01809e17
-0.00265   1.11901e18
-0.00260   1.56171e18
-0.00255   2.17954e18
-0.00250   3.04180e18
-0.00245   4.24517e18
-0.00240   5.92461e18
-0.00235   8.26846e18
-0.00230   1.15396e19
-0.00225   1.61048e19
-0.00220   2.24760e19
-0.00215   3.13678e19
-0.00210   4.37773e19
-0.00205   6.10961e19
-0.00200   8.52665e19
-0.00195   1.18999e20
-0.00190   1.66076e20
-0.00185   2.31778e20
-0.00180   3.23473e20
-0.00175   4.51442e20
-0.00170   6.30039e20
-0.00165   8.79290e20
-0.00160   1.22715e21
-0.00155   1.71262e21
-0.00150   2.39016e21
-0.00145   3.33573e21
-0.00140   4.65539e21
-0.00135   6.49712e21
-0.00130   9.06746e21
-0.00125   1.26547e22
-0.00120   1.76610e22
-0.00115   2.46479e22
-0.00110   3.43989e22
-0.00105   4.80076e22
-0.00100   6.70000e22
-0.00095   6.7e22
-0.00090   6.7e22
-0.00085   6.7e22
-0.00080   6.7e22
-0.00075   6.7e22
-0.00070   6.7e22
-0.00065   6.7e22
-0.00060   6.7e22
-0.00055   6.7e22
-0.00050   6.7e22
-0.00045   6.7e22
-0.00040   6.7e22
-0.00035   6.7e22
-0.00030   6.7e22
-0.00025   6.7e22
-0.00020   6.7e22
-0.00015   6.7e22
-0.00010   6.7e22
-0.00005   6.7e22
0          6.7e22
end

;
[Probes]
probe1 ; number1
global number species 1
;
probe2 ; number2
global number species 2
;
probe3 ; number3
global number species 3
;
probe4 ; number10
global number species 10
;
probe5 ; number11
global number species 11
;
probe6 ; charge1
global charge species 1
;
probe7 ; charge2
global charge species 2
;
probe8 ; charge3
global charge species 3
;
probe9 ; charge10
global charge species 10
;
probe10 ; ketot1
global ketot species 1
;
probe11 ; ketot2
global ketot species 2
;
probe12 ; ketot3
global ketot species 3
;
probe13 ; ketot10
global ketot species 10
;
probe14 ; ketot11
global ketot species 11
;
probe15 ; vxtot1
global vxtot species 1
;
probe16 ; vxtot2
global vxtot species 2
;
probe17 ; vxtot3
global vxtot species 3
;
probe18 ; vxtot10
global vxtot species 10
;
probe19 ; vxtot11
global vxtot species 11
;
probe20 ; 
energy total_energy
;
probe21 ; 
energy particle_energy
;
probe22 ; 
energy field_energy
;
probe23 ; 
energy net_energy
;
probe24 ; 
energy dedx_loss
;
probe25 ; 
energy total_dedx_loss
;
probe26 ;
performance cpu_time
;

