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
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15
from gen45 import mk45_clean_neutral2d;

targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

d3d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,True),
    dump_time_zero_flag=True,
    discrete=(2,2,2),
    lim =(-15.1, 20.1, -8, 8, -8, 8),
    tlim=(-14,   20.1, -8, 8, -8, 8),
    res =(704,160,160),
    timestep = 1e-16,
    totaltime=210e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='slab',
    description="drivewaves",
    dumpinterval=0.0,
    #regions
    domains=44,
    region_dom_split='x',
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    target_density = 1.37e19,
    target_density_plainconst=True,
    singlescale=None,
    lspexec='lsp-10-3d',
    dir=True,
    restart=1000,
    restart_interval=50,
    dump_restart_flag=True,
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=False,
    pext_species=(17,),
);
#species and target.
d3d.update(**dict(
    lsptemplate="neutralglycolnoH_allemitters.lsp",
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    #there are two densities, one for plasma and one for neutrals.
    thermal_energy=(
        0.025, 0.025, 0.025),
    target_temps=(
        None,None,None),
));
ns = [ sd(d3d,target_density=1.368e19/f,pbsbase="slab{}".format(f)) for f in [1,2,3,4] ]

for i in ns:
    gensim(**i);



