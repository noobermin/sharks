[Title]
simulation_title "Cheap Laser in 3D I = 1e18 W cm-2 "
;
[Control]
;Time-advance
;time_limit 1e-6 ;
 time_limit 100e-6 
;number_of_steps 2
 time_step_ns 0.10e-6 ; 1/30th optical cycle for 1um laser light
;Restarts
 restart_interval_ns 200e-6 ; so that we don't restart.
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
 dump_fields_flag OFF
 dump_number_densities_flag OFF
 dump_plasma_quantities_flag OFF
 dump_velocities_flag OFF
 extract_photons_flag ON
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 1e-6
 dump_steps
1 
end
 spatial_skip_x 1
 spatial_skip_y 1
 spatial_skip_z 1
 probe_interval 1
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
xmax             -0.0025
x-cells           50
;
ymin             -0.0001
ymax              0.0001
y-cells           4
;
zmin             -0.0001
zmax              0.0001
z-cells           4
;

[Regions]
;
region1
xmin -0.0030
xmax -0.0025
ymin -0.0001
ymax  0.0001
zmin -0.0001
zmax  0.0001
number_of_domains 5
split_direction XSPLIT 
number_of_cells AUTO

;; Old Grid
;; [Grid]
;; ;
;; grid1
;; xmin             -0.0030
;; xmax              0.0030
;; x-cells           200
;; ;
;; ymin             -0.0030
;; ymax              0.0030
;; y-cells           200
;; ;
;; zmin             -0.0030
;; zmax              0.0030
;; z-cells           200
;; ;
;; [Regions]
;; ;
;; region1
;; xmin -0.0030
;; xmax  0.0030
;; ymin -0.0030
;; ymax  0.0030
;; zmin -0.0030
;; zmax  0.0030
;; number_of_domains 48 
;; split_direction ZSPLIT ;split into planes instead of lines
;; number_of_cells AUTO

[Boundaries]
;back
outlet
from -0.003 -0.0001 -0.0001
to   -0.003  0.0001  0.0001
phase_velocity 1.0
drive_model LASER
reference_point 0 0 0
direction 1 0 0
magnitude 1.0
wavelength 0.8e-4 ; 800 nm
spotsize 2.26e-4 ;these replace the laser analytic function
components 0 0 1
phases 0 0 0 ; polarization
temporal_function 1
time_delay 98.807e-6
;analytic_function 2
;time_delay 0.0


;front
outlet
from -0.0025 -0.0001 -0.0001
to   -0.0025  0.0001  0.0001
phase_velocity 1.0
drive_model NONE
;top
outlet
from -0.003  -0.0001  0.0001
to   -0.0025  0.0001  0.0001
phase_velocity 1.0
drive_model NONE
;bottom
outlet
from -0.003  -0.0001 -0.0001
to   -0.0025  0.0001 -0.0001
phase_velocity 1.0
drive_model NONE
;right
outlet
from -0.003  -0.0001 -0.0001
to   -0.0025 -0.0001  0.0001
phase_velocity 1.0
drive_model NONE
;right
outlet
from -0.003   0.0001 -0.0001
to   -0.0025  0.0001  0.0001
phase_velocity 1.0
drive_model NONE
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

;
;function2 ; laser analytic function
;type 19
;coefficients 0.8e-4 2.26e-4 end
;

;
function3 ; laser analytic function
type 1
coefficients 2.75e7 end
;

[Probes]

probe1 ;
energy field_energy

probe2
performance cpu_time

;field point probes

probe3
point E X
at -0.0030 0 0

probe4
point E Y
at -0.0030 0 0

probe5
point E Z
at -0.0030 0 0

