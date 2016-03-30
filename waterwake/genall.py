#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
#waterwake_3um
pbsbase = "waterwake"
lsp = genlsp(
    w=8.17e-6,
    T=120e-15,
    l=3e-6,
    I=5e17,
    fp=(0,0,0),
    lim=(-30,30,-20,20),
    res=(600*2,400*2),
    tlim=(-25,25,-15,15),
    timestep=1e-16,
    totaltime=2.5e-13,
    targetdat="steamjet.dat",
    description="micron lwfa?"
);
pbs = genpbs(pbsbase=pbsbase);
with open(pbsbase+".lsp","w") as f:
    f.write(lsp)
with open(pbsbase+".pbs","w") as f:
    f.write(pbs)
