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
[Objects]
{objects}

[Boundaries]
{other_outlets}

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

function3
type 83
temporal 1
spatial 2
end

{other_funcs}

[Probes]
;
probe1
energy net_energy
;
probe2
energy field_energy
;
probe3
energy total_energy
;
probe4
performance cpu_time
