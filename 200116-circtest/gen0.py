#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt;
from genpbs import genpbs;
from gensim import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
import re;
e0=8.854e-12
#E = 0.5e-3; # 5mJ

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-5),BfromI(I*2)))

###########
d=dict(
    dens_flags=(True,False,False),
    discrete=(2,2,2),
    lim =(  0.0, 1.1, 0.0, 5.0, 0.0, 0.0),
    tlim =( 0.0, 1.1, 0.0, 5.0, 0.0, 0.0),
    res =(1100,1000,0),
    description="RC test",
    #no outputs because we do restarts now!
    restarts_only = True,
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    #misc
    lspexec='lsp-10-xy',
    dir=True,
    totaltime=2e-9,
    timestep =20e-15,
    restart_interval=50,
    dump_restart_flag=True,
    email='ngirmang.1@osu.edu',
    pbses='defaults',
    lsptemplate='laseronly_tmpl200119.lsp',
    #units
    ux=1.0,
    #computational division
    region_dom_split='y',
    #region_splits = [],
    domains=88,
    #circuit
    manual_boundaries = [
        dict(
            lim=(0.1,10.0, 0.0, 0.0, 0.0, 0.0),
            circuit=1,
            label='circuit',
            type='outlet',
            model='potential',
            voltage_measurement = (0.0,1.1,0.0,0.0,0.0,0.0),),
        dict(
            lim=(0.1,10.0, 5.0, 5.0, 0.0, 0.0),
            label='top outlet',
            type='outlet',
            model='none'),
    ],
    circuits = [ dict(
        type='transline',
        segments = [ dict(length=1.0) ],
        termination='LCR',
        L = 0.0,
        C = 0.0,
        R = 5.0,
        V = 2.0), ],
    starting_funcnum = 1,
    #target
    no_matter = True,
    #anode
    objects = [
        dict(type='SOLID',
             potential=1,
             medium=0,
             label='cathode'),
        {'type':'BLOCK',
         'potential':0,
         'label':'vacuum',
         'condoff':'off',
         'medium':0,
         'from':(0.1,-0.1, 0.0),
         'to'  :(1.0, 5.1, 0.0),},
        {'type':'BLOCK',
         'potential':2,
         'label':'anode',
         'medium':0,
         'from':(1.0,-0.1, 0.0),
         'to'  :(1.2, 5.1, 0.0),},],

);
d['pbsbase'] = 'circtest00';
gensim(**d);

                
                
