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

for di in peak:
    gensim(**di);
#other intensities
I3e18 = [
    sd(d,
       pbsbase='gly3e+18_fp={:0=+5.1f}'.format(fp),
       I=3e18,
       fp=(fp, 0.0, 0.0))
    for fp in fps
];
I1e18 = [
    sd(d,
       pbsbase='gly1e+18_fp={:0=+5.1f}'.format(fp),
       I=1e18,
       fp=(fp, 0.0, 0.0))
    for fp in fps
];


for di in (I3e18 + I1e18):
    gensim(**di);

#pickets
picket = [
    sd(d,
       I=1e14,
       thermal_energy=(0.01,0.01,0.01,0.01),
       pbsbase='glypicket_fp={:0=+5.1f}'.format(fp),
       fp=(fp, 0.0, 0.0))
    for fp in fps
];
for di in picket:
    gensim(**di);
dirs = [ di['pbsbase'] for di in (peak + I3e18 + I1e18 + picket) ];
    
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


longa=sd(
    d,
    discrete=(3,3,1),
    lim =(-7,14,
          -7,14,
           0,0),
    tlim=(-5,12,
          -5,12,
           0,0),
    res =(2100,
          2100,
          0),
    I=5e18,
    timestep = 2e-17,
    fp=(0.0,0.0,0.0),
    pbsbase='glylonga',
    description="hotglycol TNSA absorption",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=49*9,
    region_split=('y',3*7),
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
    dens_dat="target_la45.dat",
    dens_type=40,
    #particle dumps
    totaltime= 110e-15 + 400e-15,
    dump_particle=True,
    particle_dump_interval_ns=0.0,
    particle_dump_times_ns=(1e-4, 1.1e-4, 1.5e-4, 2.0e-4, 2.5e-4, 3e-4, 3.5e-4, 4e-4, 4.5e-4, 5e-4, 5.1e-4),
    pext_species=(17,18));
longb = sd(
    longa,
    lim = (-7, 21,
           -7, 21,
           0,0),
    tlim=(-5,19,
          -5,19,
           0,0),
    res = (2800,
           2800,
           0),
    pbsbase='glylongb',
    domains = 49*16,
    region_split=('y', 7*4),
    dens_dat="target_lb45.dat")
longc = sd(
    longb,
    lim = (-14, 14,
           -14, 14,
           0,0),
    tlim=(-12,12,
          -12,12,
          0,0),
    res = (2800,
           2800,
           0),
    pbsbase='glylongc',
    dens_dat="target_lc45.dat")

longd=sd(
    longa,
    lim = (-11, 11,
           -11, 11,
             0,  0),
    tlim = (-10, 10,
            -10, 10,
            0,0),
    res  = (2200, 2200, 0),
    domains = 121*4,
    region_split=('y', 11*2),
    pbsbase='glylongd',
    dens_dat="target_ld45.dat");


for d in [longa,longb,longc,longd]:
    gensim(**d);


if opts['--make-target']:
    print("making targets");
    def mktarg(di):
        dd = sd(
            di,
            f_2D = mk45(
                dim = di['tlim'],
                N0    = 1.0804e22,
                width = 0.46e-4,
                dropcorners='round'),
            dat_xres=di['res'][0]);
        dat = gendat(**dd);
        savetxt(
            "{}/{}".format(di['pbsbase'],di['dens_dat']),
            dat);
    for di in [longa,longb,longc,longd]:
        mktarg(di);
