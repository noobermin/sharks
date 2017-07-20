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

from gencircle import mkcircle;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=I,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-12,12,
           -8, 8,
           0,0),
    tlim=(-5,5,
          -5,5,
           0,0),
    res =(2400,
          1600,
          0),
    timestep = 2e-17,
    totaltime= 200e-15,
    fp=(0.0, 5.0,0.0),
    pbsbase='circle',
    description="circle play",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=8*12,
    region_split=('y',8),
    pbses='defaults',
    #target information
    lsptemplate="hotwater3d_2_tmpl.lsp",
    speciesl=[ 'e', 'O', 'p'],
    fracs   =[ 3.0, 1.0, 2.0],
    thermal_energy=(1.0,1.0,1.0),
    target_temps=(None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="circle.dat",
    dens_type=40,
    #misc
    lspexec='lsp-10-xy',
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
    movB=dict(
        clim=(1e2,1e8),
        contour_lines=(1e19,1e21),
        contour_quantities=('RhoN10', 'RhoN10'),),
    #pmovies
    no_pmovies=False,
    #particle dumps
    dump_particle=True,
    particle_dump_interval_ns=2e-15,
);
gensim(**d);
d2 = sd(
    d,
    pbsbase='circle2',
    multilaser=[
        dict(outlet='xmin',
             fp=(0.0, 5.0, 0.0)),
        dict(outlet='xmax',
             fp=(0.0,-5.0, 0.0))],);
gensim(**d2);
Is = 5*(10.0**np.arange(16,23));
Iscan = [ sd(d2,I = i,pbsbase="circ_{:.0e}".format(i))
          for i in Is ];
for di in Iscan:
    gensim(**di);

if opts['--make-target']:
    print("making targets");
    def mktarg(di):
        tw = di['tlim'][1] - di['tlim'][0]
        dat_xres= int(tw/(di['lim'][1]-di['lim'][0])*di['res'][0]);
        dd = sd(
            di,
            f_2D = mkcircle(
                dim = [i*1e-4 for i in di['tlim']],
                No  = 3.34e22,
                Ni  = 0.0,
                ro  = 5e-4,
                ri  = 3e-4),
            dat_xres= dat_xres,
        );
        return gendat(**dd);
    def saveto(dat,di):
        savetxt(
            "{}/{}".format(di['pbsbase'],di['dens_dat']),dat);
    cdat = mktarg(d);
    saveto(cdat, d);
    mktarg(cdat, d2);
    for di in Is:
        saveto(cdat, **di);

