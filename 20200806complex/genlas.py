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
d = dict(
    dens_flags=(True,False,False),
    lim = (-20.0e-4,20.0e-4,
           -13.2e-4,13.2e-4,
           -13.2e-4,13.2e-4),
    tlim=( -2e-4,1.8e-4,
           -5e-4,5.0e-4,
           -5e-4,5.0e-4),
    res = (800, 528, 528),
    description = "attempt to use nour's stuff",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    totaltime=200e-15,
    timestep =5e-17,
    restart_interval=None,
    restart_interval_ns = 1e-15,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    #units
    ux=1.0,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    multilaser=[
        dict(
            laser_func_type = 56,
            outlet='xmin',
            laser_dir = (1,0,0),
            Ey_real   = dict(
                dat = 'nour01Ey_real.dat',
                imul= 1.0,
                dmul= 1.0),
            Ey_imag   = dict(
                dat = 'nour01Ey_imag.dat',
                imul= 1.0,
                dmul= 1.0),
            Ez_real   = dict(
                dat = 'nour01Ez_real.dat',
                imul= 1.0,
                dmul= 1.0),
            Ez_imag   = dict(
                dat = 'nour01Ez_imag.dat',
                imul= 1.0,
                dmul= 1.0),),],
    laser_t0 = -20e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.8e-4,
    w0= 2*0.8e-4*2/np.pi,#F/2
    fp = (0.0,0.0,0.0),
    I = 5e19,
    T = 60e-15,
    #target
    pbsbase = 'nref04',
    species = species,
    new_create=True,
    creation=[],
    no_matter=True,
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
    pext_species=(12,),
);

#regioning
#center
ycen   = zcen = [-13.2e-4,0,13.2e-4];
yints  = zints = list(zip(ycen[:-1],ycen[1:]));
xcints = [[ -6.8e-4, 6.8e-4 ]]
def lims_from_ints(xints,yints,zints):
    return [ [xmin,xmax,ymin,ymax,zmin,zmax]
            for xmin, xmax in xints
            for ymin, ymax in yints
            for zmin, zmax in zints ];

cenlims = lims_from_ints(xcints,yints,zints);

#front
xfints =  [[-20.0e-4, -6.8e-4]];
frlims =  lims_from_ints(xfints, yints, zints);
#back
xbints =  [[  6.8e-4, 20.0e-4]];
bklims =  lims_from_ints(xbints, yints, zints);

reglims = frlims + cenlims + bklims;
regtmpl = dict(
    domains = 44,
    split   = 'XSPLIT');
regions = [
    sd(regtmpl, lim = lim, i = i+1)
    for i,lim in enumerate(reglims)];
d['regions'] = regions;
d['domains'] = 44*len(regions);
#d['region_splits'] = [
#    ('x', 4), ('y',2), ('z',2)];
#d['domains'] = 44*4*2*2;
Is0 = [5e19]
pbsfmt = 'laserc3_{:0.0e}'
def mkpbsbase(I): return pbsfmt.format(I);
descrfmt = 'Laser test, I={}'
def mkdescr(I): return descrfmt.format(I);
ds = [ sd(d, pbsbase=mkpbsbase(I),description=mkdescr(I),I=I,)
       for I in Is0 ];


dref = sd(
    d,
    multilaser=[
        dict(
            laser_func_type = 86,
            outlet='xmin',
            laser_dir = (1,0,0),
            lpmode = (0,0),
            laser_pol_type = 87,
            laser_pol= (0,1,0),
        )],
    laser_t0 = -20e-15,
    laser_tfunctype=16,
    laser_tcutoff = 80e-15,
    l = 0.8e-4,
    w0= 2*0.8e-4*2/np.pi,#F/2
    fp = (0.0,0.0,0.0),
    I = 5e19,
    T = 60e-15,
    pbsbase='laserr3_{:0.0e}'.format(Is0[0]),
    description=mkdescr(Is0[0]));

ds += [dref];
ds += [sd(dref,
          laser_t0=0,
          pbsbase = 'laserr4_{:0.0e}'.format(Is0[0]),
          description = mkdescr(Is0[0]))];
for di in ds:
    gensim(**di);



