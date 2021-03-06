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
from genlsp.h2o_species import h2o_creation_neutral, h2o_creation_other;
discrete=(4,4,1)
species = h2o_species;
plasmacs = sdl(h2o_creation_neutral,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 0.035);
creation = plasmacs + h2o_creation_other;

###########
d=dict(
    dens_flags=(True,True,False),
    lim = (-11.0e-4, 11.0e-4,
           -11.0e-4, 11.0e-4,
             0.0e-4,  0.0e-4),
    tlim=( -2.0e-4, 2.0e-4,
           -8.0e-4, 8.0e-4,
           -0.0e-4, 0.0e-4),
    res = (4400,2200,0),
    description = "tight3d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    totaltime=  1.05e-12,
    timestep = 20.0e-18,
    restart_interval=50,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',2),('z',1)],
    domains=4*40,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    T = 60e-15,#fitted elsewhere
    l = 0.710e-4,
    w0= 1.05e-4,
    fp= (0.0, 0.0, 0.0),
    multilaser=[
    ],
    #target
    species  = species,
    creation = creation,
    fracs = [2,1],
    pill2D = dict(
        n_s  = 3.34e22,
        n_min= 1e17,
        L    = 0.02e-4,
        #Lz   = 0.02e-4,
        #height = 14e-4,
        length = 14e-4,
        half_width = 0.05e-4,
        rot    =    0,
        roundup_pp = True,
        keep_lim  = True,
        round_unit = 1e-4,
        #zmargin    = 3e-4,
    ),
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

pbsfmt = 'spill2d_neutrals{:02}_p={:0.2f}_I={:0.0e}'
def mkpbsbase(N,phi,I): return pbsfmt.format(N,phi,I);
descrfmt = '2D target, near normal, phase={}, I={}'
def mkdescr(N,phi,I): return descrfmt.format(N,phi,I);
N     = 2
phis  = [0.0,0.5];
Is   = [1e19];
ds   = [ sd(d,
            pbsbase  =  mkpbsbase(N,phi,I),
            description = mkdescr(N,phi,I),
            I = I,
            phase = phi)
         for phi   in phis
         for I     in Is];
    
for di in ds:
    gensim(**di);
