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
    lim =( -14e-4,  8.0e-4,
           -11e-4, 11.0e-4,
           -11e-4, 11.0e-4,),
    tlim=(-12e-4, 8e-4, #overwritten
           -9e-4, 9e-4,
           -9e-4, 9e-4),
    res =(440,440,440),
    description="lsp reference",
    #no outputs because we do restarts now!
    no_pmovies=True,
    dump_particle=False,
    dump_scalar=False,
    dump_field=False,
    dump_time_zero_flag=None,
    dump_number_densities_flag=None,
    dump_plasma_quantities_flag=None,
    dumpinterval=0.0,
    pbses='defaults',
    #target information
    lsptemplate='hotwater3d_twolasers86_tmpl.lsp',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    restart=1000,
    totaltime=200e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    externalf_2D=True,
    new_externalf=True,
    email='ngirmang.1@osu.edu',
    #computational division
    region_dom_split='y',
    region_splits = [('x',5)],
    domains=5*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 4,
    multilaser=[
        dict(outlet='xmin',
             laser_dir = (1,0,0),
             laser_pol = (0,1,0)),],
    laser_t0=14e-6/c,
    laser_tfunctype=23,
    fp = (0.0,0.0,0.0),
    l=0.8e-4,
    w0=1.5278e-4,
    I = 5e18,
    T=70e-15,
    lpmode=(0,0),
    ux=1.0,
    #target
    thermal_energy=(1.0,1.0,1.0),
    target_temps=(None,None,None),
    speciesl=['e','p','O+'],
    fracs   =[3.0, 2.0,1.0],
    dens_type=None,
    dens_dat=None,
    #
    two_scales = True,
    roundup_pp = True,
    n_s = 1e22,
    Lf = 0.84e-4,
    Lb = 0.10e-4,
    solid_len=1.0e-4,
    n_bmin = 1e16,
    n_fmin = 1e16,
    round_unit=1e-4,
);
d['pbsbase'] = 'reftest00';
gensim(**d);

d1 = sd(d,
        pbsbase='reftest01',
        laser_tfunctype=16,
        laser_tcutoff=14e-6/c,
);
gensim(**d1);
