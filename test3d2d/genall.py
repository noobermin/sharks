#!/usr/bin/env python3
from genlsp import genlsp;
from genpbs import genpbs;
from pys import sd,test;

def output(lsp,pbs,pbsbase,
           dats=["sine700points.dat","watercolumn.dat"],
           dir=None):
    if dir:
        mkdir(dir);
        pbsbase = dir+"/"+pbsbase;
        for dat in dats:
            sh.copy(dat, dir);
    with open(pbsbase+".lsp","w") as f:
        f.write(lsp);
    with open(pbsbase+".pbs","w") as f:
        f.write(pbs);
pbsbase="test3d2d";
lsp=genlsp(
    timestep=1e-17,
    totaltime=10e-15,
    lim=( -30, 5,
           -20,20,
             0,0),
    tlim=(-27.5,0,
          -15  ,15,
            0  ,0),
    res =(1400,
          8000,
             0));
pbs=genpbs(
    pbsbase=pbsbase,
    lspexec='lsp-10-xy'
);
output(lsp,pbs,pbsbase);
