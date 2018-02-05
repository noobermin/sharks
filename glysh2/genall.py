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

xmin=ymin=-35;
xmax=ymax= 35;
xres=yres= 35*2 * 100; #7000
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
    timestep = 2e-17,
    totaltime= 3e-12,
    fp=(0.0,0.0,0.0),
    pbsbase='glysh0',
    description="After TNSA expansion",
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
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    movrho=dict(
        clim=(-1e19,1e19),
        linthresh=1e15,),
    #pmovies
    no_pmovies=False,
    #particle dumps
    dump_particle=True,
    particle_dump_interval_ns=0.0,
    particle_dump_times_ns=(1e-4, 1.1e-4, 1.4e-4),
    pext_species=(17,18),
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


#species and target.
d.update(**dict(
    lsptemplate="hotglycol2_allemitters_neutrals.lsp",
    speciesl=[ 'e','O1','C1','p',
               'O0','C0','H'],
    fracs   =[10.0, 2.0, 2.0,6.0,
              2.0, 2.0,6.0],
    #there are two densities, one for plasma and one for neutrals.
    dens_type=40,
    dens_dat=('target_plasma.dat',)*4 + ('target_neutral.dat',)*3,
    #this is assuming the shoulder is 1e14 W/cm^2 at 12 picoseconds
    #using wilks scaling.
    thermal_energy=(
        #
        6.0, 0.01, 0.01, 0.01,
        #and (god help me) neutrals are...not
        0.01, 0.01, 0.01),
    target_temps=(
        None,None,None,None,
        None,None,None),
));

gensim(**d);
def gendats(di,
            w0=w0*1e2,
            width=0.46e-4,
            L=0.043e-4,
            N0=1.08e22,
            depth=0.086e-4,
            mindensity=1e18,
            dat_xres=None,
            new=False):
    if new:
        mkpinprick = mk45_pinprick_plasma
    else:
        mkpinprick = mk45_pinprick_plasma_old
    targ_plasma, targ_neutral = mkpinprick(
        dim = [i*1e-4 for i in d['tlim']],
        N0  = N0,
        laser_radius = w0,
        width = width,
        L = L,# 43nm
        depth = depth, #chosen arbitrarily
        mindensity=mindensity);
    if not dat_xres:
        dat_xres = di['res'][0]+1;
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
def gendatn(di,
            w0=w0*1e2,
            width=0.46e-4,
            L=0.043e-4,
            N0=1.08e22,
            mindensity=1e18,
            dat_xres=None):
    targ_neutral = mk45_pinprick_neutral(
        dim = [i*1e-4 for i in d['tlim']],
        N0  = N0,
        laser_radius = w0,
        width = width,
        L = L,# 43nm
        mindensity=mindensity);
    if not dat_xres:
        dat_xres = di['res'][0]+1;
    print("making targets for {}".format(di['pbsbase']));
    dd = sd(di, f_2D = targ_neutral, dat_xres = dat_xres);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],di['dens_dat']),
        dat);

addtotargs(d,gendats);
smd = sd(d,
         lim =(-5.0,5.0,
               -5.0,5.0,
               0,0),
         tlim=(-5.0,5.0,
               -5.0,5.0,
               0,0),
         res =(1000,
               1000,
               0),
         timestep = 2e-17,
         totaltime= 150e-15,
         dumpinterval=2e-17,
         dump_time_zero_flag=True,
         pbsbase='glyshs',
         no_pmovies=True,
);
smd.update(**mkconds(d['tlim'], backin=0.5e-4));
gensim(**smd);
addtotargs(smd,gendats);

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
smd2=sd(smd,**mkconds(smd['tlim'], backin=0.5e-4));
smd2.update(
    pbsbase='glysh1',
    domains=44*4,
    region_split=('y',4),
    dumpinterval=1e-16,
    movE=dict(
        clim=(EfromI(1e14),EfromI(1e19)),
        contour_lines=(1.7e21),
        contour_quantities=('RhoN17'),
    ),
);
gensim(**smd2);
addtotargs(smd2,lambda d:gendats(d,new=True));
reald = sd(
    d,
    domains=44*5,
    region_split=('y',5),
    dump_time_zero_flag=True,
    pbsbase='glysh2',
    movE=dict(
        clim=(EfromI(1e14),EfromI(1e19)),
        contour_lines=(1.7e21),
        contour_quantities=('RhoN17'),
    ),
    **mkconds(d['tlim'], backin=1e-4),
);
reald.update(
    lsptemplate="neutralglycol_allemitters.lsp",
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    dens_type=40,
    dens_dat='target_neutral.dat',
    thermal_energy=(
        0.02, 0.02, 0.02),
    target_temps=(
        None,None,None),
    particle_dump_interval_ns=0.0,
    particle_dump_times_ns=None,
    splittime=[
        (115e-15, None),
        (400e-15, dict(
            scalar_dump_interval_ns=3e-15,
            particle_dump_interval_ns=5e-16,
            no_pmovies= True,),),
        (3e-12,   dict(particle_dump_interval_ns=3e-15)),
    ],
);
gensim(**reald);
addtotargs(reald,gendatn);

zres = 600.0;
threed = sd(
    reald,
    dens_flags=(True,True,True),
    discrete=(2,2,2),
    lim =(xmin,xmax,
          ymin,ymax,
          -30.,30.0),
    tlim=(xmin,xmax,
          ymin,ymax,
          -30.,30.0),
    res =(xres,
          yres,
          zres),
    timestep = 2e-17,
    totaltime= 3e-12,
    fp=(0.0,0.0,0.0),
    pbsbase='glysh3',
    description="After TNSA expansion",
    dumpinterval=5e-16,
    #PIC/grid details
    domains=44*100,
    region_split=('y',100),
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=None,
    #misc
    lspexec='lsp-10-3d',
    dir=True,
    restart=11.95,
    dump_restart_flag=True,
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=True,
    particle_dump_interval_ns=0.0,
    pext_species=(17,),
    #species and target info
    lsptemplate="neutralglycol_allemitters.lsp",
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    dens_type=40,
    dens_dat='target_neutral.dat',
    thermal_energy=(
        0.02, 0.02, 0.02),
    target_temps=(
        None,None,None),
    splittime=[
        (115e-15, None),
        (400e-15, dict(particle_dump_interval_ns=6e-16)),
        (3e-12,   dict(particle_dump_interval_ns=3e-15)),
    ],

);

threed.update(
    mkconds(threed['tlim'], backin=1e-4));
threed['conductors'] += [
    dict(outlet='zmax',
         start=0.5e-4,
         width=1.0e-4),
    dict(outlet='zmin',
         start=0.5e-4,
         width=1.0e-4),];
gensim(**threed);

def gendat3d(
        di,
        w0=w0*1e2,
        width=0.46e-4,
        L=0.043e-4,
        N0=1.08e22,
        mindensity=1e18,
        dat_xres=None,
        dat_zres=4,#works for no z variation
        fmt='%.4e'
):
    targ_neutral = mk45_pinprick_neutral3d(
        dim = [i*1e-4 for i in d['tlim']],
        N0  = N0,
        laser_radius = w0,
        width = width,
        L = L,# 43nm
        mindensity=mindensity);
    if not dat_xres:
        dat_xres = di['res'][0]+1;
    print("making targets for {}".format(di['pbsbase']));
    dd = sd(di, f_3D = targ_neutral, dat_xres = dat_xres);
    dat = gendat(dat_zres=dat_zres,datfmt=fmt,**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],di['dens_dat']),
        dat);
addtotargs(threed, gendat3d);

mini3dlim = (-26,26,
       -26,26,
       -10,10);
mini3d = sd(
    threed,
    lim=mini3dlim,
    tlim=mini3dlim,
    res = (2600,2600,400),
    timestep =40e-18,
    totaltime=150e-15,
    pbsbase='glysh4',
    domains=44*20,
    region_split=('z',20),
    splittime=None,
);
mini3d.update(
    mkconds(mini3dlim, backin=0.5e-4));
mini3d['conductors'] += [
    dict(outlet='zmax',
         start=0.5e-4,
         width=1.0e-4),
    dict(outlet='zmin',
         start=0.5e-4,
         width=1.0e-4),];
gensim(**mini3d);
addtotargs(mini3d,gendat3d);

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
