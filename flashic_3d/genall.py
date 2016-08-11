#!/usr/bin/env python3
from pys import sd;
from genpbs import genpbs;
from gensim import gensim;
import numpy as np;
domains=1000;
region_split=('z',68);
pbsbase="flashic_3d";
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
        walltime=48),];
gensim(
    l = 0.8e-6,
    w = 2.26e-6,
    I = 3e18,
    T = 60e-15,
    lspexec='lsp-10-3d',
    fp=(0,0,0),
    lim =( -41, 9, -17, 17,-17, 17),
    tlim=( -36, 4, -12, 12,-12, 12),
    res =( 50*10, 34*10, 34*10),
    totaltime=250e-15,
    dens_dat='flashic-20160810.dat',
    dens_type='50',
    pbsbase=pbsbase,
    description="Flash to LSP as IC in 3D",
    dumpinterval=5e-16,
    timestep=1e-16,
    domains=1000,
    region_split=('z',68),
    pbses=pbses,
    restart=23.95,
);
