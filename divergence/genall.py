#!/usr/bin/env python3
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

from gen45  import mk45_pinprick_plasma_old,mk45_pinprick_plasma,mk45_pinprick_neutral;
from gen45  import mk45_pinprick_neutral3d;

xmin=ymin=-10;
xmax=ymax= 10;
xres=yres= 20 * 50; #7000
targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

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
    timestep = 4e-17,
    totaltime= 200e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='glysh0',
    description="After TNSA expansion",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=44*2,
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    dens_type=40,    #misc
    lspexec='lsp-10-xy',
    dir=True,
    restart=11.95,
    dump_restart_flag=True,
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    movrho=dict(
        clim=(-1e19,1e19),
        linthresh=1e15,),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=True,
    pext_species=(17,),
    splittime=[(200e-15, None), (1e-12, dict(timestep=1e-16))]
);
#conductors
def mkconds(dims,
            backout=1e-4,
            backin =5e-4,
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
d['conductors'] += [
    dict(
        outlet='xmax',
        start=0.5e-4,
        width=1.0e-4,
    ),
    dict(
        outlet='xmax',
        start=0.5e-4,
        width=1.0e-4,
    )]


#species and target.
d.update(**dict(
    lsptemplate="hotglycol2_allemitters.lsp",
    speciesl=[ 'e','O','C','p'],
    fracs   =[10.0, 2.0, 2.0,6.0],
    #there are two densities, one for plasma and one for neutrals.
    dens_type=40,
    dens_dat='target_plasma.dat',
    #this is assuming the shoulder is 1e14 W/cm^2 at 12 picoseconds
    #using wilks scaling.
    thermal_energy=(
        #
        6.0, 1.0, 1.0, 1.0
        #and (god help me) neutrals are...not
),
    target_temps=(
        None,None,None,None),
));

gensim(**d);

def gendatn(di,
            w0=w0*1e2,
            width=0.46e-4,
            L=0.043e-4,
            N0=1.08e22,
            mindensity=1e18,
            dat_xres=None,
            floor=0.0):
    targ_neutral = mk45_pinprick_neutral(
        dim = [i*1e-4 for i in d['tlim']],
        N0  = N0,
        laser_radius = w0,
        width = width,
        L = L,# 43nm
        mindensity=mindensity,
        floor=floor);
    if not dat_xres:
        dat_xres = di['res'][0]+1;
    print("making targets for {}".format(di['pbsbase']));
    dd = sd(di, f_2D = targ_neutral, dat_xres = dat_xres);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],di['dens_dat']),
        dat);
density_0 = 3.3e14
density_f = 3.3e17
denses = np.logspace(np.log10(density_0), np.log10(density_f), 5)
ds = []
for density in denses:
    d_mod=sd(d,
        pbsbase="d_v{:3.1e}".format(density),
    )
    gendat = lambda d_mod: gendatn(d_mod, floor=density)
    ds.append(d_mod)
    addtotargs(d_mod, gendat)
    gensim(**d_mod)

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
    
