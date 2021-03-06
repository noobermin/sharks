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

from gencircle import mkcircle;
from genpilltarg import mkpill;
###########
d=dict(
    discrete=(3,2,2),
    lim =(-11e-4, 11e-4,
          -11e-4, 11e-4,
          -11e-4, 11e-4),
    tlim=(-6e-4, 6e-4,
          -6e-4, 6e-4,
          -6e-4, 6e-4),
    res =(550,550,550),
    description="multi-time real time",
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
    lsptemplate='water3d_tmpl190503.lsp',
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
    region_dom_split='z',
    region_splits = [('x',4),('y',4)],
    domains=16*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(outlet='xmin',
             laser_dir = (1,0,0),
             laser_pol = (0,1,0)),],
    laser_t0=36.6e-15,
    laser_pol_type = 87,
    fp = (0.0,0.0,0.0),
    l=0.8e-4,
    w0=1.5278e-4,
    I = 5e18,
    T=60e-15,
    lpmode=(0,0),
    ux=1.0,
    #target
    target_density=True,
    dens_lspfunc=True,
    speciesl=['H','O0'],
    fracs   =[2.0,1.0],
    thermal_energy=(0.039,0.039),#room temp (25 C)
    target_temps=(None,None),
    dens_type=51,
    dens_flags=(True,True,True),
    dens_dat=None,
    dens_imul_arg=1,
    #          rmin,n0,  L,    rmax
    dens_data=[4e-4,1e22,50e-7,6e-4],
);
d['pbsbase'] = 'mttesy00';
gensim(**d);

dlarger = sd(
    d,
    lim =(-14e-4, 8e-4,
          -13e-4, 13e-4,
          -13e-4, 13e-4),
    tlim=(-6e-4, 6e-4,
          -6e-4, 6e-4,
          -6e-4, 6e-4),
    res =(550,660,660),
    pbsbase='mttesy01');
gensim(**dlarger);

dlarger2 = sd(
    d,
    lim =(-16.2e-4, 10.2e-4,
          -13.2e-4, 13.2e-4,
          -13.2e-4, 13.2e-4),
    tlim=(-6e-4, 6e-4,
          -6e-4, 6e-4,
          -6e-4, 6e-4),
    res =(660,660,660),
    region_splits = [('x',5),('y',4)],
    domains=20*44,
    pbsbase='mttesy02',
);
gensim(**dlarger2);

#dx = 44e-9 ~ lambda/n ~ n=8.863636...
#xtot = 29.04, add 1.32 to each end
#ytot/ztot = 
dlarger3 = sd(
    d,
    lim =(-17.52e-4, 11.52e-4,
          -14.52e-4, 14.52e-4,
          -14.52e-4, 14.52e-4),
    tlim=(-6e-4, 6e-4,
          -6e-4, 6e-4,
          -6e-4, 6e-4),
    res =(660,660,660),
    region_splits = [('x',5),('y',4)],
    domains=20*44,
    pbsbase='mttesy03',
    target_density=0.0,
    target_density_plainconst=True,
    multilaser=[],
    nolaser=True,
    
);
gensim(**dlarger3);

dlgcentered = sd(
    dlarger3,
    lim =(-17.512e-4, 11.528e-4,
          -14.52e-4, 14.52e-4,
          -14.52e-4, 14.52e-4),
    pbsbase='mttesy03a');
gensim(**dlgcentered);

             
d4 = sd(
    d,
    lim =(-32.4e-4, 20.4e-4,
          -26.4e-4, 26.4e-4,
          -26.4e-4, 26.4e-4),
    tlim=(-6e-4, 6e-4,
          -6e-4, 6e-4,
          -6e-4, 6e-4),
    res =(660,660,660),
    region_splits = [('x',5),('y',4)],
    domains=20*44,
    pbsbase='mttesy04',
    target_density=0.0,
    target_density_plainconst=True,
    multilaser=[],
    nolaser=True,
    
);
gensim(**d4);
