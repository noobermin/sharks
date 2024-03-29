#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --make-target=A         Make the target for the dict with pbsbase
                             of A.
     --make-all-targets      Make all targets.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt;
from genpbs import genpbs;
from genlsp import mkregion_str
from gensim import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
e0 = 8.854e-12;
#E = 0.5e-3; # 5mJ
#from gen45 import mk45_clean_neutral2d;

targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

targ1=dict(
    l=0.78e-6,
    w=2.0e-6/np.sqrt(2*np.log(2)),
    T=60e-15,
    I=5e18,
    dens_flags=(True,False,False),
    discrete=(2,2,2),
    lim =(-10.6e-4, 7.0e-4, -6.6e-4, 6.6e-4, -6.6e-4, 6.6e-4),
    tlim=( -1.0e-4, 0.8e-4, -5.0e-4, 5.0e-4, -5.0e-4, 5.0e-4),
    res =(440,165,165),
    timestep = 0.5e-16,
    totaltime=200e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='compx_rad1',
    description="complex beam target interaction",
    dumpinterval=0.0,
    #regions
    domains=2*44,
    region_dom_split='x',
    region_splits=[('x',2)],
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    lspexec='lsp-10-3d',
    dir=True,
    restart=1000,
    restart_interval=20,
    dump_restart_flag=True,
    #movs
    #pmovies
    no_pmovies=True,
    dump_particle=False,
    dump_scalar=False,
    dump_field=False,
    dump_time_zero_flag=None,
    dump_number_densities_flag=None,
    dump_plasma_quantities_flag=None,
    #new laser
    newlaser=True,
    laser_polarization=(0,1,0),
    laser_direction=(1,0,0),
    laserafunc=4,
    lsptemplate="hotwater3d_laser86_tmpl.lsp",
    speciesl=['e','p','O+'],
    fracs   =[3.0, 2.0,1.0],
    dens_type=None,
    dens_dat=None,
    laser_t0=35.0e-15,
    lpmode=(1,0),
    #scale
    ux=1.0,
    scale_with_min=True,
    n_s = 3.34e22,
    n_min = 1.622836e17/3.0,
    solid_len=0.8e-4,
    expf = 75e-7,
    long_res = 25e4,
    long_margin=[9.6e-4,6.2e-4],
);
gensim(**targ1);

targ2 = sd(
    targ1,
    ###
    dens_flags=(True,False,False),
    discrete=(2,4,2),
    lim =(-9.6e-4, 8.0e-4, -8.8e-4, 8.8e-4, -8.8e-4, 8.8e-4),
    tlim=(-2.0e-4, 1.8e-4, -5.0e-4, 5.0e-4, -5.0e-4, 5.0e-4),
    res =(440,220,220),
    timestep = 0.5e-16,
    totaltime=200e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='compx_rad2',
    description="actual complex beam target interaction",
    dumpinterval=0.0,
    #regions
    domains=4*44,
    region_dom_split='x',
    region_splits=[('y',2),('z',2)],
    pbses='defaults',
    #laser
    lpmode=(0,0),
    l=0.78e-6,
    w=0.78e-6, #f==2.467
    laser_t0=32.0e-15,
    laser_polarization=(1,0,0,1,0),
    T=60e-15,
    I=5e18,
    lsptemplate="hotwater3d_laser86spin_tmpl.lsp",
    #scale
    scale_with_min=False,
    two_scales=True,
    n_s = 3.34e22,
    n_bmin = 3.059023e+16/3.0,
    n_fmin = 1.622836e17/3.0,
    solid_len=0.8e-4,
    Lf = 75e-7,
    Lb = 50e-7,
    long_res = 25e4,
    long_margin=[8.6e-4,6.45e-4],);
gensim(**targ2);

targ3 = sd(
    targ2,
    discrete=(2,3,2),
    lim =(-20e-4, 13.0e-4,-13.2e-4,13.2e-4,-13.2e-4,13.2e-4),
    tlim=(-2.0e-4, 1.8e-4, -5.0e-4, 5.0e-4, -5.0e-4, 5.0e-4),
    res =(660,528,528),
    timestep = 0.5e-16,
    totaltime=200e-15,
    laser_t0=66.7e-15,
    domains=6*44,
    region_dom_split='z',
    region_splits=[('y',3),('x',2)],
    pbsbase='compx_rad3',
    #scale
    scale_with_min=False,
    two_scales=True,
    n_s = 3.34e22,
    n_bmin = 3.059023e+16/3.0,
    n_fmin = 1.622836e17/3.0,
    solid_len=1.0e-4,
    Lf = 75e-7,
    Lb = 50e-7,
    long_res = 20e4,
    long_margin=[19e-4,11.25e-4],);

gensim(**targ3);

targ4 = sd(
    targ3,
    discrete=(2,3,2),
    totaltime=200e-15,
    laser_t0=66.7e-15,
    domains=9*44,
    region_dom_split='z',
    region_splits=[('y',3),('x',3)],#some foresight
    pbsbase='compx_rad4',
    lsptemplate="hotwater3d_laser86_tmpl.lsp",
    laser_polarization=(0,1,0),);
gensim(**targ4);

if opts['--make-all-targets']:
    for d in targds:
        d['mktargf'](d);
elif opts['--make-target']:
    for d in targds:
        if d['pbsbase'] == opts['--make-target']:
            d['mktargf'](d);
            break;
    else:
        raise ValueError(
            "dict with pbsbase=='{}' not found".format(opts['--make-target']));
