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
    dens_flags=(True,True,False),
    dump_time_zero_flag=True,
    discrete=(2,2,2),
    lim =(-16, 16, -16, 16, -22, 22),
    tlim=(-16, 16, -16, 16, -22, 22),
    res =(1600,1600,880),
    timestep = 4e-17,
    totaltime=90e-15,
    fp=(0.0,0.0,0.0),
    pbsbase='glyion1ro',
    description="ionization dynamics",
    dumpinterval=0.0,
    #regions
    domains=8*8*2*44,
    region_dom_split='z',
    region_splits=[
        ('x',8),
        ('y',8),
        ('z',2),],
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
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
    dump_particle=True,
    pext_species=(17,),
);
#species and target.
d3d.update(**dict(
    lsptemplate="neutralglycol_allemitters.lsp",
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    #there are two densities, one for plasma and one for neutrals.
    dens_type=40,
    dens_dat=('target_neutral.dat'),
    #this is assuming the shoulder is 1e14 W/cm^2 at 12 picoseconds
    #using wilks scaling.
    thermal_energy=(
        0.025, 0.025, 0.025),
    target_temps=(
        None,None,None),
));
def gendatclean(
        di,
        width=0.46e-4,
        N0=1.08e22,
        fmt='%.4e',):
    targ_neutral = mk45_clean_neutral2d(
        width=width,
        N0  = N0,);
    print("making targets for {}".format(di['pbsbase']));
    dd = sd(di,
            f_2D = targ_neutral,
            dat_xres=di['res'][0]+1,
            dat_yres=di['res'][0]+1);
    dat = gendat(datfmt=fmt,**dd);
    savetxt(
        "{}/{}".format(di['pbsbase'],di['dens_dat']),
        dat);
gensim(**d3d);
addtotargs(d3d,gendatclean);

d3dra = sd(d3d, domains=8*8*2*24*2, pbsbase='glyion1ra');
gensim(**d3dra);
addtotargs(d3dra, gendatclean);

d3danglea = sd(
    d3d,
    restart_interval=40,
    lim= (-8,  5,   -20,20, -20,20),
    tlim=(-0.23,0.23,-20,20, -20,20),
    res =(1300, 1600, 800),
    region_splits=[
        ('y',8),
        ('z',8)],
    region_dom_split='x',
    domains=(88*8*8),
    timestep = 2.5e-17,
    dens_type = None,
    dens_dat = None,
    target_density = 1.08e22,
    target_density_plainconst=True,
    pbsbase='glyions1o',
    #magic
    phases = [np.pi/4.0, 0.0, -20e-4],
)
gensim(**d3danglea);

d3dangleb = sd(
    d3d,
    restart_interval=40,
    lim= (-8,  7.5,  -20,20, -20,20),
    tlim=(-0.23,0.23,-20,20, -20,20),
    res =(1550, 1600, 800),
    totaltime=200e-15,
    region_splits=[
        ('y',10),
        ('z',10)],
    region_dom_split='x',
    domains=6600,
    timestep = 2.5e-17,
    dens_type = None,
    dens_dat = None,
    target_density = 1.08e22,
    target_density_plainconst=True,
    pbsbase='glyions2o',
    #magic
    phases = [np.pi/4.0, 0.0, -20e-4],
    #noneed for dumps
    dump_particle=False,
    dump_field=False,
    dump_scalar=False,
    dump_number_densities_flag=False,
    dump_plasma_quantities_flag=False,
    dump_time_zero_flag=False,
    dump_restart_steps=[1],
    
)
gensim(**d3dangleb);


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
