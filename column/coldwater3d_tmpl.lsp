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
xmin             {xmin:e}
xmax             {xmax:e}
x-cells          {xcells}
                                        ;
{ygrid}

{zgrid}

[Regions]
;

;total number of domains: {domains}

{regions}

;
;
[Boundaries]
{other_outlets}

;;;;;;;;;;;;;;;;
;; species
;;;;;;;;;;;;;;;;
[Particle Species]
species1 ; neutral O
charge 0
mass 29165
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
mass 29164
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
mass 29163
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
mass 29162
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
mass 29161
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
mass 29160
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
mass 29159
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
mass 29158
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
mass 29157
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
selection_ratio 1.0
;
species12 ; H
charge 0
mass 1837
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

plasma ; O
from {targ_xmin:e}  {targ_ymin:e}  {targ_zmin:e}
to   {targ_xmax:e}  {targ_ymax:e}  {targ_zmax:e}
species 1
movie_tag 3
unbound off
discrete_numbers {discrete}
density_function 4
reference_point {targrefx:e} {targrefy:e} {targrefz:e}
density_flags {dens_flags}
momentum_flags 0 0 0
{O_thermalopts}
movie_fraction 0.000
;
plasma ; H
from {targ_xmin:e} {targ_ymin:e}  {targ_zmin:e}
to   {targ_xmax:e} {targ_ymax:e}  {targ_zmax:e}
species 12
movie_tag 3
unbound off
discrete_numbers {discrete}
density_function 5
reference_point {targrefx:e} {targrefy:e} {targrefz:e}
density_flags {dens_flags}
momentum_flags 0 0 0
{p_thermalopts}
movie_fraction 0.000

;; ionization states ;;
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
;
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
function1 ; laser temporal function
type 30
data_file sine700points.dat
;; pulse duration length, 2xFWHM
independent_variable_multiplier {pulse:e}
;; Emax, intensity={intensity:e} W/cm^2
dependent_variable_multiplier   {E0:e}

function2 ;laser analytic function for lsp v10
type 19   ; f-number: ~{fnum}
          ; \lambda spotsize
coefficients {l:e} {w0:e} end

;;
function3 ; electrons
{n_e}
;;
function4 ; Oxygen
{n_O}
;;
function5 ; Protons
{n_p}
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
performance cpu_time
