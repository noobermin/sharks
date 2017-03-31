#!/usr/bin/env python3
'''
Usage: 
    ./genall.py [options]

Options:
     --make-targets
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd;
from genpbs import genpbs;
from gensim import gensim, fromenergy;
import numpy as np;

pbsbase="glycol_tnsa";
E = 0.5e-3; # 5mJ
w = 1.7e-6;
I = 5e18;
T = 2.0 * 5e-3/(w**2*np.pi/2.0 * I*1e4)
l = 0.78e-6
def mkslab(
        dim=2,
        n=1.0800215e+22,# 1.1132[g/cc] / 62.07[g/mol] * 6.022e23[N/mol] 
        lower_edge=0,
        unit=1e-4,):
    dim*=unit;
    lower_edge*=unit;
    @np.vectorize
    def f(x):
        if lower_edge <= x <= dim+lower_edge:
            return n;
        return 0.0;
    return f;
#custom regioning
#split y by half
#and   z by n
gensim(
    l = l,
    w = w,
    T = T,
    I = I,
    fp=(-0.1,0,0),
    tref=(0,0,0),
    dens_flags=(True,True,True),
    lim =(
        -2.5, 2.5,
        -8.5, 8.5,
           0,   0),
    tlim=(
        -0.1, 0.1,
        -6.0, 6.0,
           0,   0),
    res =(1000,3400, 0),
    timestep =1e-17,
    totaltime=70e-15,
    pbsbase=pbsbase,
    description="hotglycol TNSA stage 1",
    dumpinterval=5e-17,
    #PIC/grid details
    domains=48*8,
    pext_species=(17,18),
    region_split=('y',8),
    pbses='defaults',
    #target information
    lsptemplate="hotglycol.lsp",
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    #density
    singlescale=None,
    dens_dat="target.dat",
    externalf_1D=True,
    f_1D=mkslab(),
    #misc
    lspexec='lsp-10-xy',
    dir=True,
);

#realistic attempt
w0=2.2e-6 / np.sqrt(2*np.log(2))
T0=42e-15

from genangletarg import mk45;
d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=5e18,
    dens_flags=(True,True,False),
    discrete=(4,4,1),
    lim =(-7,7,
          -7,7,
           0,0),
    tlim=(-5,5,
          -5,5,
           0,0),
    res =(7000,
          7000,
          0),
    timestep = 3e-18,
    totaltime= 140e-15,
    pbsbase='glycol45',
    description="hotglycol TNSA absorption",
    dumpinterval=3e-17,
    #PIC/grid details
    domains=24*21,
    pext_species=(17,18),
    region_split=('y',21),
    pbses='defaults',
    #target information
    lsptemplate="hotglycol.lsp",
    speciesl=[ 'e', 'O', 'C', 'p'],
    fracs   =[10.0, 2.0, 2.0, 6.0],
    #density
    singlescale=None,
    dens_dat="target45.dat",
    #misc
    lspexec='lsp-explicit-10-xy',
    dir=True,
);
if not opts['--make-targets']:
    print("be sure to make the target dats seperately");
else:
    d['f_2D'] = mk45(
        dim   = (-5,5,-5,5),
        N0    = 1.0804e22,
        width = 0.5e-4,
        dropcorners=False);
    d['dat_xres'] = 5000;
    print("making targets...sit tight.");
gensim(**d);
