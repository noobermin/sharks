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
d = dict(
    dens_flags=(True,False,False),
    lim = (-20.0e-4,10.0e-4,
           -13.2e-4,13.2e-4,
           -13.2e-4,13.2e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res = (600, 528, 528),
    description = "attempt to use nour's stuff",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=600e-15,
    timestep =5e-17,
    restart_interval=None,
    restart_interval_ns = 1e-15,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',2),('z',2)],
    domains=8*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'nour01Ey_real.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),
            Ey_imag   = dict(
                dat = 'nour01Ey_imag.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),
            Ez_real   = dict(
                dat = 'nour01Ez_real.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),
            Ez_imag   = dict(
                dat = 'nour01Ez_imag.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),),],
    laser_t0 = -20e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.8e-4,
    w0= 0.8e-4,
    fp = (0.0,0.0,0.0),
    I = 5e18,
    T = 60e-15,
    #target
    pbsbase = 'noura02',
    species = species,
    new_create=True,
    creation= creation,
    #scale
    fracs = [1,2,3],
    pill2_5D = dict(
        n_s  = 3.34e22,
        n_min= 1e17,
        L    = 0.005e-4,
        Lz   = 0.005e-4,
        height = 10e-4,
        length = 12e-4,
        half_width = 0.25e-4,
        rot    = 0,
        roundup_pp = True,
        round_unit = 1e-4,
        xmargin    = 3e-4,
        ymargin    = 3e-4,
        zmargin    = 3e-4,
        keep_lim   = True,
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
    #pext
    pext_species=(11,12),
);

N  = 0;
Is = [5e19,1e20,5e20,1e21,5e21];
pbsfmt = 'nourc{:02}_{:0.0e}'
def mkpbsbase(I): return pbsfmt.format(N,I);
descrfmt = 'High Intensity Complex beam interacting with matter, I={}'
def mkdescr(I): return descrfmt.format(N,I);

def mkI(Is, splittime=None):
    if splittime is None:
        return [
            sd(d, pbsbase=mkpbsbase(I),description=mkdescr(I),I=I,)
            for I in Is ];
    return [
        sd(d,
           splittime=splittime,
           pbsbase=mkpbsbase(I),description=mkdescr(I),I=I)
        for I in Is ];

ds = mkI(Is);


for di in ds:
    gensim(**di);
