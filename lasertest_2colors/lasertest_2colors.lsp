[Title]
simulation_title "A test of 2 colors at 1e18 W/cm^2 "
;
[Control]
;Time-advance
 time_limit 150e-6 ;
;time_limit 0.2e-6 
;number_of_steps 2
 time_step_ns 4e-8 ; >1/60th of 0.780 um light
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
 dump_fields_flag ON
 dump_scalars_flag OFF
 dump_current_density_flag OFF
 dump_number_densities_flag OFF
 dump_plasma_quantities_flag OFF
 dump_velocities_flag OFF
 ;dump_time_zero_flag ON ; dump the results of the 'zeroth' time step...does it actually start?
 extract_photons_flag OFF
 dump_particles_flag OFF
;(Diagnostic Output) Dump Intervals
 dump_interval_ns 0.2e-6
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
; particle_movie_interval_ns 0.5e-6
; particle_movie_components Q X Y Z VX VY VZ XI YI ZI
; particle_movie_components Q X Z VX VZ XI ZI
;Numerical Checks and Reports
 domain_boundary_check ON
 report_timing_flag ON
 dump_timing_flag ON
;
[Grid]
;
grid1
xmin             -10e-4
xmax              10e-4
x-cells           800
;
ymin             -20e-4
ymax              20e-4
y-cells          1600
;
[Regions]
;
region1
xmin -10e-4
xmax  10e-4

ymin -20e-4
ymax  20e-4
number_of_domains 48
split_direction XSPLIT 
number_of_cells AUTO
;
[Boundaries]
;back
;w
outlet
from -10e-4 -20e-4 0 
to   -10e-4  20e-4 0
phase_velocity 1.0
drive_model LASER
reference_point -5e-4 0 0 ; focal point position
components 0 1 0
phases 0 0 0 ; polarization
temporal_function 1
analytic_function 2
time_delay 0.0

;2w
outlet
from -10e-4 -20e-4 0 
to   -10e-4  20e-4 0
phase_velocity 1.0
drive_model LASER
reference_point 5e-4 0 0 ; focal point position
components 0 1 0
phases 0 0 0 ; polarization
temporal_function 3
analytic_function 4
time_delay 0.0

;front
outlet
from  10e-4 -20e-4 0 
to    10e-4  20e-4 0
phase_velocity 1.0
drive_model NONE
;left
outlet
from -10e-4  20e-4 0
to    10e-4  20e-4 0
phase_velocity 1.0
drive_model NONE
;right
outlet
from -10e-4 -20e-4 0
to    10e-4 -20e-4 0 
phase_velocity 1.0
drive_model NONE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function
type 30
data_file sine700points.dat
independent_variable_multiplier 30.0e-6 ; =2xFWHM,  15 fs FWHM pulse
;dependent_variable_multiplier 1.736e8  ; = Emax in kV/cm units, 1.736e8 => 4*10^19 W/cm^2
;dependent_variable_multiplier 8.68e5  ; = Emax in kV/cm units, 8.68e5 => 10^15 W/cm^2
;dependent_variable_multiplier 2.75e7  ; = Emax in kV/cm units, 2.75e7 => 10^18 W/cm^2
dependent_variable_multiplier 4.7543e7  ; 4.754e7 => 3 x 10^18 W/cm^2
;
function2 ; laser analytic function, 2w
type 19   ; \lambda spotsize
coefficients 0.78e-4 2.17e-4 end
                                        ;
function3 ; laser temporal function
type 30
data_file sine700points.dat
independent_variable_multiplier 30.0e-6 ; =2xFWHM,  30 fs FWHM pulse
;dependent_variable_multiplier 1.736e8  ; = Emax in kV/cm units, 1.736e8 => 4*10^19 W/cm^2
;dependent_variable_multiplier 8.68e5  ; = Emax in kV/cm units, 8.68e5 => 10^15 W/cm^2
;dependent_variable_multiplier 2.75e7  ; = Emax in kV/cm units, 2.75e7 => 10^18 W/cm^2
;;dependent_variable_multiplier 4.763e7  ; = Emax in kV/cm units, 4.763e7 => 3 x 10^18 W/cm^2
dependent_variable_multiplier 4.7543e7  ; 4.754e7 => 3 x 10^18 W/cm^2
;dependent_variable_multiplier 1.5035e7  ; 1.5035e7 => 3 x 10^17 W/cm^2
;
function4 ; laser analytic function, 2w
type 19   ; \lambda spotsize
coefficients 0.39e-4 2.17e-4 end


[Probes]
probe1 ; 
energy total_energy
;
probe2 ; 
energy field_energy
;
probe3 ; 
energy net_energy
;
probe4 ;
performance cpu_time
;




