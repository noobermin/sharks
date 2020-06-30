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
    dens_flags=(True,False,False),
    lim = (-11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4,
           0e-4,0e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           0e-4,0e-4),
    res = (440, 440, 0),
    description = "does it work with 2D?",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-2d',
    dir=True,
    totaltime=160e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='x',
    region_splits = [('x',2),('y',2)],
    domains=4*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'gauss2D_EyR.dat',
                type= 60,),
            Ey_imag   = dict(
                dat = 'gauss2D_EyI.dat',
                type= 60,),
        ),
    ],
    l = 0.8e-4,
    I = 1e19,
    laser_t0 = 40e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    fp = (0.0,0.0,0.0),
    T = 60e-15,
    #target
    no_matter = True,
    #misc
    pbsbase = 'oeog01',
    species = species,
    new_create=True,
    creation= creation,
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
gensim(**d);

d3d=sd(
    d,
    dens_flags=(True,False,False),
    lim = (-11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4),
    tlim=( -2.0e-4, 2.0e-4,
           -5.0e-4, 5.0e-4,
           -5.0e-4, 5.0e-4),
    res = (440, 440, 440),
    description = "does it work with 3D?",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'gauss3D_EyR.dat',
                type= 60,),
            Ey_imag   = dict(
                dat = 'gauss3D_EyI.dat',
                type= 60,),
        ),
    ],
    pbsbase = 'oeog02',
);
gensim(**d3d);

d1=sd(
    d,
    totaltime=160e-15,
    multilaser=None,
    new_multilaser=False,
    w0 = 3.0*d['l']/(np.pi/2.0),
    pbsbase='reog01');
gensim(**d1);
