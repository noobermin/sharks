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

import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
c_cgs = 29979245800.0
#E = 0.5e-3; # 5mJ

from genlsp.h2o_species import h2o_species_explicit as h2o_species;
from genlsp.h2o_species import h2o_creation_plasma_single, h2o_creation_other;
discrete=(3,3,1)
species = h2o_species;
plasmacs = sdl(h2o_creation_plasma_single,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 1.0);
creation = plasmacs + h2o_creation_other;

###########
d = dict(
    dens_flags=(True,False,False),
    lim = (-13.2e-4,13.2e-4,
           -13.2e-4,13.2e-4,
             0.0e-4, 0.0e-4),
    tlim=( -4.0e-4, 4.0e-4,
           -9.0e-4, 9.0e-4,
            0.0e-4, 0.0e-4),
    res = (660, 660, 0),
    description = "attempt to use nour's stuff",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    totaltime=200e-15,
    timestep =5e-17,
    restart_interval=None,
    restart_interval_ns = 1e-15,
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
            laser_func_type = 85,
            outlet='xmin',
            laser_dir = (1,0,0),
            lpmode = (0,0),
            laser_pol_type = 87,
            laser_pol= (0,1,0),
        )],
    I = 1e19,
    T = 2.877e-15,#fitted elsewhere
    laser_t0 = 0e-15,
    laser_tfunctype=16,
    laser_tcutoff = 10e-15,
    l = 0.710e-4,
    w0= 1.05e-4,
    fp = (0.0,0.0,0.0),
    #target
    species=species,
    no_matter = True,
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
    #pext
    pext_species=(12,),
    #computational division
    region_dom_split='x',
    domains = 44,
);
pbsfmt = 'tight{:02}_p={:0.2f}_I={:0.0e}'
def mkpbsbase(N,phi,I): return pbsfmt.format(N,phi,I);
descrfmt = 'Tight, phase={}, I={}'
def mkdescr(N,phi,I): return descrfmt.format(N,phi,I);

phis = [0.0,0.25,0.5,0.75,1.0];
Is   = [1e19];
ds   = [ sd(d,
            pbsbase  =  mkpbsbase(0,phi,I),
            description = mkdescr(0,phi,I),
            I = I,
            phase = phi)
         for phi in phis
         for I   in Is ];
for di in ds:
    gensim(**di);

