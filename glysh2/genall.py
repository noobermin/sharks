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

from gen45  import mk45_pinprick_plasma_old,mk45_pinprick_plasma,mk45_pinprick_neutral;
from gen45  import mk45_pinprick_neutral3d;
from gen45  import mk0_pinprick_neutral3d;

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
    cond_threshold=0,
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
    movB=dict(
        clim=(BfromI(1e14),BfromI(1e19)),
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
    cond_threshold=1/10e-7,
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
    restart=11.75,
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
    cond_threshold=1/20e-7,
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
    totaltime=200e-15,
    pbsbase='glysh4',
    domains=44*150,
    region_split=('y',75),
    dump_scalar=False,
    dump_plasma_quantities_flag=False,
    dump_number_densities_flag=False,
    dump_particle=True,
    timestep =40e-18,
    dumpinterval=2e-15,
    cond_threshold=1/20e-7,
    splittime=[
        (28e-15, None),
        (160e-15, dict(
            dumpinterval=2e-15,
            particle_dump_interval_ns=1e-15)),
        (250e-15, dict(
            field_dump_interval_ns=5e-15,)),
    ],
);
del mini3d['particle_dump_interval_ns'];
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

minierlim = (-26,26,
             -26,26,
             -6,6);
minier = sd(
    threed,
    lim=(-20,20,
         -20,20,
          -6,6),
    tlim=(-20,20,
          -20,20,
          -6,6),
    res = (2000,2000,240),
    timestep =40e-18,
    totaltime=150e-15,
    pbsbase='glysh5',
    domains=44*50,
    region_split=('y',50),
    splittime=None,
);
minier.update(
    mkconds(mini3dlim, backin=0.5e-4));
minier['conductors'] += [
    dict(outlet='zmax',
         start=0.5e-4,
         width=1.0e-4),
    dict(outlet='zmin',
         start=0.5e-4,
         width=1.0e-4),];
gensim(**minier);
addtotargs(minier,gendat3d);




mini3d_redo = sd(
    mini3d,
    region_split=None,
    pbsbase='glysh6',
    splittime=[
        (160e-15, dict(particle_dump_interval=1e-15)),
        (250e-15, dict(field_dump_interval=5e-15)),
    ]);
#manual regioning
r0 = dict(
    domains=88,
    xmin=-26e-4,
    xmax= 26e-4,
    split="XSPLIT")
zs=[
    -10e-4,-7e-4,-4e-4,-1e-4,
    1e-4,  4e-4,  7e-4, 10e-4];
zp=[(zn,zx) for zn, zx in zip(zs,zs[1:])]
ys=[-26e-4,-18.6e-4,-11.2e-4, -3.7e-4, 3.7e-4, 11.2e-4, 18.6e-4, 26e-4]
yp=[(yn,yx) for yn, yx in zip(ys,ys[1:])]
rs = [
    sd(r0, zmin=zn,zmax=zx,ymin=yn,ymax=yx)
    for yn,yx in yp for zn,zx in zp]
for i,r in enumerate(rs):
    r['i']=i+1;
mini3d_redo['regions'] = mkregion_str(rs,split_cells=2600);
mini3d_redo['domains'] = 88*len(rs);
mini3d_redo.update(
    mkconds(mini3dlim, backin=0.5e-4));
mini3d_redo['conductors'] += [
    dict(outlet='zmax',
         start=-0.1,
         width=1.0),
    dict(outlet='zmin',
         start=-0.1,
         width=1.0),];
gensim(**mini3d_redo);
addtotargs(mini3d_redo,gendatn);
mini3d_another=sd(
    mini3d_redo,
    region_split=('z', 100),
    domains=6600,
    regions=None,
    pbsbase='glysh7');
gensim(**mini3d_another);
addtotargs(mini3d_another,gendatn);

mini3d_rtw=sd(
    mini3d,
    pbsbase='glysh8',
    dumpinterval=10e-15,
    cond_threshold=1/20e-7,
    splittime=[
        (50e-15, None),
        (160e-15, dict(
            dumpinterval=4e-15,
            particle_dump_interval_ns=2e-15)),
        (250e-15, dict(
            dumpinterval=2e-15,
            field_dump_interval_ns=10e-15,)),
    ],
);
mini3d_rtw.update(
    mkconds(mini3dlim, backin=0.5e-4));
mini3d_rtw['conductors'] += [
    dict(outlet='zmax',
         start=-0.1,
         width=1.0),
    dict(outlet='zmin',
         start=-0.1,
         width=1.0),];
gensim(**mini3d_rtw);
addtotargs(mini3d_rtw,gendatn);

larger = (
    -26,26,
    -26,26,
    -26,26);
lgres = (2600,2600,1040)
lgd1 = sd(
    mini3d);
lgd1.update(
    mkconds(mini3dlim, backin=0.5e-4));

# here we go
rotlim = (
    -25,25,
    -20,20,
    -25,25);
rotres = (
    2500,
    2000,
    1000,)
    
rot3d = sd(
    threed,
    nolaser=True,
    lim =(-25, 25, -20,20, -25,25),
    tlim=(-25, 25, -1,0.5,   -25,25),
    res = (2500,   2000, 1000),
    totaltime=200e-15,
    pbsbase='glysh8_hj1',
    domains=44*240,
    region_split=('z',120),
    dump_scalar=False,
    dump_plasma_quantities_flag=False,
    dump_number_densities_flag=False,
    dump_particle=True,
    dump_field=True,
    dumpinterval=0,
    dump_time_zero_flag=True,
    dump_restart_ns=2e-15,
    lsptemplate="neutralglycol_allemitters.lsp",
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    dens_type=50,
    dens_dat='target_neutral.dat',
    thermal_energy=(
        0.02, 0.02, 0.02),
    target_temps=(
        None,None,None),
    splittime=[
        (1e-15, None),
        (200e-15, dict(
            dump_particle=False,
            dump_field=False,))
    ],
    conductors=[],
);
def gendatrot(
        di,
        w0=w0*1e2,
        width=0.46e-4,
        L=0.043e-4,
        N0=1.08e22,
        mindensity=1e18,
        spotz_width=20e-4,
        yres = 75,
        fmt='%.4e',):
    print("warning: this will only work for rot3d");
    targ_neutral = mk0_pinprick_neutral3d(
        N0  = N0,
        spotz_width=spotz_width,
        laser_radius = w0,
        width = width,
        L = L,# 43nm
        mindensity=mindensity);
    #manual hacks to save space
    #generate cell sized samples around the corners.
    # x's edge
    def getsamples(point,lims,res,ndxs = 3):
        out=np.linspace(lims[0]*1e-4,lims[1]*1e-4,res+1);
        dx = out[1] - out[0];
        out = out[ out >= point - ndxs*dx ];
        out = out[ out <= point + ndxs*dx ];
        return list(out);
    def axissamples(half_width, tlim, lim, res,ndxs=3):
        p = [ tlim[0] ] + getsamples(-half_width,lim,res,ndxs=ndxs)
        p+= [0.0] + getsamples(half_width,lim,res,ndxs=ndxs)
        p+= [ tlim[1] ];
        return np.array(p);
    x = axissamples(
        w0, di['tlim'][0:2], di['lim'][0:2], di['res'][0]);
    y = np.linspace(
        di['tlim'][2]*1e-4,di['tlim'][3]*1e-4,yres+1);
    z = axissamples(
        spotz_width/2.0,
        di['tlim'][4:6], di['lim'][4:6], di['res'][2]);
    print("making targets for {}".format(di['pbsbase']));
    X,Y,Z=np.meshgrid(x,y,z,indexing='ij');
    Q=targ_neutral(X,Y,Z)
    dd = sd(di, data3D =(x,y,z,Q), datfmt=fmt);
    dat = gendat(**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],di['dens_dat']),
        dat);
gensim(**rot3d);
addtotargs(rot3d,gendatrot);



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
