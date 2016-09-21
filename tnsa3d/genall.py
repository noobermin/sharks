#!/usr/bin/env python3
from pys import sd;
from genpbs import genpbs;
from gensim import gensim;
import numpy as np;
domains=1000;
region_split=('z',68);
pbsbase="tnsa3d_s1";
defpbs = dict(
    pbsbase=pbsbase,
    pbsname=pbsbase+"_oakley",
    domains=domains,
    cluster='oakley',
    autozipper=False,
    queue=None,
    ppn=None,);
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
        pbsname=pbsbase+"_garnet_short",
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
        pbsname=pbsbase+"_armstrong_short",
        cluster='armstrong',
        queue='standard',
        walltime=48),

];

def mkslab(
        dim=2,
        n=1e23,
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

gensim(
    l = 0.8e-6,
    w = 2.2e-6,
    I = 1e18,
    T = 84e-15,
    lspexec='lsp-10-3d',
    fp=(0,0,0),
    tref=(0,0,0),
    dens_flags=(True,True,True),
    lim =( -5, 20, -20, 20, -20, 20),
    tlim=(  0,  2, -15, 15, -15, 15),
    res =( 25*20, 40*20, 40*20),
    totaltime=250e-15,
    pbsbase=pbsbase,
    description="LSP TNSA stage 1",
    dumpinterval=5e-16,
    timestep=0.5e-16,
    domains=125*200,
    region_split=('z',200),
    pbses=pbses,
    restart=23.75,
    #density
    singlescale=None,
    dens_dat="target.dat",
    externalf_1D=True,
    f_1D=mkslab(),
    dir=True,
);
