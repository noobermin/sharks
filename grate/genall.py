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
I = 1e15;
l = 0.8e-6
w0=70e-6 / np.sqrt(2*np.log(2))
T0=15e-15

from gengrate import mkgrate, mk45dum;

xmin=ymin=-70;
xmax=ymax= 70;
xres=yres=5600;
targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(xmin,xmax,
          ymin,ymax,
          0,0),
    tlim=(xmin,xmax,
          ymin,ymax,
          0,0),
    res =(xres,
          yres,
          0),
    timestep = 5e-17,
    totaltime=500e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='grate1',
    description="grate",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=44*4,
    region_split=('y',4),
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_type=40,    #misc
    lspexec='lsp-10-xy',
    dir=True,
    restart=11.95,
    dump_restart_flag=True,
    dump_number_densities_flag=False,
    dump_plasma_quantities_flag=False,
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_scalar=False,
    particle_dump_interval_ns=0.0,
    #
    movE=dict(
        clim=(EfromI(1e12),EfromI(2*I)),
    ),
    movB=dict(
        clim=(BfromI(1e14),BfromI(2*I)),
    ),

);
#conductors
def mkconds(dims,
            backout=1e-4,
            backin =0.5e-4,
            width = 0.460e-4):
    xmin,xmax,ymin,ymax = dims[:4];
    offset = 2*(backin+backout);
    #lower left corner
    lca=np.array([xmin,ymin])*1e-4 - backout;
    lcb=lca + np.array([1,0])*offset;
    lcc=lca + np.array([0,1])*offset;
    
    #upper right corner
    uca=np.array([xmax,ymax])*1e-4 + backout;
    ucb=uca - np.array([1,0])*offset;
    ucc=uca - np.array([0,1])*offset;
    
    return dict(conductors=[
        {'type':'TRILATERAL',
         'from':(lca[0],lca[1],0.0),
         'to'  :[
             (lcb[0],lcb[1],0.0),
             (lcc[0],lcc[1],0.0)]},
        {'type':'TRILATERAL',
         'from':(uca[0],uca[1],0.0),
         'to'  :[
             (ucb[0],ucb[1],0.0),
             (ucc[0],ucc[1],0.0)]}
    ]);
d.update(**mkconds(d['tlim']));


#species and target.
d.update(**dict(
    lsptemplate="hotglycol2_allemitters_neutrals.lsp",
    speciesl=['O0','C0','H','O1','C1','p','e'],
    fracs   =[2.0, 2.0,6.0,  2.0, 2.0, 6.0, 10.0],
    #there are two densities, one for plasma and one for neutrals.
    dens_type=40,
    dens_dat=('target_neutral.dat',)*3+('target_plasma.dat',)*4,
    thermal_energy=(
        0.02, 0.02, 0.02,
        0.02, 0.02, 0.02,
        1.0),
    target_temps=(
        None,None,None,None,
        None,None,None),
));
gensim(**d);
def gendats(di,
            h = 0.2e-4,
            w = 0.66e-4,
            spacing=0.66e-4,
            w0=w0*1e2,
            width=0.45e-4,
            N0=1.08e22,
            targw=450e-7,
            dat_xres=None):
    targ_plasma = mkgrate(
        N0=N0,
        spacing=spacing,
        w=w,
        h=h);
    targ_neutral = mk45dum(
        N0=N0,
        width=targw);
    print("making targets for {}".format(di['pbsbase']));
    dd = sd(di, f_2D = targ_plasma, dat_xres = dat_xres);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],'target_plasma.dat'),
        dat);
    dd = sd(d, f_2D = targ_neutral, dat_xres = dat_xres);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],'target_neutral.dat'),
        dat);
addtotargs(d,gendats);

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
