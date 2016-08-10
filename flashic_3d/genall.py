#!/usr/bin/env python3
from pys import sd;
from gensim import gensim;
import numpy as np;
gensim(
    l = 0.8e-6,
    I = 3e18,
    T = 60e-15,
    lspexec='lsp-10-3d',
    fp=(0,0,0),
    lim =( -35, 15, -17, 17,-17, 17),
    tlim=( -30, 10, -12, 12,-12, 12),
    res =( 50*10, 34*10, 34*10),
    totaltime=250e-15,
    dens_dat="flashic-20160810.dat",
    pbsbase="flashic_3d",
    description="Flash to LSP as IC in 3D",
    dumpinterval=5e-16,
    timestep=1e-16,
);
