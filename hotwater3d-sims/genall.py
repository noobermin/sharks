#!/usr/bin/env python3

from genlsp import genlsp;
from genpbs import genpbs,mk_hpcmp_pbses
from gensim import gensim;
from pys import test,sd;
import re;
import os;
import shutil as sh;
lsp_d=dict(
    w=2.2e-6,
    T=80e-15,
    l=780e-9,
    I=3e18,
    fp=(0,0,0),
    lim= (-30, 5, -20,20, -20,20),
    res=( 35*10, 40*10, 40*10),
    tlim=(-27.5,0,-15,15,-15,15),
    timestep=1e-16,
    totaltime=500e-15,
    dumpinterval=5e-16,
    description="hotwater in 3d",
    dens_dat='watercolumn.dat',
    domains=700,
    region_split=('z',50),
    pext_species=(10,11),
    restart=23.95,
    dump_restart_flag=True,
);

Is= [5.4e17, 1e18, 1.5e18, 3e18, 1e19];
#vanillas
for I in Is:
    pbsbase="H2O-3d-{}".format(I);
    print(pbsbase);
    d = sd(
        lsp_d,
        I=I,
        pbsbase=pbsbase,
        pbses='defaults',
    );
    gensim(dir=True,**d);


for I in Is:
    pbsbase="H2Osm-3d-{}".format(I);
    print(pbsbase);
    d = sd(
        lsp_d,
        I=I,
        pbsbase=pbsbase,
        pbses='defaults',
        domains=192,
        region_split=('z',8),
    )
    gensim(dir=True,**d);

#more domains
#mksim(
#    "more-res",
#    I=I,
#    domains=700,
#    region_split=('z',100),
#);

#high res test

#mksim("highres-test",
#      I=3e18,
#      lim= (-30, 5, -20,20, -20,20),
#      res=( 35*20, 40*10, 40*10),
#      tlim=(-27.5,0,-15,15,-15,15),
#      domains=1400,
#      region_split=('z',100));
      
