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
Is =[1e18, 2.1378e18, 1e19, 1e20, 1e21]
denses = [ 1e19, 1e20]
fpxs=[ -10.0, -5.0, 0.0, 5.0, 10.0]
l = 0.78e-6
T0=42e-15
w0=2.2e-6 / np.sqrt(2*np.log(2))
from gentarg import mkbgtarg;
c=2.998e8
e0=8.854e-12
EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=Is[0],
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-45,10,
          -20,20,
            0,0),
    tlim=(-45,10,
          -20,20,
            0,0),
    res =(2200,
          1600,
          0),
    timestep =  75e-18,
    totaltime= 345e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='bg',
    description="intensity background pressure scans 3",
    dumpinterval=3e-16,
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


mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-6),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-6),BfromI(I*2)))
#adding this to select special times for different intensities
dw = [sd(d,
         pbsbase="I={:1.0e}_ln={:d}_fx={:+03d}".format(
             I,int(np.log10(density)),int(fpx)),
         I=I,
         f_2D = mkbgtarg(
             N_bg = density,
             N0 = 3.34e22,
             sdim = [-7.5e-4, 2.5e-4],
             dim=[i*1e-4 for i in d['tlim']]),
         movE=mkmovE(d,I),
         movB=mkmovB(d,I),
         fp=(fpx,0.0,0.0),)
      for I in Is
      for density in denses
      for fpx in fpxs];

for di in dw:
    gensim(**di);
