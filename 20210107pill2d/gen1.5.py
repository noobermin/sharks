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
c = 299792458
#E = 0.5e-3; # 5mJ

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
    dens_flags=(True,True,False),
    lim = ( -8.8e-4,  8.8e-4,
           -11.0e-4, 11.0e-4,
             0.0e-4,  0.0e-4),
    tlim=( -2.0e-4, 2.0e-4,
           -8.0e-4, 8.0e-4,
           -0.0e-4, 0.0e-4),
    res = (1760,2200,0),
    description = "tight3d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=100e-15,
    timestep = 20e-18,
    restart_interval=50,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',1),('z',1)],
    domains=2*40,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    T = 7e-15,#fitted elsewhere
    l = 0.710e-4,
    w0= 1.05e-4,
    fp= (0.0, 0.0, 0.0),
    multilaser=[
        dict(
            laser_tfunctype = 16,
            laser_func_type = 85,
            laser_t0        = -8.8e-6/c + 10.5e-15,
            laser_tcutoff   =  10.5e-15,
            timeshift_type  =   2.0,
            outlet='xmin',
            lpmode = (0,0),
            laser_pol_type = 87,
            laser_pol= (0,1,0),
        ),
    ],
    #target
    species  = species,
    creation = creation,
    no_matter = True,
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
    pext_species=(11,12),

);

pbsfmt = 'spill2d_nomatter{:02}_p={:0.2f}_I={:0.0e}_angle={:02}'
def mkpbsbase(N,phi,I,angle): return pbsfmt.format(N,phi,I,angle);
descrfmt = '2D target, near normal, phase={}, I={}'
def mkdescr(N,phi,I,angle): return descrfmt.format(N,phi,I,angle);
N     = 1
phis  = [0.0,0.5];
angles= [0];
Is   = [1e19];
ds   = [ sd(d,
            pbsbase  =  mkpbsbase(N,phi,I,angle),
            description = mkdescr(N,phi,I,angle),
            I = I,
            phase = phi,
            laser_dir = (np.cos(angle/180*np.pi), np.sin(angle/180*np.pi), 0),)
         for phi   in phis
         for I     in Is
         for angle in angles];
    
for di in ds:
    gensim(**di);
