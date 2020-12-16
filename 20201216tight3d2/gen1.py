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
    lim = (-8.8e-4,4.4e-4,
           -5.5e-4,5.5e-4,
           -5.5e-4,5.5e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res = (440,220,220),
    description = "tight3d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=50e-15,
    timestep =50e-18,
    restart_interval=20,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='x',
    region_splits = [('x',2),('y',2),('z',1)],
    domains=4*40,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    T = 7e-15,#fitted elsewhere
    l = 0.710e-4,
    w0= 1.05e-4,
    fp= (0.0, 0.0, 0.0),
    multilaser=[
        dict(
            laser_func_type = 57,
            outlet='xmin',
            Ey = dict(
                type=60,
                dat = 'gaussEy.dat',),
            Ez = dict(
                type=60,
                dat = 'gaussEz.dat',),
            laser_dat = 'tfunc.dat',
        ),
    ],
    #target
    no_matter = True,
    species   = species,
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

pbsfmt = 'tig3d2{:02}_p={:0.2f}_I={:0.0e}'
def mkpbsbase(N,phi,I): return pbsfmt.format(N,phi,I);
descrfmt = 'Tight, phase={}, I={}'
def mkdescr(N,phi,I): return descrfmt.format(N,phi,I);
N    = 1
phis = [0.0,0.5];
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
F  = w0/(2*l/np.pi)
w0 = 2*l*F/np.pi;
def gauss_w(x,xr,w0,fp=[0.0,0.0,0.0]):
    return w0*np.sqrt(1 + (np.abs(x-fp[0])/xr)**2);

def gauss_Ey(x,y,z,t,fp=[0,0,0]):
    x-=fp[0];
    rs = (y-fp[1])**2 + (z-fp[2])**2;
    xa = np.abs(x)
    w  = w0*np.sqrt(1 + (xa/xr)**2);
    gs = rs*x/( x**2 + xr**2);
    k  = 2*np.pi/l;
    phi = np.arctan(x/xr);
    T0  = 7e-6;
    tau = T0/np.sqrt(8*np.log(2));
    h   = x - c*t + gs
    
    Eysp = np.exp(-rs/w**2) * w0/w;
    Ey0  = Eysp*np.cos(k*(h+gs) - phi)

    q   = 1/(k*w0);
    #second order
    Ey2  = Eysp*np.cos(k*h - 3*phi)* q**2*(2*y**2 + rs)/w**2
    Ey2 += -q**2 * np.cos(k*h -4*phi)*rs**2/(w**3*w0)
    return (Ey0 + Ey2)*np.exp(-((t+gs/c)/tau)**2)

def gauss_Ez(x,y,z,t,fp=[0,0,0]):
    x-=fp[0];
    rs = (y-fp[1])**2 + (z-fp[2])**2;
    xa = np.abs(x)
    w  = w0*np.sqrt(1 + (xa/xr)**2);
    gs = rs*x/( x**2 + xr**2);
    k  = 2*np.pi/l;
    phi = np.arctan(x/xr);
    T0  = 7e-6;
    tau = T0/np.sqrt(8*np.log(2));
    h   = x-c*t;

    Ezsp = np.exp(-rs/w**2) * w0/w;
    
    q   = 1/(k*w0);
    Ez2  = 2*Ezsp*q**2 *y*z*np.cos(k*h - 3*phi)/w**2
    return Ez2*np.exp(-((t+gs/c)/tau)**2)
    

def process_d(
        d,
        t_st =-7e-6,
        t_end=+7e-6,
        dt = 5e-8,):
    pbsbase = d['pbsbase'];
    # get limits
    xmin,xmax = d['lim'][0:2];
    ymin,ymax = d['lim'][2:4];
    zmin,zmax = d['lim'][4:6];
    sh = d['res'];

    t  = np.arange(t_st-dt,t_end + 2*dt, dt);
    
    # dimensions
    
    y = np.linspace(ymin,ymax,sh[1]+1);
    z = np.linspace(zmin,zmax,sh[2]+1);
    dx = (xmax - xmin)/sh[0];
    x = np.arange(xmin - dx, xmin+dx*2, dx);
    T,X,Y,Z = np.meshgrid(t,x,y,z,indexing='ij');

    gensim(**d);
    print("making Ey for {}".format(pbsbase));
    Ey = gauss_Ey(T,X,Y,Z);
    Ey[ 0,:,:,:] = 0.0;
    Ey[-1,:,:,:] = 0.0;
    nbna.output(
        '{}/{}'.format(pbsbase,'gaussEy.dat'),
        [t-t[0],x,y,z],
        Ey);
    del Ey;
    
    print("making Ez for {}".format(pbsbase));
    Ez = gauss_Ey(T,X,Y,Z);
    Ez[ 0,:,:,:] = 0.0;
    Ez[-1,:,:,:] = 0.0;

    nbna.output(
        '{}/{}'.format(pbsbase,'gaussEz.dat'),
        [t-t[0],x,y,z],
        Ez);
    del Ez;
    
for di in ds:
    process_d(di);
    
