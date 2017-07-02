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
I = 2.5e18;
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

from gencircle import fuzzcircle;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=I,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-20,20,
          -20,20,
          0,0),
    tlim=(-16,16,
          -16,16,
           0,0),
    res =(1600,
          1600,
          0),
    timestep = 5e-17,
    totaltime= 200e-15,
    fp=(-5.0,0.0,0.0),
    pbsbase='prexp',
    dumpinterval=5e-16,
    #PIC/grid details
    domains=48,
    region_split=('y',2),
    pbses='defaults',
    #target information
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[ 3.0, 1.0, 2.0],
    thermal_energy=(1.0,1.0,1.0),
    target_temps=(None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="cyl.dat",
    dens_type=40,
    #misc
    lspexec='lsp-10-xy',
    lsptemplate='hotwater3d_2_tmpl.lsp',
    dir=True,
    restart=11.9,
    dump_restart_flag=True,
    #movs
    movne=dict(
        ne_species = 'RhoN10',
        clim=(1e19,1e23)),
    movrho=dict(
        clim=(-1e19,1e19),
        linthresh=1e15,),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=True,
    particle_dump_interval_ns=1e-15,
);
d2 = sd(d,
        lim = (-25,25,
               -25,25,
               0,0),
        tlim = (-20,20,
                20,20,
                0,0),
        pbsbase='prexp2',
        region_split=('y',3),
        domains=96,
        totaltime=400e-15,
        particle_dump_interval_ns=1e-15,);
gensim(**d);
gensim(**d2);
if opts['--make-target']:
    print("making targets");
    def mktarg(di):
        tw = di['tlim'][1] - di['tlim'][0]
        dat_xres= int(tw/(di['lim'][1]-di['lim'][0])*di['res'][0]);
        dd = sd(
            di,
            f_2D = fuzzcircle(
                dim = [i*1e-4 for i in di['tlim']],
                No  = 3.34e22,
                ro  = 5e-4,
                L   = 1e-4,
                prexp=True),
            dat_xres= dat_xres,
        );
        dat = gendat(**dd);
        savetxt(
            "{}/{}".format(di['pbsbase'],di['dens_dat']),
            dat);
    mktarg(d);
    mktarg(d2);
