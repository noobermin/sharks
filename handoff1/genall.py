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
from gensim_species import gensim, fromenergy, c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
e0 = 8.854e-12;
#E = 0.5e-3; # 5mJ
I = 5e18;
l = 0.78e-6
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

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
    dens_flags=(True,False,False),
    discrete=(4,3,1),
    lim =( 0, 200,
           -5.75,5.75,
           0,   0),
    tlim=(   35,200,
          -0.23, 0.23,
              0,  0),
    clim=(0,35,-5.75,5.75, 0,0),
    res =(800,
          500,
          0),
    timestep = 6e-17,
    totaltime= 2e-12,
    fp=(0.0,0.0,0.0),
    pbsbase='glysh2_ho1',
    description="bad glysh2 handoff1",
    dumpinterval=2.1e-15,
    #godsave me
    dump_time_zero_flag=True,
    field_initialization_flag=True,
    #PIC/grid details
    domains=44,
    pbses='defaults',
    #density
    tref = (0.0, 0.0, 0.0),
    singlescale=False,
    dens_type=30,#misc
    lspexec='lsp-10-xy',
    externalf_1D=True,
    new_externalf=True,
    f_1D=lambda x: np.ones(x.shape)*1.08e22,
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    lsptemplate="neutralglycol_allemitters_wrong_clusters.lsp",
    dens_dat='target_dumb.dat',
    dat_xres=2,
    thermal_energy=(
        0.02, 0.02, 0.02),
    target_temps=(
        None,None,None),
    dir=True,
    restart=11.8,
    dump_restart_flag=True,
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        clim=(1e19,1e23)),
    movrho=dict(
        clim=(-1e19,1e19),
        linthresh=1e15,),
    movE=dict(
        clim=(EfromI(1e14),EfromI(1e19)),
        contour_lines=(1.7e21),
        contour_quantities=('RhoN17'),
    ),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particles=True,
    
    pext_species=[17],
    conductors=[],
);
ion_species = [
    'O0', 'O+','O++','O3+','O4+','O5+','O6+','O7+','O8+',
    'C0', 'C+','C++','C3+','C4+','C5+','C6+',
    'e-', 'H0','p+'];
ion_species, ion_labels = zip(*enumerate(ion_species));
ion_species = list(ion_species);
ion_labels  = list(ion_labels);
del ion_species[16];
del ion_labels[16];
ion_species = [i+1 for i in ion_species];
d['clusters_spec'] =dict(
    ion_species=ion_species,
    ion_labels =ion_labels,
    electron_species=17,
    clims = d['clim'],
);

d3dlim = (
      5,     185,
     -5.75,    5.75,
    -92,      92) 
d3d = dict(
    l=1,
    w=0,
    T=0,
    I=0,
    dens_flags=(True,False,False),
    discrete=(2,2,1),
    lim=d3dlim,
    tlim=d3dlim,
    res=(900, 500, 920),
    timestep = 6e-17,
    totaltime= 2e-12,
    region_split=('z', 40),
    domains=1760,
    nolaser=True,
    dens_type=30,#misc
    lspexec='lsp-10-3d',
    externalf_1D=True,
    new_externalf=True,
    pbsbase="glysh8_ho1",
    f_1D=lambda x: np.ones(x.shape)*1.08e22,
    speciesl=['O0','C0','H'],
    fracs   =[2.0, 2.0,6.0],
    lsptemplate="neutralglycol_allemitters_fileread.lsp",
    dens_dat='target_dumb.dat',
    dat_xres=2,
    thermal_energy=(
        0.02, 0.02, 0.02),
    target_temps=(
        None,None,None),
    pbses='defaults',
    dir=True,
    restart=0.75,
    dump_restart_flag=True,
    dump_time_zero_flag=True,
    #movs
    movne=dict(
        ne_species = 'RhoN17',
        n_c=4*1.7e21,
        clim=(1e20,1e23)),
    movrho=dict(
        n_c=4*1.7e21,
        clim=(-1e19,1e19),
        linthresh=1e15,),
    movE=dict(
        n_c=4*1.7e21,
        clim=(EfromI(1e14),EfromI(1e19)),
        contour_lines=(1.7e21),
        contour_quantities=('RhoN17'),
    ),
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=True,
    dump_scalar=False,
    dump_number_densities_flag=False,
    dump_plasma_quantities_flag=False,
    spatial_skip_x=2,
    spatial_skip_z=2,
    dumpinterval=2.1e-15,
    pext_species=[17],
    conductors=[],
    fileread_spec = dict(
        lims = (
            5e-4,5e-4,
            -5.75e-4, 5.75e-4,
            -100e-4, 100e-4),
        fname='glysh8-synthpext.p4',
        tfunc=6,
    ),
    other_funcs='''
function6
type 3
coefficients 1 100e-6 ; 100fs
''',
);
gensim(**d3d);
d3dlim = (
      5,     181,
     -5.75,    5.75,
    -80,      80) 

d3d_coarser = sd(
    d3d,
    res=(440,500,400),
    spatial_skip_x=1,
    spatial_skip_z=1,
    region_split=('z',40),
    domains=44*40,
    pbsbase='glysh8_ho2',
);
gensim(**d3d_coarser);

mlim = (
     5.00,   93.00,
    -5.75,    5.75,
   -40.00,   40.00);
mres = (440, 500, 400)
g8ho3 = sd(
    d3d_coarser,
    lim = mlim,
    tlim= mlim,
    res = mres,
    region_split = ('z',40),
    domains=44*40,
    pbsbase='glysh8_ho3',
    other_funcs='''
function6
type 3
coefficients 1 7e-5 ; 70fs
''',);
gensim(**g8ho3);

#this is coarser in y
g8ho4 = sd(
    g8ho3,
    res=(440, 250, 400),
    region_split=('z',20),
    domains=44*20,
    pbsbase='glysh8_ho4');
gensim(**g8ho4);


g8ho5 = sd(
    g8ho4,
    discrete=(2,2,2),
    pbsbase='glysh8_ho5');
gensim(**g8ho5);

g8hi = sd(
    g8ho5,
    timestep=1e-16,
    lim = d3dlim,
    tlim= d3dlim,
    res = (880, 250, 800),
    discrete=(2,2,1),
    region_split=('z',40),
    domains=44*40,
    pbsbase='glysh8_hi1',
    fileread_spec = [
        dict(
            lims = (
                5e-4,5e-4,
                -5.75e-4, 5.75e-4,
                -80e-4, 80e-4),
            fname='glysh8-synthpext.p4',
            tfunc=6,),
        dict(
            lims = (
                5e-4,5e-4,
                -5.75e-4, 5.75e-4,
                -80e-4, 80e-4),
            fname='glysh8-synthpext-neutral.p4',
            species=19,
            tfunc=6,),],
    dumpinterval=2e-15,
);
gensim(**g8hi);
g8hi2 = sd(
    g8hi,
    lim=mlim,
    tlim=mlim,
    res = (880,250,800),
    pbsbase='glysh8_hi2',
    dumpinterval=2.5e-15,
    region_split=('z',50),
    domains=44*50,
    lsptemplate='neutralglycol_allemitters_fileread_partreduct.lsp',
        other_funcs='''
function6
type 3
coefficients 1 54e-6 ; 54fs
''',
);
gensim(**g8hi2);

g8hi3 = sd(
    g8hi2,
    pbsbase='glysh8_hi3',
    fileread_spec = dict(
        lims = (
            5e-4,5e-4,
            -5.75e-4, 5.75e-4,
            -80e-4, 80e-4),
        fname='glysh8-synthpext.p4',
        tfunc=6,),
    conductors=[
        dict(outlet='xmin',start=-0.1,width=1.0),
        dict(outlet='ymin',start=-0.1,width=1.0),
        dict(outlet='ymax',start=-0.1,width=1.0),],
);
gensim(**g8hi3);
