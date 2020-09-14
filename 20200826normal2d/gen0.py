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
#E = 0.5e-3; # 5mJ

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-5),BfromI(I*2)))

from genlsp.h_species import h_species_explicit as h_species;
from genlsp.h_species import h_creation_plasma, h_creation_other, h_creation_neutral
discrete=(3,3,1)
species = h_species;
plasmacs = sdl(h_creation_neutral,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 1.0);
creation = plasmacs + h_creation_other;

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
    laser_t0 = -20e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.8e-4,
    w0= 2*0.8e-4*2/np.pi,#F/2
    fp = (0.0,0.0,0.0),
    I = 1e19,
    T = 60e-15,
    #target
    pill2D  = True,
    L       = 0.3e-4,
    n_s   = 1e23,
    n_min = np.exp(-3.6/0.3)*1e23,
    length = 10e-4,
    trans_margin = 4.2e-4,
    long_margin  = 9.2e-4,
    species = species,
    new_create=True,
    creation= creation,
    fracs = [1],
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
    #pext
    pext_species=(3,),
    #computational division
    region_dom_split='x',
    domains = 44,
    pbsbase = 'pill2d_00',
);

gensim(**d);
