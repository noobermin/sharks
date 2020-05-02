#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt, sdl;
from genlsp import gensim;
from genlsp.genlsp import mkregion_str;

import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
#E = 0.5e-3; # 5mJ

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-5),BfromI(I*2)))

from genlsp.h2o_species import h2o_species_explicit as h2o_species;
from genlsp.h2o_species import h2o_creation_plasma_single, h2o_creation_other;
discrete=(4,4,1)
species = h2o_species;
plasmacs = sdl(h2o_creation_plasma_single,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 1.0);
creation = plasmacs + h2o_creation_other;

###########
d=dict(
    dens_flags=(True,False,False),
    lim = (-20.0e-4, 6.4e-4,
           -13.2e-4,13.2e-4,
           -0,0),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -0, 0),
    res = (1056, 1056, 0),
    description = "regions test",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    totaltime=200e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    #units
    ux=1.0,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 86,
            outlet='xmin',
            laser_dir = (1,0,0),
            lpmode = (0,0),
            laser_pol_type = 87,
            laser_pol= (0,1,0),
        )],
    laser_t0 = -20e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.8e-4,
    w0= 2*0.8e-4*2/np.pi,#F/2
    fp = (0.0,0.0,0.0),
    I = 5e18,
    T = 60e-15,
    #target
    pbsbase = 'part2dtest0',
    species = species,
    new_create=True,
    creation= creation,
    #scale
    fracs = [1,2,3],
    two_scales=True,
    n_s = 3.34e22,
    n_bmin = 1e16,
    n_fmin = 1e16,
    solid_len=1.0e-4,
    Lf = 75e-7,
    Lb = 50e-7,
    keep_lims = True,
    #probes
    probes = [
        dict(type = 'energy',
             measurement_type = 'net_energy'),
        dict(type = 'energy',
             measurement_type = 'total_energy'),
        dict(type = 'energy',
             measurement_type = 'particle_energy'),
        dict(type = 'energy',
             measurement_type = 'field_energy'),
        dict(type = 'performance',
             measurement_type = 'cpu_time')],
    #misc
    no_loopscript = True,
);

regions = [
    dict(lim = (-20.0e-4,-2.4e-4, -13.2e-4, 13.2e-4, 0, 0)),
    dict(lim = ( -2.4e-4, 6.4e-4, -13.2e-4, -4.4e-4, 0, 0)),
    dict(lim = ( -2.4e-4, 6.4e-4,  -4.4e-4,  4.4e-4, 0, 0)),
    dict(lim = ( -2.4e-4, 6.4e-4,   4.4e-4, 13.2e-4, 0, 0))];
def mkregionarg(reg,i):
    lim = reg['lim'];
    return sd(reg,
              xmin = lim[0], xmax = lim[1],
              ymin = lim[2], ymax = lim[3],
              zmin = lim[4], zmax = lim[5],
              i = i,
              domains = 44,
              split= 'YSPLIT',);
regions = [ mkregionarg(reg,i+1)
            for i,reg in enumerate(regions) ];
print(regions);
d['domains'] = 44*len(regions);
d['regions'] = mkregion_str(regions);
gensim(**d);
