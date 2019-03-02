;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "{description}, I = {intensity:e} W/cm^2"
;
[Control]
;Time-advance
 time_limit   {totaltime:0.4e}
 time_step_ns {timestep:0.4e}

{options}
;;pmovies
{pmovies}
;
[Grid]
;
grid1
{xgrid}
                                        ;
{ygrid}

{zgrid}

[Regions]
;

;total number of domains: {domains}

{regions}

;

;
[Objects]
{objects}

[Boundaries]
{other_boundaries}

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
from {e_xmin:e} {e_ymin:e}  {e_zmin:e}
to   {e_xmax:e} {e_ymax:e}  {e_zmax:e}
species 10
movie_tag 5
unbound off
discrete_numbers {discrete}
density_function 5
reference_point {e_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{e_thermalopts}
movie_fraction 0.050
;
plasma ; p+
from {p_xmin:e} {p_ymin:e}  {p_zmin:e}
to   {p_xmax:e} {p_ymax:e}  {p_zmax:e}
species 11
movie_tag 3
unbound off
discrete_numbers {p_discrete}
density_function 6
reference_point {p_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{p_thermalopts}
movie_fraction 0.000
;
plasma ; O+
from {O+_xmin:e}  {O+_ymin:e}  {O+_zmin:e}
to   {O+_xmax:e}  {O+_ymax:e}  {O+_zmax:e}
species 2
movie_tag 3
unbound off
discrete_numbers {O+_discrete}
density_function 7
reference_point {O+_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{O+_thermalopts}
movie_fraction 0.000
;

;; emission from conductors
emission child-langmuir field-stress
from {xmin:e} {ymin:e} {zmin:e}
to   {xmax:e} {ymax:e} {zmax:e}
interval 1
species 10
discrete_numbers {discrete}
inclusion SOLID
thermal_energy {cond_temp}
movie_fraction {cond_fraction}
;; ionization states ;;
higherstate              ; H -> p+
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
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
;;at {xmin:e} 0 0
;
;;extract2
;;species 10
;;direction X
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at {xmax:e} 0 0
;
;;extract3
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 {ymax:e} 0
;
;;extract4
;;species 10
;;direction Y
;;maximum_number 1000000000
;;start_time 0.0
;;stop_time 1
;;at 0 {ymin:e} 0
;
{pexts}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
function1 ; laser temporal function, sine squared
type 23   ; requires new modifications
coefficients {E0:e} {t0:e} {pulse:e} end

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~{fnum}
          ; \lambda spotsize
coefficients {l:e} {w0:e} end

function3 ; laser polarization function
type 87
coefficients {laser_polarization} end

function4 ; laser
type 86
laser
temporal_function 1
polarization_function 3
wavelength {l:e}
spotsize {w0:e}
lp_mode {lpmode}
direction {laser_direction}
focal_point {fp}
end

;;
function5 ; electrons
{n_e}
;;
function6 ; Protons
{n_p}
;;
function7 ; Oxygen
{n_O+}
;;

{other_funcs}

[Probes]
;
probe1
energy net_energy
;
probe2
energy total_energy
;
probe3
energy particle_energy
;
probe4
energy field_energy
;
probe5
performance cpu_time
