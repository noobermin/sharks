#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt;
from genpbs import genpbs;
from gensim import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
#E = 0.5e-3; # 5mJ

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-5),BfromI(I*2)))

###########
d=dict(
    dens_flags=(True,False,False),
    discrete=(2,2,2),
    lim =( -20.1e-4, 0.1e-4,
           -13.2e-4, 13.2e-4,
           -13.2e-4, 13.2e-4,),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res =(400,528,528),
    description="gauss test",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=200e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    lsptemplate='laseronly_tmpl200101.lsp',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',2),('z',2)],
    domains=8*28,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'gaussreal.dat',
                imul= 1.0,
                dmul= 1.0),
            Ey_imag   = dict(
                dat = 'gaussimag.dat',
                imul= 1.0,
                dmul= 1.0),),],
    laser_t0 = -20e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.78e-4,
    w0= 0.78e-4,
    fp = (0.0,0.0,0.0),
    I = 5e18,
    T = 60e-15,
    #target
    no_matter = True,
);
d['pbsbase'] = 'rawtest00';
gensim(**d);

d2 = sd(
    d,
    lim = (-20.0e-4, 6.4e-4,
           -13.2e-4,13.2e-4,
           -13.2e-4,13.2e-4),
    res = (528, 528, 528),
    description = "attempt to use nour's stuff",
    domains = 44*8,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'nour00Ey_real.dat',
                imul= 1.0,
                dmul= 1.0),
            Ey_imag   = dict(
                dat = 'nour00Ey_imag.dat',
                imul= 1.0,
                dmul= 1.0),
            Ez_real   = dict(
                dat = 'nour00Ez_real.dat',
                imul= 1.0,
                dmul= 1.0),
            Ez_imag   = dict(
                dat = 'nour00Ez_imag.dat',
                imul= 1.0,
                dmul= 1.0),),],
    pbsbase = 'nour00');
gensim(**d2);


