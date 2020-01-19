;;;
;; this includes most correct masses for water
;; and better selection ratios
[Title]
simulation_title "{description}, I = {intensity:e} W/cm^2"
;
[Control]
;Time-advance
 time_limit   {totaltime:e}
 time_step_ns {timestep:e}

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

[Circuit Models]
{circuits}

[Boundaries]
{other_boundaries}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[Functions]
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
;
probe6
circuit 1 element 1 voltage
