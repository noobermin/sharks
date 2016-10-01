#!/usr/bin/env python3
from pys import sd;
from genpbs import genpbs;
from gensim import gensim, fromenergy;
import numpy as np;

pbsbase="glycol_tnsa";
defpbs = dict(
    pbsbase=pbsbase,
    pbsname=pbsbase+"_oakley",
    cluster='oakley',
    autozipper=False,
    queue=None,
    ppn=None,    
);
pbses=[
    defpbs,
    sd(
        defpbs,
        pbsname=pbsbase+"_garnet_debug",
        cluster='garnet',
        queue='debug'),
    sd(
        defpbs,
        pbsname=pbsbase+"_garnet",
        cluster='garnet',
        queue='standard_lw'),
    sd(
        defpbs,
        pbsname=pbsbase+"_garnet_24",
        cluster='garnet',
        queue='standard_sm',
        walltime=24),
    sd(
        defpbs,
        pbsname=pbsbase+"_garnet_48",
        cluster='garnet',
        queue='standard_lw',
        walltime=48),
    sd(
        defpbs,
        pbsname=pbsbase+"_armstrong_debug",
        cluster='armstrong',
        queue='debug'),
    sd(
        defpbs,
        pbsname=pbsbase+"_armstrong",
        cluster='armstrong',
        queue='standard'),
    sd(
        defpbs,
        pbsname=pbsbase+"_armstrong_48",
        cluster='armstrong',
        queue='standard',
        walltime=48),

];
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
    domains=200,
    pext_species=(16,17),
    region_split=('y',2),
    pbses=pbses,
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
