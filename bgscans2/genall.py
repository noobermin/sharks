#!/usr/bin/env python3
'''
Usage: 
    ./genall.py [options]

Options:
     --make-target         Make the target.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt;
from genpbs import genpbs;
from gensim_obj import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
import re;

#E = 0.5e-3; # 5mJ
Is =[1e18, 2.1378e18, 1e19, 1e20]
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0s=[21e-15, 42e-15, 84e-15]
from gentarg import mkbgtarg;
c=2.998e8
e0=8.854e-12
EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
d=dict(
    l=l,
    w=w0,
    T=T0s[0]*2,
    I=Is[0],
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-45,10,
          -20,20,
            0,0),
    tlim=(-44,9,
          -34,34,
            0,0),
    res =(2200,
          1600,
          0),
    timestep =  75e-18,
    totaltime= 300e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='bg',
    description="intensity background pressure scans",
    dumpinterval=1.5e-16,
    #PIC/grid details
    #specifically for onyx
    domains=88,
    pbses='defaults',
    #target information
    lsptemplate='hotwater3d_cond_tmpl.lsp',
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
        contour_lines=(1e18, 1e21),
        contour_quantities=('RhoN10', 'RhoN10'),
    ),
    movB=dict(
        clim=(BfromI(2e12),BfromI(2e18)),
        contour_lines=(1e18, 1e21),
        contour_quantities=('RhoN10', 'RhoN10'),
    ),
    #pmovies
    no_pmovies=False,
    #particle dumps
    pext_species=(10,),
);

#denses = [ m*10.0**p for p in np.arange(16,21) for m in [1.0,5.0]];
denses = [ m*10.0**p for p in np.arange(16,21) for m in [1.0]];
fromd = lambda d,density,l='movE': sd(d[l],contour_lines=(density*0.5,1e21))
mkmovE = lambda d, density: fromd(d,density)
mkmovB = lambda d, density: fromd(d,density,'movB')
dw = [sd(d,
         pbsbase="bg={:1.0e}_I={:1.0e}_T={:1.0e}".format(density,I,T0),
         I=I,
         T=T0,
         totaltime = 425e-15 if np.isclose(T0,84e-15) else 300e-15,
         f_2D = mkbgtarg(
             N_bg = density,
             sdim = [-7.5e-4, 2.5e-4],
             dim=[i*1e-4 for i in d['tlim']]),
         movE=mkmovE(d,density),
         movB=mkmovB(d,density),)
      for density in denses
      for I in Is
      for T0 in T0s ];

dC = [sd(di,
         pbsbase=re.sub('bg','Cg',di['pbsbase']),
         conductors = [
             { 'from':[ 2.4e-4, -11e-4, 0],
               'to':  [11.0e-4,  11e-4, 0],},],)
      for di in dw ];


for di in dw+dC:
    gensim(**di);
