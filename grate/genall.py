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

from gengrate import mkgrate, mk45dum, mkboth;

xmin=ymin=-100;
xmax=ymax= 100;
xres=yres=8000;
tmin=-70;
tmax=70;
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
    I=I,
    dens_flags=(True,True,False),
    discrete=(3,3,1),
    lim =(xmin,xmax,
          ymin,ymax,
          0,0),
    tlim=(tmin,tmax,
          tmin,tmax,
          0,0),
    res =(xres,
          yres,
          0),
    timestep = 5e-17,
    totaltime= 1e-12,
    fp=(0.0,0.0,0.0),
    pbsbase='grate1',
    description="grate",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=44*6,
    region_split=('y',6),
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
    dump_particle=True,
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
            width=0.45e-4,
            N0=1.08e22,
            targw=450e-7,
            datfmt="%.4e",
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
    if not dat_xres:
        dat_xres = di['res'][0]+1;
    dd = sd(di, f_2D = targ_plasma, dat_xres = dat_xres,datfmt=datfmt);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],'target_plasma.dat'),
        dat);
    dd = sd(d, f_2D = targ_neutral, dat_xres = dat_xres,datfmt=datfmt);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],'target_neutral.dat'),
        dat);
addtotargs(d,gendats);

lgd = sd(
    d,
    lim=(
        -80.0,80.0,
        -80.0,80.0,
        0,0),
    tlim=(
        -75,75,
        -75,75,
        0,0),
    res=(6400,6400,0),
    region_split=('y',10),
    domains=10*44,
    restart=5.75,
    particle_dump_interval_ns=1e-15,
    pbsbase='grate2',
);
lgd.update(**mkconds(lgd['tlim']));
gensim(**lgd)
addtotargs(lgd,lambda di: gendats(di,dat_xres=6401,h=0.25e-4,w=0.2e-4));

g3 =sd(
    lgd,
    pbsbase='grate3',);
g3.update(**dict(
    lsptemplate="hotglycol2_allemitters.lsp",
    speciesl=['O1','C1','p','e'],
    fracs   =[2.0, 2.0, 6.0, 10.0],
    #there are two densities, one for plasma and one for neutrals.
    dens_type=40,
    dens_dat='target_plasma.dat',
    thermal_energy=(
        0.02, 0.02, 0.02,1.0),
    target_temps=(
        None,None,None,None),
    conductors=None,
));
gensim(**g3);
def gendatb(di,
            h = 0.25e-4,
            w = 0.2e-4,
            spacing=0.66e-4,
            N0=1.08e22,
            targw=450e-7,
            datfmt="%.4e",
            dat_xres=None):
    targ_plasma = mkboth(
        N0=N0,
        spacing=spacing,
        w=w,
        h=h,
        width=targw);
    print("making targets for {}".format(di['pbsbase']));
    if not dat_xres:
        dat_xres = di['res'][0]+1;
    dd = sd(di, f_2D = targ_plasma, dat_xres = dat_xres,datfmt=datfmt);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],'target_plasma.dat'),
        dat);
addtotargs(g3,gendatb);
mingrate = sd(
    g3,
    w=2.2e-6/np.sqrt(2*np.log(2)),
    pbsbase='mingrate',
    lim=[-10,10,-10,10,0,0],
    tlim=[-9,9,-9,9,0,0],
    res=(800,800,0),
    region_split=('y',1),
    domains=44,
    totaltime=140e-15);
gensim(**mingrate);
addtotargs(mingrate,gendatb);

tgrate = sd(
    mingrate,
    w=2.2e-6/np.sqrt(2*np.log(2)),
    T=233e-15,
    lim=[-20,10,-10,20,0,0],
    tlim=[-8,8,-8,8,0,0],
    res=(1200,1200,0),
    domains=44,
    totaltime=700e-15,
    pbsbase='tgrate1',
    particle_dump_interval_ns=2e-15,
    movE=dict(
        clim=(8e9,1e11),
    ),);
gensim(**tgrate);
addtotargs(tgrate,lambda di: gendatb(di, dat_xres=801));

tg2 = sd(
    tgrate,
    w=4e-6/np.sqrt(2*np.log(2)),
    pbsbase='tgrate2');


gensim(**tg2);
addtotargs(tg2,lambda di: gendatb(di, dat_xres=801));


tg3 = sd(
    tgrate,
    lim=[-40,10,-10,20,0,0],
    tlim=[-7,7,-7,7,0,0],
    res=(2000,1200,0),
    domains=72,
    pbsbase='tgrate3');
gensim(**tg3);
addtotargs(tg3,lambda di: gendatb(di, dat_xres=801));

tg4 = sd(
    tg3,
    pbsbase='tgrate4');
gensim(**tg4);
addtotargs(tg4,lambda di: gendatb(di, dat_xres=801,w=0.5e-4));

tg5 = sd(
    tg4,
    pbsbase='tgrate5');
gensim(**tg5);
addtotargs(tg5,lambda di: gendatb(di, dat_xres=801,targw=1e-4));

tg6 = sd(tg4,pbsbase='tgrate6');
gensim(**tg6);
addtotargs(tg6,lambda di: gendatb(di, dat_xres=801,w=0.66e-4));

tg7 = sd(
    tg4,
    w=5e-6/np.sqrt(2*np.log(2)),
    pbsbase='tgrate7');
gensim(**tg7);
addtotargs(tg7,lambda di: gendatb(di, dat_xres=801,w=0.5e-4));


tg8 = sd(
    tg4,
    I=1e17,
    T=100e-15,
    w=4e-6/np.sqrt(2*np.log(2)),
    pbsbase='tgrate8');
gensim(**tg8);
addtotargs(tg8,lambda di: gendatb(di, dat_xres=801,w=0.5e-4));

tg7f = sd(
    tg7,
    pbsbase='tgrate7f',
    dumpinterval=5e-16,
    particle_dump_interval_ns=2e-15,
    totaltime=512e-15,
    timestep=2e-17,
    lim=[-40,10,-10,20,0,0],
    res=(5000,3000,0),
    domains=24*5);
gensim(**tg7f);
addtotargs(tg7f,lambda di:gendatb(di, dat_xres=1401,w=0.5e-4));

tg7g = sd(
    tg7f,
    discrete=(2,2,1),
    pbsbase='tgrate7g');
gensim(**tg7g);
addtotargs(tg7g,lambda di:gendatb(di, dat_xres=1401,w=0.5e-4));
tg9 = sd(
    tg7f,
    timestep=1.5e-17,
    domains=44*3, #this will not work unless you hack it
    pbsbase='tgrate9');
gensim(**tg9);
addtotargs(tg9,lambda di:gendatb(di, dat_xres=1401,w=0.5e-4));

tgA = sd(
    tg7f,
    w=2.2e-6/np.sqrt(2*np.log(2)),
    timestep=2e-17,
    totaltime=460e-15,
    lim=[-32,10,-10,20,0,0],
    res=(4200,3000,0),
    domains=44*3, #this will not work unless you hack it
    pbsbase='tgrateA');
gensim(**tgA);
addtotargs(tgA,lambda di:gendatb(di, dat_xres=1401,w=0.5e-4));

tgB = sd(
    tg7f,
    I=1e14,
    T=200e-15,
    w=4e-6/np.sqrt(2*np.log(2)),
    timestep=4e-17,
    totaltime=460e-15,
    lim=[-32,10,-10,20,0,0],
    res=(2100,1500,0),
    domains=44,
    pbsbase='tgrateB');
gensim(**tgB);
addtotargs(tgB,lambda di:gendatb(
    di, dat_xres=1401,w=0.5e-4,N0=1.08e21));

tgC = sd(
    tgB,
    domains=44,
    pbsbase='tgrateC');
gensim(**tgC);
addtotargs(tgC,lambda di:gendatb(
    di, dat_xres=1401,w=0.5e-4,N0=1.08e22));

tgD = sd(
    tgA,
    timestep=2e-17,
    totaltime=460e-15,
    lim=[-32,10,-10,16,0,0],
    res=(4200,2600,0),
    domains=44*3, #this will not work unless you hack it
    pbsbase='tgrateD');
gensim(**tgD);
addtotargs(tgD,lambda di:gendatb(
    di, dat_xres=1401,w=0.5e-4,N0=1.08e22));

tgE = sd(
    tgB,
    timestep=2e-17,
    totaltime=450e-15,
    lim=[-32,10,-10,18,0,0],
    res=(4200,2800,0),
    domains=44*3, #this will not work unless you hack it
    pbsbase='tgrateE');
gensim(**tgE);
addtotargs(tgE,lambda di:gendatb(
    di, dat_xres=1401,w=0.5e-4,N0=1.08e22));





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
