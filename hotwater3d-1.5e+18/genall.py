#!/usr/bin/env python

from genlsp import genlsp;
from genpbs import genpbs;
pbsbase = "hotwater3d-1.5e+18"

lsp_d=dict(
    w=2.2e-6,
    T=40e-15,
    l=780e-9,
    I=1.5e18,
    fp=(0,0,0),
    lim= (-31,   4,-10,10,-10,10),
    res=( (34+8)*12, 22*12, 32*12),
    tlim=(-27.5, 0,-5,5,-5,5),
    timestep=4e-17,
    totaltime=500e-15,
    dumpinterval=5e-16,
    targetdat="watercolumn.dat",
    description="in 3d",
    region
);
pbs = genpbs(pbsbase=pbsbase);

def mkdir(dir):
    os.makedirs(dir, exist_ok=True);

def mksim(pbsbase,**d):
    print("making {}".format(pbsbase));
    myd = sd(lsp_d, **d);
    lsp=genlsp(**myd);
    pbs=genpbs(pbsbase=pbsbase);
    pbs = re.sub("../scripts/autozipper","../../scripts/autozipper",pbs);
    mkdir(pbsbase);
    
    pbsbase = dir+"/"+pbsbase;
    dats = ["sine700points.dat", myd['targetdat']];
    for dat in dats:
        sh.copy(dat, dir);
    with open(pbsbase+".lsp","w") as f:
        f.write(lsp);
    with open(pbsbase+".pbs","w") as f:
        f.write(pbs);

