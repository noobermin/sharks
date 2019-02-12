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
T0=30e-15
#from gen45 import mk45_clean_neutral2d;

targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

test1=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,False),
    discrete=(2,2,2),
    lim =(-15, 2.6, -8, 8, -8, 8),
    tlim=(-15, 2.6, -8, 8, -8, 8),
    res =(220,200,200),
    timestep = 1e-16,
    totaltime=100e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='newlasertest1',
    description="new laser test",
    dumpinterval=0.0,
    #regions
    domains=4*44,
    region_dom_split='x',
    region_splits=[
        ('y',2),
        ('z',2)],
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    lspexec='lsp-10-3d',
    dir=True,
    restart=1000,
    restart_interval=5,
    dump_restart_flag=True,
    #movs
    #pmovies
    no_pmovies=True,
    dump_particle=False,
    dump_scalar=False,
    dump_field=False,
    dump_time_zero_flag=None,
    dump_number_densities_flag=None,
    dump_plasma_quantities_flag=None,
    #new laser
    newlaser=True,
    laser_polarization=(0,1,0),
    laser_direction=(1,0,0),
    laserafunc=4,
);
#species and target.
test1.update(
    lsptemplate="hotwater3d_newlaser_tmpl.lsp",
    speciesl=['e','p','O+'],
    fracs   =[3.0, 2.0,1.0],
    dens_type=None,
    dens_dat=None,
    target_density = 0.0,
    target_density_plainconst=True,
    target_temps=(
        None,None,None),
);
gensim(**test1);
test2=sd(
    test1,
    lsptemplate="hotwater3d_laser86_tmpl.lsp",
    fp=(0.0,0.0,0.0),
    #       l p
    lpmode=(0,0),
    laser_t0=50.3e-15,
    pbsbase="newlasertest2",
    T=40e-15,
    lim =(-15, 2.6, -8, 8, -8, 8),
    tlim=(-15, 2.6, -8, 8, -8, 8),
    res =(220,220,200),
    timestep = 1e-16,
    totaltime=100e-15,
    #regions
    domains=44,
);
gensim(**test2);
if opts['--make-all-targets']:
    for d in targds:
        d['mktargf'](d);
elif opts['--make-target']:
    for d in targds:
        if d['pbsbase'] == opts['--make-target']:
            d['mktargf'](d);
            break;
    else:
        raise ValueError(
            "dict with pbsbase=='{}' not found".format(opts['--make-target']));
