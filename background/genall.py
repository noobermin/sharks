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
from gensim import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;

#E = 0.5e-3; # 5mJ
I = 1e18;
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

from gentarg import mkbgtarg;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=I,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-45,10,
          -45,45,
           0,0),
    tlim=(-44,9,
          -44,44,
           0,0),
    res =(1100,
          1800,
          0),
    timestep = 1e-16,
    totaltime= 350e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='background',
    description="background pressure scans",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=48,
    pbses='defaults',
    #target information
    lsptemplate='hotglycol.lsp',
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    thermal_energy=(1.0,1.0,1.0, 1.0),
    target_temps=(None,None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="target.dat",
    dens_type=40,
    #misc
    lspexec='lsp',
    dir=True,
    ramses_rundir = "/data/le.283/le.283-`date +%y-%m-%d`-$PBSBASE",
    restart=23.95,
    dump_restart_flag=True,
    new_externalf=True,
    email='le.283@osu.edu',
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    movrho=dict(
        clim=(-1e19,1e19),
        linthresh=1e15,),
    #pmovies
    no_pmovies=False,
    #particle dumps
    pext_species=(17,),
);

dlim = np.array([8.6e17/3.33*1e-3, 8.6e17/3.33])
dlim = np.log10(dlim);
print("creating range between {} and {}".format(dlim[0],dlim[1]));
denses = np.logspace(dlim[0], dlim[1], 5);
denses = np.append(denses, [2e16, 7e16, 1e17, 1.8e17, 8.6e17])
ds = [
    sd(d,
       pbsbase="b0_{:3.1e}".format(density),
        externalf_2D=True,
       f_2D = mkbgtarg(
           N_bg = density,
           sdim = [-1e-4,9e-4],
           twidth = 30e-4, 
           dim=[i*1e-4 for i in d['tlim']]),
       dat_xres = 500)
    for density in denses]

for di in ds:
    gensim(**di);

d2s = [sd(d,
          pbsbase="bw_{:3.1e}".format(density),
          externalf_2D=True,
          movne=dict(
              ne_species = 'RhoN17',
              clim=(1e14,1e22)),
          f_2D = mkbgtarg(
              N_bg = density,
              sdim = [-7.5e-4,2.5e-4],
              dim=[i*1e-4 for i in d['tlim']]),
          dat_xres = 500)
       for density in denses]
for di in d2s:
    gensim(**di);
