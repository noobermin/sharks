#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
pbsbase = "hotwater2d_baseline"
lsp = genlsp(
    lim=(-30,5,-20,20),
    res=(52*32,50*32),
    tlim=(-27.5,0,-15,15),
    timestep=4e-16,);
pbs = genpbs(pbsbase=pbsbase);
with open(pbsbase+".lsp","w") as f:
    f.write(lsp)
with open(pbsbase+".pbs","w") as f:
    f.write(pbs)
