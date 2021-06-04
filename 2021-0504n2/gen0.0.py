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
c = 299792458
#E = 0.5e-3; # 5mJ
implicit_species_flag = False;
N_species_explicit  = [
    ####################################
    dict(label = 'Nitrogen',
         implicit_species_flag = implicit_species_flag,
         charge = 0,
         mass = 25533.2,
         atomic_number = 7,
         scattering_flag = False,),
    dict(label = 'N+',
         implicit_species_flag = implicit_species_flag,
         charge = 1,
         mass = 25532.2,
         atomic_number = 7,
         scattering_flag = True,),
    dict(label = 'N++',
         implicit_species_flag = implicit_species_flag,
         charge = 2,
         mass = 25531.2,
         atomic_number = 7,
         scattering_flag = True,),
    dict(label = 'N3+',
         implicit_species_flag = implicit_species_flag,
         charge = 3,
         mass = 25530.2,
         atomic_number = 7,
         scattering_flag = True,),
    dict(label = 'N4+',
         implicit_species_flag = implicit_species_flag,
         charge = 4,
         mass = 25529.2,
         atomic_number = 7,
         scattering_flag = True,),
    dict(label = 'N5+',
         implicit_species_flag = implicit_species_flag,
         charge = 5,
         mass = 25528.2,
         atomic_number = 7,
         scattering_flag = True,),
    dict(label = 'N6+',
         implicit_species_flag = implicit_species_flag,
         charge = 6,
         mass = 25527.2,
         atomic_number = 7,
         scattering_flag = True,),
    dict(label = 'N7+',
         implicit_species_flag = implicit_species_flag,
         charge = 7,
         mass = 25526.2,
         atomic_number = 7,
         scattering_flag = True,),
    ####################################
    dict(label = 'H',
         implicit_species_flag = implicit_species_flag,
         charge = 0,
         mass = 1837.2,#correct should be 1837.4, but we subtract 0.2 for mom. cons.
         atomic_number = 1,
         scattering_flag = False,),
    dict(label = 'p',
         implicit_species_flag = implicit_species_flag,
         charge = 1,
         mass = 1836.2,
         atomic_number = 1,
         scattering_flag = True,),
    ####################################
    dict(label = 'e',
         implicit_species_flag = implicit_species_flag,
         charge = -1,
         mass = 1.0,
         scattering_flag = True,),];

N_creation_neutral = [
    dict(type='plasma',
         label = 'H',
         species = 9,
         momentum_flags = (False, False, False),),
    dict(type='plasma',
         label = 'N',
         species = 1,
         momentum_flags = (False, False, False),)];


higherstate = dict(
    type='higherstate', lim='full',
    electron_species=11,
    cross_sections = [0.0, 0.0, 0.0, 0.0,
                      0.0, 0.0, 0.0, 0.0,
                      0.0, 0.0, 0.0],
    interval = 1);

N_creation_other = [
    #oxygen states
    sd(higherstate,
       label = 'N -> N+',
       species = 1,
       ion_species = 2,
       ionization_potential =  14.5),
    sd(higherstate,
       label = 'N+ -> N++',
       species = 2,
       ion_species = 3,
       ionization_potential =  29.6),
    sd(higherstate,
       label = 'N++ -> N3+',
       species = 3,
       ion_species = 4,
       ionization_potential =  47.4),
    sd(higherstate,
       label = 'N3+ -> N4+',
       species = 4,
       ion_species = 5,
       ionization_potential =  77.5),
    sd(higherstate,
       label = 'N4+ -> N5+',
       species = 5,
       ion_species = 6,
       ionization_potential =  97.9),
    sd(higherstate,
       label = 'N5+ -> N6+',
       species = 6,
       ion_species = 7,
       ionization_potential = 552.1),
    sd(higherstate,
       label = 'N6+ -> N7+',
       species = 7,
       ion_species = 8,
       ionization_potential = 667.0),
    #good old good old
    sd(higherstate,
       label = 'H -> p',
       species = 9 ,
       ion_species = 10,
       ionization_potential = 13.6),];


discrete=(4,4,1)
species = N_species_explicit;
plasmacs = sdl(N_creation_neutral,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               density_flags    = (True,True,False),
               thermal_energy   = 0.007);
#liquid nitrogen density
# N2 : 0.8064 g/cc
# rho= 0.8064/(14.007*2)*6.022e23 = 1.734e22 N/cc
N2_0 = 1.734e22;

#no hydrogen
plasmacs[0]['density_function'] = dict(
    type=1,
    data=[0]);
#N2
plasmacs[1]['density_function'] = dict(
    type=51,
    #     rmin, n0,        L,    rmax
    data=[5e-4, N2_0, 0.4e-4,   10e-4]);
creation = plasmacs + N_creation_other;

###########
d=dict(
    dens_flags=(True,True,False),
    lim = (-17.6e-4, 17.6e-4,
           -17.6e-4, 17.6e-4,
             0.0e-4,  0.0e-4),
    tlim=( -10.0e-4, 10.0e-4,
           -10.0e-4, 10.0e-4,
            -0.0e-4,  0.0e-4),
    res = (1760,1760,0),
    description = "tight3d",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    #misc
    lspexec='lsp-10-xy -r',
    dir=True,
    totaltime=1168.0e-15, #call zero at 168e-15
    timestep =  40.0e-18,
    #restart_interval_ns=1e-15,
    restart_interval=25,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='2020defaults',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    region_splits = [('x',2),('y',1),('z',1)],
    domains=2*40,
    #newlaser
    new_multilaser=True,
    starting_funcnum = 1,
    I=1e19,
    T = 84e-15,#fitted elsewhere
    l = 0.800e-4,
    w0= 1.528e-4, #f/3
    fp= (0.0, 0.0, 0.0),
    multilaser=[
        dict(
            outlet          = 'xmin',
            laser_func_type = 85,
            laser_tfunctype = 16,
            laser_tcutoff   = 126e-15,
            laser_t0        = -17.6e-4*1e-2/c + 126e-15,
            
            laser_dir       = (1,0,0),
            laser_pol       = (0,1,0),
            laser_pol_type  = 87,
            lpmode          = (0,0),
        )],
    #target
    species  = species,
    creation = creation,
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
    pext_species=(2,3,4,5,6,7,8,11),

);

N=0
pbsfmt = 'N2_n{:02}_I={:0.0e}'
def mkpbsbase(N,I): return pbsfmt.format(N,I);
descrfmt = 'Liquid Nitrogen, I={}'
def mkdescr(N,I): return descrfmt.format(I);

d['pbsbase']     = mkpbsbase(N,d['I']);
d['description'] = mkdescr(N,d['I']);
gensim(**d);
