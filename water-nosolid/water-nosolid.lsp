[Title]
simulation_title "Hotwater in 3D I = 3e18 W cm-2 "
;simulation_title "Hotwater in 3D I = 5.4e17 W cm-2 "
;
[Control]
;Time-advance
 time_limit 250e-6 ;
;time_limit 0.2e-6 
;number_of_steps 2

 time_step_ns 0.10e-6 ; ~1/30th optical cycle for 1um laser light
;Restarts
 restart_interval_ns 75000e-6 ; probably much longer than max dump time
 maximum_restart_dump_time 11.5 ;in hours
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
 dump_velocities_flag OFF
 ;dump_time_zero_flag ON ; dump the results of the 'zeroth' time step...does it actually start?
 extract_photons_flag ON
 dump_particles_flag OFF
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 1e-6
 ;dump_interval_ns 0.2e-6
 dump_steps
1 
end
 spatial_skip_x 1
 spatial_skip_y 1
 spatial_skip_z 1
 probe_interval 100
;(Diagnostic Output) Formats
 photon_output_format ASCII
 target_output_format ASCII
 use_its_format_flag OFF
 print_region_flag OFF
;(Diagnostic Output) Movie Controls
 particle_movie_interval_ns 0.5e-6
 ;particle_movie_interval_ns 0.2e-6
 particle_movie_components Q X Y Z VX VY VZ XI YI ZI
;Numerical Checks and Reports
 domain_boundary_check ON
 report_timing_flag ON
 dump_timing_flag ON
;
[Grid]
;recall that 1e-4 is one um in cm
grid1 
xmin              -20e-4
xmax                5e-4
x-cells              440
dx-start    5e-6            ;5e-2 um, or \lambda/16
x-intervals
  length      20e-4 for 400
  dx-start  1.25e-5         ;1.25e-1 um
  length       5e-4 for  40
end
;
ymin             -20e-4
ymax              20e-4
y-cells          380      
dy-start      1.25e-5
y-intervals
  length         5e-4 for  40 
  dy-start    1e-5         
  length        30e-4 for 300 ;1 um, or \lambda/8
  dy-start    1.25e-5
  length         5e-4 for  40
end
;
zmin             -20e-4
zmax              20e-4
z-cells          380      
dz-start      1.25e-5
z-intervals
  length         5e-4 for  40 
  dz-start    1e-5         
  length        30e-4 for 300 ;1 um, or \lambda/8
  dz-start    1.25e-5
  length         5e-4 for  40
end

;

[Regions]
;
region1
xmin -20e-4
xmax -16e-4

ymin -20e-4
ymax  20e-4

zmin -20e-4
zmax  20e-4

number_of_domains 38
split_direction ZSPLIT 
number_of_cells AUTO
;
region2
xmin -16e-4
xmax -12e-4

ymin -20e-4
ymax  20e-4

zmin -20e-4
zmax  20e-4
;
number_of_domains 38
split_direction ZSPLIT
number_of_cells AUTO
;
region3
xmin -12e-4
xmax  -8e-4

ymin -20e-4
ymax  20e-4

zmin -20e-4
zmax  20e-4

number_of_domains 38
split_direction ZSPLIT
number_of_cells AUTO
;
region4
xmin  -8e-4
xmax  -4e-4

ymin -20e-4
ymax  20e-4

zmin -20e-4
zmax  20e-4

number_of_domains 38
split_direction ZSPLIT
number_of_cells AUTO
;
region5
xmin  -4e-4
xmax   0

ymin -20e-4
ymax  20e-4

zmin -20e-4
zmax  20e-4

number_of_domains 38
split_direction ZSPLIT
number_of_cells AUTO
;
region6
xmin   0
xmax   5e-4

ymin -20e-4
ymax  20e-4

zmin -20e-4
zmax  20e-4

number_of_domains 38
split_direction ZSPLIT
number_of_cells AUTO
;

;; total domains:
;;    32*6+6*6 = 192+36 = 248

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
;back this is the laser
outlet
from -0.0020 -0.0020 -0.0020
to   -0.0020  0.0020  0.0020
phase_velocity 1.0
drive_model LASER
reference_point 0 0 0 ; focal point position
;direction 0 0 0
;magnitude 1.0
;wavelength 0.8e-4 ; 800 nm
;spotsize 2.26e-4 ;these replace the laser analytic function
components 0 1 0 ; we need to stop this polarization along z once and for all
phases 0 0 0 ; polarization
temporal_function 1
analytic_function 2
time_delay 0.0
;front
outlet
from 0.0005 -0.0020 -0.0020
to   0.0005  0.0020  0.0020
phase_velocity 1.0
drive_model NONE
;right
outlet
from -0.0020 -0.0020 0.0020
to    0.0005  0.0020 0.0020
phase_velocity 1.0
drive_model NONE
;left
outlet
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020 -0.0020
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -0.0020 -0.0020 -0.0020
to    0.0005 -0.0020  0.0020
phase_velocity 1.0
drive_model NONE
;top
outlet
from -0.0020 0.0020 -0.0020
to    0.0005 0.0020  0.0020
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Materials]
 ;
 material oxygen
 atomic_number 8
 atomic_weight 16
 ;ionization_potential 35.1; eV
 ionization_potential 13.6; eV
 specific_heat 4.186; J/gK
 thermal_conductivity 0.0058; (W / mK)/100 

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
from -0.0020 -0.0015 -0.0015
to    0.0000  0.0015  0.0015
species 2
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 6
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000
;
plasma ; e-
from -0.0020 -0.0015 -0.0015
to    0.0000  0.0015  0.0015
species 10
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 5
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.050
;
plasma ; p
from -0.0020 -0.0015 -0.0015
to    0.0000  0.0015  0.0015
species 11
movie_tag 3
unbound off
discrete_numbers 3 3 3
density_function 7
reference_point 0 0 0
density_flags 1 0 0
momentum_flags 0 0 0
thermal_energy 1
movie_fraction 0.000

;; ionization states ;;
;
higherstate              ; O -> O+
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
from -0.0020 -0.0020 -0.0020
to    0.0005  0.0020  0.0020
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
extract1
species 10
direction X
maximum_number 1000000000
start_time 0.0
stop_time 1
at -0.0020 0 0
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
extract5
species 10
direction Y
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0 0.0020 0
;
extract6
species 10
direction Y
maximum_number 1000000000
start_time 0.0
stop_time 1
at 0 -0.0020 0
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
;dependent_variable_multiplier 2.02e7  ; = Emax in kV/cm units, 2.02e7 => 3 x 5.4^17 W/cm^2

function2 ;laser analytic function for lsp v10
type 19   ; \lambda spotsize
coefficients 0.8e-4 2.26e-4 end
;coefficients 0.8e-4 2.174e-4 end

;function3 ; Oxygen number dens
;type 1
;coefficients 3.33E+22 end 
;
;function4 ; Electron number dens
;type 1
;coefficients 1.00E+23 end 
;
;function5 ; proton number dens
;type 1
;coefficients 6.67e+22 end 
;
function5 ; kinetic electrons
type 30
data_file watercolumn.dat
dependent_variable_multiplier 1.0
;;
function6 ; Oxygen
type 30
data_file watercolumn.dat
dependent_variable_multiplier 0.33
;;
function7 ; Protons
type 30
data_file watercolumn.dat
dependent_variable_multiplier 0.67

[Probes]
;
probe1
point E X 
at -0.0020 0 0

probe2 ; 
point E Y 
at -0.0020 0 0 
;             
probe3 ;     
point E Z   
at -0.0020 0 0
;            
probe4 ;    
point B X  
at -0.0020 0 0 
;             
probe5 ;     
point B Y   
at -0.0020 0 0
                    
probe6 ;           
point B Z         
at -0.0020 0 0   
                
probe7         
performance cpu_time
;                  
probe8            
energy net_energy    
