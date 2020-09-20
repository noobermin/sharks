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

from genlsp.Ne_species import Ne_species_explicit as Ne_species;
from genlsp.Ne_species import Ne_creation_neutral, Ne_creation_other;

###########
d=dict(
    dens_flags=(True,False,False),
    lim = (-10.0e-4,34.0e-4,
           -13.2e-4,13.2e-4,
           -13.2e-4,13.2e-4),
    tlim=(  -9.0e-4,33.0e-4,
           -12.2e-4,12.2e-4,
           -12.2e-4,12.2e-4),
    res = (880, 528, 528),
    description = "attempt to use nour's stuff",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=250e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='x',
    region_splits = [('x',4),('y',2),('z',2)],
    domains=16*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'nourb01Ey_real.dat',
                imul= 1.0,
                dmul= 1.0),
            Ey_imag   = dict(
                dat = 'nourb01Ey_imag.dat',
                imul= 1.0,
                dmul= 1.0),
            Ez_real   = dict(
                dat = 'nourb01Ez_real.dat',
                imul= 1.0,
                dmul= 1.0),
            Ez_imag   = dict(
                dat = 'nourb01Ez_imag.dat',
                imul= 1.0,
                dmul= 1.0),),],
    laser_t0 = 47.7e-15,#33.4e-15 +
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.8e-4,
    w0= 0.8e-4,
    fp = (0.0,0.0,0.0),
    I = 5e18,
    T = 60e-15,
    #target
    pbsbase = 'neona01',
    species = Ne_species,
    #creations vary as a scan, so defined below
    new_create = True,
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



Is = [5e19,1e20,5e20];
#2.462e19 is 1 atm
nes = [1e17,5e17,1e18,5e18,1e19,5e19]


pbsfmt = 'neona01_ne={:.0e}-I={:0.0e}'
def mkpbsbase(ne,I): return pbsfmt.format(ne,I);
descrfmt = 'Complex neon, I={}, ne={}'
def mkdescr(ne,I): return pbsfmt.format(ne,I);
#target
discrete=(2,2,2)
species = Ne_species;

# Neon neutral plasma template
plainfunc = dict(
    type = 1,
    decode='utf-8',
    coeffs=1e19);
ne_plasma = dict(
    type ='plasma',
    label='Ne',
    species = 1,
    lim='tlim',
    momentum_flags = (False, False, False),
    density_flags  = (True,False,False),
    reference_point = (0.0,0.0,0.0),
    drift_momentum  = (0.0,0.0,0.0),
    thermal_energy  = 0.026,
    discrete_numbers= discrete,
    density_function = plainfunc);



#for each density
ne_x_I = [ (ne,I) for ne in nes for I in Is ];
for ne,I in ne_x_I:
    #generate particle creation models for this density
    curplasma = sd(
        ne_plasma,
        density_function = sd(plainfunc, coeffs = ne));
    curcreation = [curplasma] + Ne_creation_other;
    #each simulation
    curd = sd(
        d,
        pbsbase=mkpbsbase(ne,I),
        description = mkdescr(ne,I),
        creation=curcreation);
    #generate files
    gensim(**curd);


