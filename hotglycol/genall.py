#!/usr/bin/env python3
'''
Usage: 
    ./genall.py [options]

Options:
     --make-targets          Make all targets.
     --make-target=T         Make the Tth target.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple;
from genpbs import genpbs;
from gensim import gensim, fromenergy,c;
import numpy as np;
import shutil as sh;

pbsbase="glycol_tnsa";
E = 0.5e-3; # 5mJ
w = 1.7e-6;
I = 5e18;
T = 2.0 * 5e-3/(w**2*np.pi/2.0 * I*1e4)
l = 0.78e-6
def mkslab(
        dim=2,
        n=1.0800215e+22,# 1.1132[g/cc] / 62.07[g/mol] * 6.022e23[N/mol]
        lower_edge=0,
        unit=1e-4,):
    dim*=unit;
    lower_edge*=unit;
    @np.vectorize
    def f(x):
        if lower_edge <= x <= dim+lower_edge:
            return n;
        return 0.0;
    return f;
#custom regioning
#split y by half
#and   z by n
gensim(
    l = l,
    w = w,
    T = T,
    I = I,
    fp=(-0.1,0,0),
    tref=(0,0,0),
    dens_flags=(True,True,True),
    lim =(
        -2.5, 2.5,
        -8.5, 8.5,
           0,   0),
    tlim=(
        -0.1, 0.1,
        -6.0, 6.0,
           0,   0),
    res =(1000,3400, 0),
    timestep =1e-17,
    totaltime=70e-15,
    pbsbase=pbsbase,
    description="hotglycol TNSA stage 1",
    dumpinterval=5e-17,
    #PIC/grid details
    domains=48*8,
    pext_species=(17,18),
    region_split=('y',8),
    pbses='defaults',
    #target information
    lsptemplate="hotglycol.lsp",
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    thermal_energy=(1.0,1.0,1.0,1.0),
    target_temps=(None,None,None,None),
    #density
    singlescale=None,
    dens_dat="target.dat",
    externalf_1D=True,
    f_1D=mkslab(),
    #misc
    lspexec='lsp-10-xy',
    dir=True,
);

#realistic attempt
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
    res =(7000,
          7000,
          0),
    timestep = 3e-18,
    totaltime= 140e-15,
    fp=(-10.0,0.0,0.0),
    pbsbase='glycol45',
    description="hotglycol TNSA absorption",
    dumpinterval=6e-16,
    #PIC/grid details
    domains=24*21,
    region_split=('y',7),
    pbses='defaults',
    #target information
    lsptemplate="hotglycol.lsp",
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    thermal_energy=(1.0,1.0,1.0,1.0),
    target_temps=(None,None,None,None),
    #density
    singlescale=None,
    dens_dat="target45.dat",
    #misc
    lspexec='lsp-explicit-10-xy',
    dir=True,
    restart=23.95,
    dump_restart_flag=True,
    #movs
    movne=dict(clim=(1e17,1e23)),
    movrho=dict(clim=(-1e19,1e19),
                linthresh=1e15,),
    #pmovies
    no_pmovies=False,
    #particle dumps
    dump_particle=True,
    particle_dump_interval_ns=0.0,
    particle_dump_times_ns=(1.1e-4,1.4e-4),
    pext_species=(17,18),
);
if opts['--make-target']:
    try:
        targi = [int(opts['--make-target'])]
    except ValueError:
        targi = parse_ituple(opts['--make-target'], length=3);
elif opts['--make-targets']:
    targi = [0, 1, 2];
else:
    targi = [];
    
if 0 not in targi:
    print("be sure to make this dat {} seperately".format(0));
else:
    d['f_2D'] = mk45(
        dim   = (-5,5,-5,5),
        N0    = 1.0804e22,
        width = 0.46e-4,
        dropcorners=False);
    d['dat_xres'] = 10000;
    print("making targets...sit tight.");
gensim(**d);
splits = [
    #dom/reg regions
    (32,     7),
    (7*8,    7*4),
    (7*4,    7*8),
    (7*4,    7*4),
    (7*8,    7*8)];
glyscans = [
    sd(d,
       pbsbase='gly_{:02d}_{:02d}'.format(i,r),
       region_split=('y',r),
       discrete=(2,2,1),
       domains=i*r,)
    for i,r in splits];
def rm_targ(i):
    if 'f_2D' in i:
        del i['f_2D'];
        del i['dat_xres'];
        sh.copy('glycol45/target45.dat',i['pbsbase']);
    return i;
glyscans[:] = [rm_targ(i) for i in glyscans];
for i in glyscans:
    gensim(**i);
#smaller target
sml = sd(
    d,
    discrete=(2,2,1),
    lim = (-5.5, 5.5,
           -5.5, 5.5,
              0,   0),
    tlim= (-3.5, 3.5,
           -3.5, 3.5,
              0,   0),
    res = (5500,5500,0),
);
if 1 not in targi:
    print("be sure to make this dat {} seperately".format(1));
else:
    sml['f_2D'] = mk45(
        dim   = (-3.5, 3.5,
                 -3.5, 3.5),
        N0    = 1.0804e22,
        width = 0.46e-4,
        dropcorners=False);
    sml['dat_xres'] = 7000;
    print("making targets...sit tight.");

splits = [
    #dom/reg regions
    (32,     11),
    (11*8,   11*4),
    (11*4,   11*8)];
smlscans = [
    sd(sml,
       pbsbase='sml_{:02d}_{:02d}'.format(i,r),
       region_split=('y',r),
       discrete=(2,2,1),
       domains=i*r,)
    for i,r in splits];
for i in smlscans:
    gensim(**i);

#I give

coarse = sd(
    d,
    discrete=(2,2,1),
    res = (3500,3500,0),
);
splits = [
    #dom/reg regions
    (32,     7),
    (7*8,    7*4),
    (7*4,    7*8),
    (7*4,    7*4),
    (7*8,    7*8)];

if 2 not in targi:
    print("be sure to make this dat {} seperately".format(2));
else:
    coarse['f_2D'] = mk45(
        dim   = (-5,5,-5,5),
        N0    = 1.0804e22,
        width = 0.46e-4,
        dropcorners=False);
    coarse['dat_xres'] = 2500;
    print("making targets...sit tight.");

crsscans = [
    sd(coarse,
       pbsbase='crs_{:02d}_{:02d}'.format(i,r),
       region_split=('y',r),
       domains=i*r,)
    for i,r in splits];

for i in crsscans:
    gensim(**i);

#I give

coarser = sd(
    d,
    discrete=(3,3,1),
    res = (1400,1400,0),
    lspexec='lsp-10-xy',
    timestep=2e-17,
);
splits = [
    #dom/reg regions
    (32,     7),
    (7*8,    7*4),
    (7*4,    7*8),
    (7*4,    7*4),
    (7*8,    7*8)];

if 3 not in targi:
    print("be sure to make this dat {} seperately".format(2));
else:
    coarser['f_2D'] = mk45(
        dim   = (-5,5,-5,5),
        N0    = 1.0804e22,
        width = 0.46e-4,
        dropcorners=False);
    coarser['dat_xres'] = 1000;
    print("making targets...sit tight.");

crsscans = [
    sd(coarser,
       pbsbase='cr2_{:02d}_{:02d}'.format(i,r),
       region_split=('y',r),
       domains=i*r,)
    for i,r in splits];

for i in crsscans:
    gensim(**i);
