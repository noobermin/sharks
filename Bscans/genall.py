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
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-4),BfromI(I*2)))

from gencircle import mkcircle;
###########
Is =[2e17, 2e18, 2e19, 2e20]
l = 0.78e-6
T0=42e-15
w0=2.2e-6 / np.sqrt(2*np.log(2))
n_s = 3.34e23
xres_perum = 100
d12um=dict(
    l=l,
    w=w0,
    T=T0*2,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-12,12,
          -12,12,
            0,0),
    tlim=(-12,12,
          -12,12,
            0,0),
    res =(24*xres_perum,
          24*xres_perum,
          0),
    timestep =  25e-18,
    totaltime= 300e-15,
    multilaser=[
        dict(outlet='xmin',
             fp=(0.0, 5.0, 0.0)),
        dict(outlet='xmax',
             fp=(0.0,-5.0, 0.0))],
    pbsbase='B0',
    description="angular laser",
    dumpinterval=5e-16,
    #PIC/grid details
    #specifically for onyx
    domains=88,
    pbses='defaults',
    #target information
    lsptemplate='hotwater3d_tmpl.lsp',
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[3.0, 1.0, 2.0],
    thermal_energy=(1.0,1.0,1.0),
    target_temps=(None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="target.dat",
    dens_type=40,
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    restart=23.95,
    ramses_rundir = "/data/ngirmang.1/ngirmang.1-`date +%y-%m-%d`-$PBSBASE",
    dump_restart_flag=True,
    externalf_2D=True,
    new_externalf=True,
    email='ngirmang.1@osu.edu',
    #movs
    movne=dict(
        ne_species = 'RhoN10',
        clim=(1e19,1e23)),
    movrho=dict(
        clim=(-1e19,1e19),
        linthresh=1e15,),
    movE=dict(
        clim=(EfromI(2e12),EfromI(2e18)),
        contour_lines=(1.7e21),
        contour_quantities=('RhoN10'),
    ),
    movB=dict(
        clim=(BfromI(2e12),BfromI(2e18)),
        contour_lines=(1.7e21),
        contour_quantities=('RhoN10'),
    ),
    #no pmovies
    no_pmovies=True,
    dump_particle=True,
    particle_dump_interval_ns=15e-15,
    #particle dumps
    pext_species=(10,),
);

#adding this to select special times for different intensities
#first, smaller scale-lengths
ris = [0.0, 1.0, 5.0/np.sqrt(3), 4.0];
d12s = [sd(d12um,
           pbsbase="B0_lI={:3.1f}_ri={:3.2}".format(np.log10(I),ri),
           I=I,
           f_2D = mkcircle(
               No = n_s,
               # 20.0/760.0 * 101325/e*1e-6
               zero=6.66e17,
               floor=6.66e17,
               #
               Li = 0.04e-4,
               Lo = 0.04e-4,
               ro = 5.0e-4,
               ri = ri*1e-4,
               dim=[i*1e-4 for i in d12um['tlim']]),
           movE=mkmovE(d12um,I),
           movB=mkmovB(d12um,I))
        for I in Is for ri in ris];
for di in d12s:
    gensim(**di);
