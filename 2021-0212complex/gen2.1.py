#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt, sdl;
from genlsp import gensim;

import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
#E = 0.5e-3; # 5mJ

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-5),BfromI(I*2)))

from genlsp.h2o_species import h2o_species_explicit as h2o_species;
from genlsp.h2o_species import h2o_creation_plasma_single, h2o_creation_other;
from genlsp.h2o_species import h2o_creation_neutral;
discrete=(2,2,2)
species = h2o_species;
plasmacs = sdl(h2o_creation_neutral,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 0.035);
creation = plasmacs + h2o_creation_other;

N=2
r=1
pbsbase0=f'nourc{N:02}r{r}';
las_fnum = 3;
xmin     = -10e-4;
c_cgs = 29979245800;
###########
d = dict(
    dens_flags=(True,False,False),
    lim = (xmin,    10.0e-4,
           -10.0e-4,16.4e-4,
           -13.2e-4,13.2e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res = (800, 1056, 528),
    description = "attempt to use nour's stuff",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d -r',
    dir=True,
    totaltime=1000e-15,
    timestep =5e-17,
    restart_interval=None,
    restart_interval_ns = 1e-15,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    #region_dom_split='y',
    #region_splits = [('x',1),('y',4),('z',3)],
    #domains=12*44,
    region_dom_split='z',
    region_splits = [('x',5),('y',2),('z',1)],
    domains=10*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = f'{pbsbase0}Ey_real.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),
            Ey_imag   = dict(
                dat = f'{pbsbase0}Ey_imag.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),
            Ez_real   = dict(
                dat = f'{pbsbase0}Ez_real.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),
            Ez_imag   = dict(
                dat = f'{pbsbase0}Ez_imag.dat',
                type= 60,
                imul= 1.0,
                dmul= 1.0),),],
    laser_t0 = -abs(xmin)/c_cgs + 60e-15,
    laser_tfunctype=16,
    laser_tcutoff = 60e-15,
    l = 0.8e-4,
    w0= 0.8e-4,
    fp = (0.0,0.0,0.0),
    I = 5e18,
    T = 60e-15,
    #target
    pbsbase = 'noura02',
    species = species,
    new_create=True,
    creation= creation,
    #scale
    fracs = [2,1],
    pill2_5D = dict(
        n_s  = 3.34e22,
        n_min= 1e17,
        L    = 0.05e-4,
        Lz   = 0.01e-4,
        height = 20e-4,
        length = 25e-4,
        half_width = 0.1e-4,
        rot    = 135,
        roundup_pp = True,
        round_unit = 0.1e-4,
        #xmargin    = 3e-4,
        #ymargin    = 3e-4,
        #zmargin    = 3e-4,
        keep_lim   = True,
    ),
    #probes
    probes = [
        dict(type = 'energy',
             measurement_type = 'net_energy'),
        dict(type = 'energy',
             measurement_type = 'total_energy'),
        dict(type = 'energy',
             measurement_type = 'particle_energy'),
        dict(type = 'energy',
             measurement_type = 'field_energy'),
        dict(type = 'performance',
             measurement_type = 'cpu_time')],
    #pext
    pext_species=(11,12),
);

Is = [5e19,5e20,5e21];
pbsfmt = pbsbase0+'_{:0.0e}';
def mkpbsbase(I): return pbsfmt.format(I);
descrfmt = 'High Intensity Complex beam interacting with matter, I={}'
def mkdescr(I): return descrfmt.format(I);

def mkI(Is, splittime=None):
    if splittime is None:
        return [
            sd(d, pbsbase=mkpbsbase(I),description=mkdescr(I),I=I,)
            for I in Is ];
    return [
        sd(d,
           splittime=splittime,
           pbsbase=mkpbsbase(I),description=mkdescr(I),I=I)
        for I in Is ];

ds = mkI(Is);


for di in ds:
    gensim(**di);
import subprocess;
import os;
import shutil;
def xlim2str(lim,res,dx=None):
    xlim = lim[0];
    if not dx:
        dx = (lim[1] - lim[0])/res[0];
    xmin,xmax = xlim-dx,xlim+dx;
    return f'({xmin:e},{xmax:e},3)';

def tlim2str(lim,res,ax,dx=None):
    tmin,tmax = lim[ax*2],lim[ax*2 + 1];
    return f'({tmin:e},{tmax:e},{res[ax]+1})';


cmdl = ['./nouranalytics.py',
        '--x-dims={}'.format(xlim2str(d['lim'],d['res'])),
        '--y-dims={}'.format(tlim2str(d['lim'],d['res'],1)),
        '--z-dims={}'.format(tlim2str(d['lim'],d['res'],2)),
        f'--f-num={las_fnum}',
        f'{pbsbase0}{{}}.dat'];
print("nouranalytics.py command:");
print(cmdl);
subprocess.run(cmdl);

dirs = [ f for f in os.listdir('.') if re.match(pbsbase0+'_',f) ]
dats = [ f for f in os.listdir('.') if re.match(pbsbase0+'.*\.dat$',f) ]
if len(dats) > 0:
    for idir in dirs:
        for dat in dats:
            print(f"{dat} > {idir}");
            shutil.copy(dat,idir);
    for dat in dats:
        os.remove(dat);


