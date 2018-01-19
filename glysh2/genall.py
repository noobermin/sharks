#!/usr/bin/env python
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
I = 5e18;
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

from gen45  import mk45_pinprick_plasma;

xmin=ymin=-35;
xmax=ymax= 35;
xres=yres= 35*2 * 100; #7000

d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(xmin,xmax,
          ymin,ymax,
          0,0),
    tlim=(xmin,xmax,
          xmax,ymax,
          0,0),
    res =(xres,
          yres,
          0),
    timestep = 2e-17,
    totaltime= 3e-12,
    fp=(-10.0,0.0,0.0),
    pbsbase='glysh0',
    description="After TNSA expansion",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=88*2,
    region_split=('y',8),
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_type=40,
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    restart=11.95,
    dump_restart_flag=True,
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
    dump_particle=True,
    particle_dump_interval_ns=0.0,
    particle_dump_times_ns=(1e-4, 1.1e-4, 1.4e-4),
    pext_species=(17,18),
);
#conductors
backout=1e-4
backin =5e-4
w = 0.460e-4;
offset = backin+np.sqrt(2)*1e-4
#lower left corner
lca=np.array([xmin,ymin])*1e-4 - backout;
lcb=lca + np.array([1,0])*offset;
lcc=lca + np.array([0,1])*offset;

#upper right corner
uca=np.array([xmax,ymax])*1e-4 + backout;
ucb=uca - np.array([1,0])*offset;
ucc=uca - np.array([0,1])*offset;

d['conductors'] = [
    {'type':'TRILATERAL',
     'from':(lca[0],lca[1],0.0),
     'to'  :[
         (lcb[0],lcb[1],0.0),
         (lcc[0],lcc[1],0.0)]},
    {'type':'TRILATERAL',
     'from':(uca[0],uca[1],0.0),
     'to'  :[
         (ucb[0],ucb[1],0.0),
         (ucc[0],ucc[1],0.0)]}
];




#species and target.
d.update(**dict(
    lsptemplate="hotglycol2_allemitters_neutrals.lsp",
    speciesl=[ 'e','O1','C1','p',
               'O0','C0','H'],
    fracs   =[10.0, 2.0, 2.0,6.0,
              2.0, 2.0,6.0],
    #there are two densities, one for plasma and one for neutrals.
    dens_type=40,
    dens_dat=('target_plasma.dat',)*4 + ('target_neutral.dat',)*3,
    #this is assuming the shoulder is 1e14 W/cm^2 at 12 picoseconds
    #using wilks scaling.
    thermal_energy=(
        #plasma is 6 eV
        6.0,6.0,6.0,6.0,
        #and (god help me) neutrals are...not
        0.5, 0.5, 0.5),
    target_temps=(
        None,None,None,None,
        None,None,None),
));

targ_plasma, targ_neutral = mk45_pinprick_plasma(
    dim = [i*1e-4 for i in d['tlim']],
    N0  = 1.08e22,
    laser_radius = w0*1e2,
    width = 0.46e-4,
    L = 0.043e-4,# 43nm
    depth = 0.086e-4, #chosen arbitrarily
    mindensity=1e18);
gensim(**d);
if opts['--make-target']:
    print("making targets");
    dd = sd(d, f_2D = targ_plasma, dat_xres = 7001);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(d['pbsbase'],'target_plasma.dat'),
        dat);
    dd = sd(d, f_2D = targ_neutral, dat_xres = 7001);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(d['pbsbase'],'target_neutral.dat'),
        dat);



