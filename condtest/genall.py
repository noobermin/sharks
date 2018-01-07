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
Is =[1e19]
Ls =[1.6] 
l = 0.78e-6
T0=42e-15
w0=2.2e-6 / np.sqrt(2*np.log(2))
from gentarg import mkbgtarg;
c=2.998e8
e0=8.854e-12
n_s = 3.34e23
n_bg= 1e19;
EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=Is[0],
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-30,15,
          -15,15,
            0,0),
    tlim=(-30,15,
          -15,15,
            0,0),
    res =(1800,
          1200,
          0),
    timestep =  75e-18,
    totaltime= 345e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='bg',
    description="nothing but your hot thing",
    dumpinterval=3e-16,
    #PIC/grid details
    #specifically for onyx
    domains=88,
    pbses='defaults',
    #target information
    lsptemplate='hotwater3d_cond_tmpl.lsp',
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[3.0, 1.0, 2.0],
    thermal_energy=(1.,1.,1.),
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
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-4),BfromI(I*2)))
#adding this to select special times for different intensities
#first, smaller scale-lengths
dw = [sd(d,
         pbsbase="lI={:4.1f}_L={:3.2}".format(np.log10(I),L),
         I=I,
         f_2D = mkbgtarg(
             N_bg = n_bg,
             N0 = n_s,
             sdim = [0.0, 10.0e-4],
             L=L*1e-4,
             twidth=30e-4,
             dim=[i*1e-4 for i in d['tlim']]),
         extrapexts=[
             dict(species=10,
                  position=(-np.log(n_s/n_bg)*L*1e-4-15e-4,0,0))
             ],
         movE=mkmovE(d,I),
         movB=mkmovB(d,I))
      for I in Is for L in Ls];

for di in dw:
    gensim(**di);
##############################################

noc=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=Is[0],
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-30,15,
          -15,15,
            0,0),
    tlim=(-30,15,
          -15,15,
            0,0),
    res =(1800,
          1200,
          0),
    timestep =  75e-18,
    totaltime= 225e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='ht',
    description="nothing but your hot thing",
    dumpinterval=3e-16,
    #PIC/grid details
    #specifically for onyx
    domains=88,
    pbses='defaults',
    #target information
    lsptemplate='hotwater3d_cond_tmpl.lsp',
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[3.0, 1.0, 2.0],
    thermal_energy=(1e3,1e3,1e3),
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
    #warmup
    f_2D = mkbgtarg(
        N_bg = n_bg,
        N0 = n_s,
        sdim = [0.0, 10.0e-4],
        L=0.4e-4,
        twidth=10e-4,
        dim=[i*1e-4 for i in d['tlim']]
    ),
);
gensim(**noc);
nonoc = sd(noc,
           pbsbase='htc',
           conductors=[
               dict(outlet='xmax'),
               dict(outlet='ymin'),
               dict(outlet='ymax'),],
           cond_temp=1e3,);
gensim(**nonoc);
