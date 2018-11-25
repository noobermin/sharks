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


from gen45  import mk45_pinprick_plasma_old,mk45_pinprick_plasma,mk45_pinprick_neutral;
from gen45  import mk45_pinprick_neutral3d;

xmin=ymin=-15;
xmax=ymax= 15;
xres=yres= 30 * 50; #3000
targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

d=dict(
    l=3e-6,
    w=4e-6/np.sqrt(2*np.log(2)),
    T=120e-15,
    I=1e17,
    dens_flags=(True,True,False),
    discrete=(4,4,1),
    lim =(-55,55, -55, 55, 0, 0),
    tlim=(-54,54, -54, 54, 0, 0),
    res =(2200,2200,0),
    tref = (0.0, 0.0, 0.0),
    timestep = 1e-16,
    totaltime= 3e-13,
    fp=(0.0,0.0,0.0),
    dumpinterval=0,
    pbsbase='3umparta',
    description='observing target formation',
    #PIC/grid details
    domains=44*2,
    region_splits=[('y',2),('x',2)],
    pbses='defaults',
    lspexec='lsp-10-xy',
    dir=True,
    restart_interval=20,
    dump_restart_flag=True,
    pext_species=(10,),
    no_pmovies=True,
    #
    lsptemplate="hotwater3d_2_tmpl.lsp",
    speciesl=['e','O','p'],
    fracs   =[3.0,1.0,2.0],
    dens_type = None,
    dens_dat = None,
    target_density = 9.63e18,
    target_density_plainconst=True,
);
gensim(**d);
