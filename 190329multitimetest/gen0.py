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
    dens_flags=(True,True,False),
    discrete=(2,2,2),
    lim =(-11.0e-4, 11.0e-4,
           -8.8e-4,  8.8e-4,
           -8.8e-4,  8.8e-4),
    tlim=(-8e-4, 8e-4,
          -6e-4, 6e-4,
          -7e-4, 7e-4),
    res =(550,440,440),
    description="high efield test",
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
    laser_t0=36.6e-15,
    laser_pol_type = 87,
    fp = (0.0,0.0,0.0),
    l=0.8e-4,
    w0=1.5278e-4,
    I = 5e18,
    T=70e-15,
    lpmode=(2,0),
    ux=1.0,
    #target (as in no target)
    thermal_energy=(1.0,1.0,1.0),
    target_temps=(None,None,None),
    speciesl=['e','p','O+'],
    fracs   =[3.0, 2.0,1.0],
    dens_type=None,
    dens_dat=None,
    target_density = 0.0,
    target_density_plainconst=True,
);
d['pbsbase'] = 'mttest01';
gensim(**d);
#going backwards in time
d['lpmode'] = (0,0);
d['pbsbase'] = 'mttest00';
d['totaltime'] = 100e-15;
gensim(**d);
d=sd(d,
     lim =(-11.0e-4, 33.0e-4,
           -17.6e-4, 17.6e-4,
           -17.6e-4, 17.6e-4),
     res = (550,440,440),
     pbsbase='mttest00a',);
gensim(**d);
