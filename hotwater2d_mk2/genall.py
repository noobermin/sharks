#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
pbsbase = "hotwater2d_mk2"
lsp = genlsp(
    lim=(-40,12,-25,25),
    res=(52*32,50*32),
    tlim=(-27.5,0,-15,15),
    timestep=4e-17,);
pbs = genpbs(pbsbase=pbsbase);
with open(pbsbase+".lsp","w") as f:
    f.write(lsp)
with open(pbsbase+".pbs","w") as f:
    f.write(pbs)
