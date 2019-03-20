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
    lim =(-11e-4, 11e-4,
          -6.6e-4, 6.6e-4,
          -8.8e-4, 8.8e-4),
    tlim=(-8e-4, 8e-4,
          -6e-4, 6e-4,
          -7e-4, 7e-4),
    res =(440,165,220),
    description=" bfield in a different geometry",
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
    speciesl=[ 'e', 'O+', 'p'],
    fracs   =[3.0, 1.0, 2.0],
    thermal_energy=(1.0,1.0,1.0),
    target_temps=(None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="target.dat",
    dens_type=40,
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    restart=1000,
    totaltime=300e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    externalf_2D=True,
    new_externalf=True,
    email='ngirmang.1@osu.edu',
    #computational division
    region_dom_split='x',
    region_splits = [('z',4)],
    domains=4*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 4,
    multilaser=[
        dict(outlet='xmin',
             laser_dir = (1,0,0),
             laser_pol = (0,1,0)),
        dict(outlet='xmax',
             laser_dir = (-1,0,0),
             laser_pol= (0, -1, 0))],
    laser_t0=30e-15,
    laser_pol_type = 87,
    fp = (0.0,0.0,0.0),
    l=0.78e-6,
    w0=1.76e-6,
    I = 5e18,
    T=60e-15,
    lpmode=(0,0),
    ux=1.0,
);
sep =  4e-4; #separation along axis, actual distance is sep/sqrt(2)
PrL = 10e-4;#projected length
width = 0.6e-4/np.sqrt(2);
floor = 1e17;
N0 = 1e20;
L = 0.1e-4;
F_2D1 = mkpill(
    a = [ (-PrL-sep)*0.5, -PrL*0.5],
    b = [  (PrL-sep)*0.5,  PrL*0.5],
    xlim=d['tlim'],
    N0=N0,
    floor = floor,
    L = L,
    width = width);
F_2D2 = mkpill(
    a = [ (-PrL+sep)*0.5, -PrL*0.5],
    b = [  (PrL+sep)*0.5,  PrL*0.5],
    xlim=d['tlim'],
    N0=N0,
    floor = floor,
    L = L,
    width = width);
F_2D = lambda x,y: F_2D1(x,y) + F_2D2(x,y);
di = d #don't ask
d=sd(
    d,
    pbsbase="Bang0_lI={:3.1f}_s={:2.1f}_ln={:3.1f}".format(
        np.log10(di['I']),sep*1e4,np.log10(1e20)),
    f_2D = F_2D,
    dat_xres=321,
    dat_yres=151,
);
gensim(**d);
