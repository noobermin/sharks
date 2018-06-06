#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --make-target=A         Make the target for the dict with pbsbase
                             of A.
     --make-all-targets      Make all targets.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt;
from genpbs import genpbs;
from genlsp import mkregion_str
from gensim import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
e0 = 8.854e-12;
#E = 0.5e-3; # 5mJ
I = 5e18;
l = 0.8e-6
w0=1.6e-6 / np.sqrt(2*np.log(2))
T0=15e-15
#from gen45 import mk45_clean_neutral2d;

targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

d3d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    lim =(-5, 1, -9, 2, -4, 4),
    res =(6*20,11*20,8*10),
    timestep = 1e-16,
    totaltime=50e-15,
    fp=(0.0,0.0,0.0),
    phases = [np.pi/4.0, 0.0, -9e-4],
    pbsbase='anglefreesp',
    description="lasertests: angle test",
    dumpinterval=1.0e-15,
    #regions
    domains=2*44,
    region_dom_split='y',
    #region_splits=[
    #    ('x',8),
    #    ('y',8),
    #    ('z',2),],
    pbses='defaults',
    #density
    lspexec='lsp-10-3d',
    lsptemplate='emonly_tmpl.lsp',
    dir=True,
    #restart_interval=10,
    dump_restart_flag=True,
    #movs
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=False,
    dump_field=True,
    dump_scalar=False,
    dump_number_densities_flag=False,
    dump_plasma_quantities_flag=False,
);
gensim(**d3d);
