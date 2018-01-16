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

from genangletarg import mk45;
d=dict(
    res  = (3500, 3500, 0),
    domains = 49*4,
    region_split=('y', 35),
    pbsbase='glysh2_aem',
    dens_dat="target_lf45.dat",
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-35,35,
          -35,35,
           0,0),
    tlim=(-35,35,
          -35,35,
           0,0),
    res =(7000,
          7000,
          0),
    timestep = 2e-17,
    totaltime= 3e-12,
    fp=(-10.0,0.0,0.0),
    pbsbase='glycol',
    description="After TNSA expansion",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=88*3,
    region_split=('y',7*2),
    pbses='defaults',
    #target information
    lsptemplate="hotglycol.lsp",
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    #this is assuming the shoulder is 1e14 W/cm^2 at 12 picoseconds
    #using wilks scaling.
    thermal_energy=(6.0,6.0,6.0,6.0),
    target_temps=(None,None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="target45.dat",
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
for di in longs: 
    gensim(**di);
if opts['--make-target']:
    print("making targets");
    def mktarg(di):
        dd = sd(
            di,
            f_2D = mk45(
                dim = [i*1e-4 for i in di['tlim']],
                N0    = 1.0804e22,
                width = 0.46e-4,
                # wilks*12e-12, just for a round 40 nm n_n
                L=40e-4);
        dat = gendat(**dd);
        savetxt(
            "{}/{}".format(di['pbsbase'],di['dens_dat']),
            dat);
    for di in longs:
        mktarg(di);


