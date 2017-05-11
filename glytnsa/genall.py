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
I = 5e18;
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

from genangletarg import mk45;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(-7,7,
          -7,7,
           0,0),
    tlim=(-5,5,
          -5,5,
           0,0),
    res =(1400,
          1400,
          0),
    timestep = 2e-17,
    totaltime= 140e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='glycol',
    description="hotglycol TNSA absorption",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=49*4,
    region_split=('y',7*2),
    pbses='defaults',
    #target information
    lsptemplate="hotglycol.lsp",
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    thermal_energy=(1.0,1.0,1.0,1.0),
    target_temps=(None,None,None,None),
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_dat="target45.dat",
    dens_type=40,
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    restart=23.95,
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
#generating scans
hf = np.arange(2.5,20.0, 2.5);
fps = [-1.0, 0.0, 1.0] + list(-hf) + list(hf)
peak = [
    sd(d,
       pbsbase='glypeak_fp={:0=+5.1f}'.format(fp),
       fp=(fp, 0.0, 0.0))
    for fp in fps
];

for d in peak:
    gensim(**d);

picket = [
    sd(d,
       I=1e14,
       thermal_energy=(0.01,0.01,0.01,0.01),
       pbsbase='glypicket_fp={:0=+5.1f}'.format(fp),
       fp=(fp, 0.0, 0.0))
    for fp in fps
];
for d in picket:
    gensim(**d);
dirs = [ d['pbsbase'] for d in (peak + picket) ];
    
if opts['--make-target']:
    targd = sd(
        d,
        f_2D = mk45(
            dim   = (-5,5,-5,5),
            N0    = 1.0804e22,
            width = 0.46e-4,
            dropcorners=False),
        dat_xres = 1000);
    print("making targets");
    dat = gendat(**targd);
    print("copying");
    for path in dirs:
        savetxt(
            "{}/target45.dat".format(path), dat);


