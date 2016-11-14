#!/usr/bin/env python3
from pys import sd;
from genpbs import genpbs,mk_hpcmp_pbses;
from gensim import gensim;
import numpy as np;
domains=72*100;
region_split=('z',72);
pbsbase="flashic_3da";
pbses = mk_hpcmp_pbses(
    pbsbase=pbsbase,
    domains=domains);
gensim(
    l = 0.8e-6,
    w = 2.26e-6,
    I = 3e18,
    T = 60e-15,
    lspexec='lsp-10-3d',
    fp=(0,0,0),
    tref=(0,0,0),
    dens_flags=(True,True,True),
    lim =( -71, 9, -18, 18,-18, 18),
    tlim=( -66, 4, -13, 13,-13, 13),
    res =( 80*10, 36*10, 36*10),
    totaltime=350e-15,
    dens_dat='flashic-20160816.dat',
    dens_type='50',
    pbsbase=pbsbase,
    description="Flash to LSP as IC in 3D",
    dumpinterval=5e-16,
    timestep=1e-16,
    domains=domains,
    region_split=region_split,
    pbses=pbses,
    restart=23.5,
    dir=True,
);
