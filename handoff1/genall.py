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
          -0.23, 23,
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
gensim(**d);
