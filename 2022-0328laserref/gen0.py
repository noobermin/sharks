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
from genlsp.genlsp import ItoE;
import noobna as nbna;

import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
c_cgs = 29979245800.0
#E = 0.5e-3; # 5mJ

from genlsp.h2o_species import h2o_species_explicit as h2o_species;
from genlsp.h2o_species import h2o_creation_plasma_single, h2o_creation_other;
discrete=(2,2,2)
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
    dens_flags=(True,True,True),
    lim = ( -30.0e-4, 30.0e-4,
            -20.0e-4, 20.0e-4,
                 0.0, 0.0),
    tlim=(  -1.0e-4, 1.0e-4,
            -1.0e-4, 1.0e-4,
                0.0, 0.0),
    res = (2400,1600,0),
    description = "tight2d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-2d',
    dir=True,
    totaltime=360e-15,
    timestep = 50e-18,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='x',
    region_splits = [('x',1),('y',1),('z',1)],
    domains=1*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    # shifting up for the sake of focus
    fp= (0.0, 0.0, 0.0),
    multilaser=[
        dict(
            T = 60.0e-15,
            l = 0.80e-4,
            w0= 1.5278875e-4, # f/3
            laser_tfunctype = 16,
            laser_func_type = 85,
            laser_t0        =  -25.0e-4/c_cgs + 90.0e-15,
            laser_tcutoff   =  90e-15,
            outlet='xmin',
            lpmode = (0,0),
            laser_pol      = (0,1,0),
            laser_dir      = (1,0,0),
            laser_pol_type = 87,
        ),
    ],
    #target
    species  = species,
    no_matter= True,
    creation = [],
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
);

pbsfmt = 'lasref_2022_{:02}_I={:0.0e}'
def mkpbsbase(N,I): return pbsfmt.format(N,I);
descrfmt = '2d laser pulse simulation, I={}'
def mkdescr(N,I): return descrfmt.format(N,I);
N    = 0
Is   = [1e19];
ds   = [ sd(d,
            pbsbase  =  mkpbsbase(N,I),
            description = mkdescr(N,I))
         for I     in Is ];

for d in ds:
    gensim(**d);

