;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "RC test, I = 3.000000e+18 W/cm^2"
;
[Control]
;Time-advance
 time_limit   2.000000e+00
 time_step_ns 2.000000e-05

;;Restarts
dump_restart_flag ON
rename_restart_flag ON
restart_interval 50

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


;;pmovies

;
[Grid]
;
grid1

xmin             0.000000e+00
xmax             1.100000e+00
x-cells          1100
                                        ;

ymin             0.000000e+00
ymax             5.000000e+00
y-cells          1000



[Regions]
;

;total number of domains: 88

;
region1
xmin             0.000000e+00
xmax             1.100000e+00

ymin             0.000000e+00
ymax             5.000000e+00

zmin             0.000000e+00
zmax             0.000000e+00
;
number_of_domains 88
split_direction YSPLIT
number_of_cells AUTO; 
;


;

;
[Objects]

object1 SOLID ;cathode
conductor on medium 0 potential 1

object2 BLOCK ;vacuum
conductor on medium 0 potential 0
from 1.000000e-01 -1.000000e-01 0.000000e+00
to   1.000000e+00 5.100000e+00 0.000000e+00

object3 BLOCK ;anode
conductor on medium 0 potential 2
from 1.000000e+00 -1.000000e-01 0.000000e+00
to   1.200000e+00 5.100000e+00 0.000000e+00


[Circuit Models]

circuit1
transmission-line
doubling off
segments
  length 1.0 impedance 5.0 

end
termination CHARGED
voltage 2.0
startup_time 0.0


[Boundaries]

;circuit
outlet
from 1.000000e-01 0.000000e+00 0.000000e+00
to   1.000000e+00 0.000000e+00 0.000000e+00
phase_velocity 1.0
drive_model POTENTIAL
potentials
 1 -1.0
 2  0.0
end
circuit 1

voltage_measurement
  from 1.000000e-01 0.000000e+00 0.000000e+00
  to   1.000000e+00 0.000000e+00 0.000000e+00

time_delay 0.0


;top outlet
outlet
from 1.000000e-01  5.000000e+00 0.000000e+00
to   1.000000e+00  5.000000e+00 0.000000e+00
phase_velocity 1.0
drive_model NONE




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
;;


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
;
probe6
circuit 1 element 1 voltage
