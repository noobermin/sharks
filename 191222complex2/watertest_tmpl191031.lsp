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
;;;;
;; PRIMARY SPECIES
;;;;
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
;;;;
;; AVERAGED SPECIES
;;;;
species13 ; neutral O
charge 0
mass 29164.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species14 ; O+
charge +1
mass 29163.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species15 ; O++
charge +2
mass 29162.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species16 ; O 3+
charge +3
mass 29161.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species17 ; O 4+
charge +4
mass 29160.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species18 ; O 5+
charge +5
mass 29159.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species19 ; O 6+
charge +6
mass 29158.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species20 ; O 7+
charge +7
mass 29157.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species21 ; O 8+
charge +8
mass 29156.4
atomic_number 8
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species22 ; kinetic electrons
charge -1
mass 1.0
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag on
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species23 ; protons
charge +1
mass 1836.2
atomic_number 1
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
transverse_weighting_flag on
particle_kinematics_option STANDARD
scattering_flag off
implicit_filtering_parameter 0.1
selection_ratio 1.0
;
species24 ; H atom
charge 0
mass 1837.4
atomic_number 1
migrant_species_flag off
implicit_species_flag on
particle_motion_flag on
particle_forces_option AVERAGED
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
;
plasma ; p+
from {pp_xmin:e} {pp_ymin:e}  {pp_zmin:e}
to   {pp_xmax:e} {pp_ymax:e}  {pp_zmax:e}
species 11
movie_tag 3
unbound off
discrete_numbers {pp_discrete}
density_function 1
reference_point {pp_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{pp_thermalopts}
movie_fraction 0.000
;
plasma ; O+
from {Op_xmin:e}  {Op_ymin:e}  {Op_zmin:e}
to   {Op_xmax:e}  {Op_ymax:e}  {Op_zmax:e}
species 2
movie_tag 3
unbound off
discrete_numbers {Op_discrete}
density_function 2
reference_point {Op_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{Op_thermalopts}
movie_fraction 0.000
;
plasma ; e-
from {ep_xmin:e}  {ep_ymin:e}  {ep_zmin:e}
to   {ep_xmax:e}  {ep_ymax:e}  {ep_zmax:e}
species 10
movie_tag 3
unbound off
discrete_numbers {ep_discrete}
density_function 3
reference_point {ep_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{ep_thermalopts}
movie_fraction 0.000
;;
; average
;;
plasma ; p+
from {pa_xmin:e} {pa_ymin:e}  {pa_zmin:e}
to   {pa_xmax:e} {pa_ymax:e}  {pa_zmax:e}
species 11
movie_tag 3
unbound off
discrete_numbers {pa_discrete}
density_function 4
reference_point {pa_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{pa_thermalopts}
movie_fraction 0.000
;
plasma ; O+
from {Oa_xmin:e}  {Oa_ymin:e}  {Oa_zmin:e}
to   {Oa_xmax:e}  {Oa_ymax:e}  {Oa_zmax:e}
species 2
movie_tag 3
unbound off
discrete_numbers {Oa_discrete}
density_function 5
reference_point {Oa_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{Oa_thermalopts}
movie_fraction 0.000
;
plasma ; e-
from {ea_xmin:e}  {ea_ymin:e}  {ea_zmin:e}
to   {ea_xmax:e}  {ea_ymax:e}  {ea_zmax:e}
species 10
movie_tag 3
unbound off
discrete_numbers {ea_discrete}
density_function 6
reference_point {ea_targref}
density_flags {dens_flags}
momentum_flags {gb_flags}
{ea_thermalopts}
movie_fraction 0.000
;

;; ionization states ;;
;;
; primary
;;
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

;;
; averaged
;;
higherstate              ; H -> p+
from {xmin:e} {ymin:e}  {zmin:e}
to   {xmax:e} {ymax:e}  {zmax:e}
interval 1
species 24
ion_species 23
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
species 13
ion_species 14
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
species 14
ion_species 15
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
species 15
ion_species 16
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
species 16
ion_species 17
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
species 17
ion_species 18
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
species 18
ion_species 19
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
species 19
ion_species 20
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
species 20
ion_species 21
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
;;
function1 ; p+ primary
{n_pp}
;;
function2 ; O+ primary
{n_Op}
;
function3 ; e- primary
{n_ep}
;;
function4 ; p+ averaged
{n_pa}
;;
function5 ; O+ averaged
{n_Oa}
;;
function6 ; e- averaged
{n_ea}
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

