#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
#waterwake_3um
pbsbase = "waterwake_longer"
lsp = genlsp(
    w=8.17e-6,
    T=60e-15,
    l=3e-6,
    I=1e17,
    fp=(0,0,0),
    lim=(-85,85,-25,25),
    res=(170*10,50*20),
    tlim=(-75,75,-15,15),
    timestep=1e-16,
    totaltime=1e-12,
    dumptime=5e-16,
    targetdat="steamjet.dat",
    description="longer micron lwfa?"
);
pbs = genpbs(pbsbase=pbsbase);
with open(pbsbase+".lsp","w") as f:
    f.write(lsp)
with open(pbsbase+".pbs","w") as f:
    f.write(pbs)
