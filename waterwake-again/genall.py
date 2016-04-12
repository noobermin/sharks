#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
pbsbase = "waterwake-again"
lsp=genlsp(
    w=8.17e-6,
    T=120e-15,
    l=3e-6,
    I=1.52e17,
    fp=(0,0,0),
    lim=(-85,85,-35,35),
    res=(170*10,70*10),
    tlim=(-75,75,-20,20),
    timestep=1e-16,
    totaltime=1.2e-12,
    dumpinterval=5e-16,
    targetdat="steamjet.dat",
    description="longer micron lwfa?",
);
pbs = genpbs(pbsbase=pbsbase);
with open(pbsbase+".lsp","w") as f:
    f.write(lsp)
with open(pbsbase+".pbs","w") as f:
    f.write(pbs)
