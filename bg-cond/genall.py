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

#E = 0.5e-3; # 5mJ
I = 1e18;
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

from gentarg import mkbgtarg;

c=2.998e8
e0=8.854e-12
EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;

d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=I,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-15,15,
          -15,15,
           0,0),
    tlim=(-14,14,
          -14,14,
           0,0),
    res =(30*20,
          30*20,
          0),
    conductors=[
        dict(outlet='xmax', width=10.0, start=-1.5)],
    timestep = 1e-16,
    totaltime= 250e-15,
    fp=(0.0, 0.0, 0.0),
    pbsbase='refl',
    description="reflection test",
    dumpinterval=2e-16,
    #PIC/grid details
    domains=24,
    pbses='defaults',
    #target information
    lsptemplate='hotwater3d_cond_tmpl.lsp',
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[3.0, 1.0, 2.0],
    thermal_energy=(1.0,1.0,1.0,),
    target_temps=(None,None,None,),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="mist.dat",
    dens_type=40,
    externalf_2D=True,
    new_externalf=True,
    dat_xres=100,
    f_2D = lambda x,y: x*0+y*0+1e19,
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    restart=11.9,
    dump_restart_flag=True,
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
    no_pmovies=True,
    #pext dumps
    pext_species=(10,),
);

gensim(**d);
noobjd = sd(d,pbsbase='norefl');
del noobjd['conductors']
gensim(**noobjd);
quit();
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
    lsptemplate='hotwater3d_cond_tmpl.lsp',
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[3.0, 1.0, 2.0],
    thermal_energy=(1.0,1.0,1.0,),
    target_temps=(None,None,None,),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="target.dat",
    dens_type=40,
    #misc
    lspexec='lsp',
    dir=True,
    restart=23.95,
    dump_restart_flag=True,
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

dlim = np.array([8.6e17/3.33*1e-3, 8.6e17/3.33])
dlim = np.log10(dlim);
print("creating range between {} and {}".format(dlim[0],dlim[1]));
denses = np.logspace(dlim[0], dlim[1], 5);
denses = np.append(denses, [2e16, 7e16, 1e17, 1.8e17, 8.6e17])

fromd = lambda d,density,l='movE': sd(d[l],contour_lines=(
    float("{:0.2e}".format(density*0.5)),
    1e21))
mkmovE = lambda d, density: fromd(d,density)
mkmovB = lambda d, density: fromd(d,density,'movB')

d1s = [
    sd(d,
       pbsbase="b0_{:3.1e}".format(density),
       externalf_2D=True,
       f_2D = mkbgtarg(
           N_bg = density,
           sdim = [-1e-4,9e-4],
           twidth = 30e-4, 
           dim=[i*1e-4 for i in d['tlim']]),
       dat_xres = 500,
       movE=mkmovE(d,density),
       movB=mkmovB(d,density),)
    for density in denses]

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
          dat_xres = 500,
          movE=mkmovE(d,density),
          movB=mkmovB(d,density),)
       for density in denses]

ds = d1s+d2s;

for di in ds:
    gensim(**di);
