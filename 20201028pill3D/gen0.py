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
from genlsp.genlsp import ItoE;
import noobna as nbna;

import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
#E = 0.5e-3; # 5mJ

from genlsp.h2o_species import h2o_species_explicit as h2o_species;
from genlsp.h2o_species import h2o_creation_plasma_single, h2o_creation_other;
discrete=(2,2,2)
species = h2o_species;
plasmacs = sdl(h2o_creation_plasma_single,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 1.0);
creation = plasmacs + h2o_creation_other;

###########
d=dict(
    dens_flags=(True,False,False),
    lim = (-11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4,
           -11.0e-4,11.0e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res = (528,528,440),
    description = "tight3d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=200e-15,
    timestep =5e-17,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',2),('z',2)],
    domains=8*44,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    T = 2.877e-15,#fitted elsewhere
    l = 0.710e-4,
    w0= 1.05e-4,
    fp= (0.710e-4, 0.0, 0.0),
    multilaser=[
        dict(
            laser_func_type = 54,
            outlet='xmin',
            timeshift_function = dict(
                type=60,
                dat = 'tshift.dat',),
            Ey = dict(
                type=60,
                dat = 'gaussEy.dat',),
            laser_tfunctype=60,
            laser_dat = 'tfunc.dat',
        ),
    ],
    #target
    species  = species,
    creation = creation,
    pill2_5D = dict(
        n_s  = 3.34e22,
        n_min= 1e17,
        L    = 0.350e-4,
        Lz   = 0.096e-4,
        height = 14e-4,
        length = 14e-4,
        half_width = 0.5e-4,
        rot    = 135,
        roundup_pp = True,
        round_unit = 1e-4,
        xmargin    = 1e-4,
        ymargin    = 1e-4,
        zmargin    = 3e-4,
    ),
    fracs = [1,2,3],
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

);

pbsfmt = 'targ_{:02}_p={:0.2f}_I={:0.0e}'
def mkpbsbase(N,phi,I): return pbsfmt.format(N,phi,I);
descrfmt = 'Target phase={}, I={}'
def mkdescr(N,phi,I): return descrfmt.format(N,phi,I);
N    = 2
phis = [0.0,0.25,0.5,0.75,1.0];
Is   = [1e19];
ds   = [ sd(d,
            pbsbase  =  mkpbsbase(N,phi,I),
            description = mkdescr(N,phi,I),
            I = I,
            phase = phi)
         for phi in phis
         for I   in Is ];


l  = 0.710e-4;
w0 = 1.05e-4;
xr = np.pi*w0**2/l;
c  = 29.9792458;
def gauss_w(x,xr,w0,fp=[0.0,0.0,0.0]):
    return w0*np.sqrt(1 + (np.abs(x-fp[0])/xr)**2);

def gauss_sp(x,y,z,fp=[0,0,0]):
    x-=fp[0];
    rs = y**2 + z**2;
    xa = np.abs(x)
    w  = w0*np.sqrt(1 + (xa/xr)**2);
    return np.exp(-rs/w**2) * w0/w;

def tshift(x,y,z,bv,fp):
    bv = np.array(bv) - np.array(fp);
    br = np.sqrt(np.sum(bv**2,axis=0));
    ds = np.sqrt((x-fp[0])**2 + (y-fp[1])**2 + (z-fp[2])**2)
    return (ds - br)/c;

def tfunc(t,T,phase=0.0):
    tau = T/np.sqrt(8*np.log(2))*1e9;
    return np.cos(2*np.pi*c*t/l + phase)*np.exp(-(t/tau)**2)

def tamp(d,i1,i2=None,inplace=True):
    '''
    d,bufi -> d to tamp, bufi elements from each end
    d,i1,i2 -> explicit indices to tamp, i1, and i2 are preserved (multiplied by 1.0)
    '''
    ret = d;
    if not inplace:
        ret = np.copy(d);
    if i2 is None:
        i1 -= 1
        i2  = len(d)-i1-1;
    if i1 > i2: i2,i1 = i1,i2;
    st = np.linspace(0.0,1.0,i1+1)*ret[i1];
    ret[:i1+1] = st;
    en = np.linspace(1.0,0.0,len(ret) - i2) * ret[i2];
    ret[i2:] = en;
    return ret;

def process_d(
        d,
        t_st =-20.1e-6,
        t_end=+20.1e-6,
        t_res=420,
        t_tampbuf=1e-7):
    pbsbase = d['pbsbase'];
    # get limits
    xmin,xmax = d['lim'][0:2];
    ymin,ymax = d['lim'][2:4];
    zmin,zmax = d['lim'][4:6];
    sh = d['res'];
    # dimensions
    y = np.linspace(ymin,ymax,sh[1]+1);
    z = np.linspace(zmin,zmax,sh[2]+1);
    dx = (xmax - xmin)/sh[0];
    x = np.arange(xmin - dx, xmin+dx*2, dx);
    X,Y,Z = np.meshgrid(x,y,z,indexing='ij');
    # time
    t = np.linspace(t_st,t_end,t_res+1);
    tbi = int(t_tampbuf/(t_end/t_res));
    
    # xmin reference point
    by = 0.5*(ymin+ymax)
    bz = 0.5*(zmin+zmax);
    Ey = gauss_sp(X,Y,Z,fp=d['fp']);
    Ts = tshift(X,Y,Z,[xmin,by,bz],d['fp']);
    #calculate timeshift
    #half diagonal distance
    #s = (xmax-xmin)*np.sqrt(3)/2.0 - 0.5*(xmax-xmin);
    #use gaussian distance
    w  = gauss_w(xmin,xr,w0,fp=d['fp']);
    print("gauss radius: {:+.2e}".format(w));
    rl = 5*w;
    xf = 0.5*(xmax-xmin);
    s  = np.sqrt(rl**2 + xf**2) - xf;
    d['timeshift'] =  -s/c*1e-9;
    print('timeshift={} vs min={}, diff={}'.format(
        d['timeshift']*1e9,Ts.max(),d['timeshift']*1e9+Ts.max()));
    Tf = tfunc(t,d['T'],phase=d['phase']);
    tamp(Tf,tbi);

    gensim(**d);
    nbna.output(
        '{}/{}'.format(pbsbase,'gaussEy.dat'),
        [x,y,z],
        Ey);
    nbna.output(
        '{}/{}'.format(pbsbase,'tshift.dat'),
        [x,y,z],
        Ts);
    nbna.output(
        '{}/{}'.format(pbsbase,'tfunc.dat'),
        [t],
        Tf);
    
for di in ds:
    process_d(di);
    

