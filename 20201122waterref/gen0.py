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
c = 299792458.0
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
    lim = (-11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res = (880,880,440),
    description = "tight3d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=800e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',5),('z',1)],
    domains=10*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    T = 60.0e-15,#fitted elsewhere
    l = 0.800e-4,
    w0= 1.52788e-4, #f/3
    # shifting up for the sake of focus
    fp= (1.0e-4/np.sqrt(2), 1.0e-4/np.sqrt(2), 0.0),
    multilaser=[
        dict(
            laser_tfunctype = 16,
            laser_func_type = 86,
            laser_t0        = -11e-6/c + 60e-15,
            laser_tcutoff   = 60.0e-15,
            timeshift_type  =  0.0,
            outlet='xmin',
            laser_dir = (1,0,0),
            lpmode = (0,0),
            laser_pol_type = 87,
            laser_pol= (0,1,0),
        ),
    ],
    #target
    species  = species,
    creation = creation,
    pill2_5D = dict(
        n_s  = 3.34e22,
        n_min= 1e17,
        L    = 0.040e-4,
        Lz   = 0.040e-4,
        height = 12e-4,
        length = 14e-4,
        half_width = 0.25e-4,
        rot    = 135,
        roundup_pp = True,
        roundup_lim= True,
        round_unit = 1e-4,
        xmargin    = 5e-4,
        ymargin    = 5e-4,
        zmargin    = 4e-4,
    ),
    fracs = [1,2,3],
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

pbsfmt = 'h2oref{:02}_I={:0.0e}'
def mkpbsbase(N,I): return pbsfmt.format(N,I);
descrfmt = 'Water reference with 60fs pulse, I={}'
def mkdescr(N,I): return descrfmt.format(N,I);
N    = 1
Is   = [1e19];
ds   = [ sd(d,
            pbsbase  =  mkpbsbase(N,I),
            description = mkdescr(N,I),
            I = I)
         for I   in Is ];

for d in ds:
    gensim(**d);

