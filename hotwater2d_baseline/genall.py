#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
pbsbase = "hotwater2d_baseline"
lsp = genlsp(
    lim=(-30,5,-20,20),
    res=(350*4,400*4),
    tlim=(-27.5,0,-15,15),
    no_pmovies=True,
    timestep=4e-17,
    dumpinterval=2e-16);
pbs = genpbs(pbsbase=pbsbase);
with open(pbsbase+".lsp","w") as f:
    f.write(lsp)
with open(pbsbase+".pbs","w") as f:
    f.write(pbs)
