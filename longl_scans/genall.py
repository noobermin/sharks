#!/usr/bin/env python3
from genlsp import genlsp;
from genpbs import genpbs;
import re;
import os;
from pys import sd,test;
import shutil as sh;
def mkdir(dir):
    os.makedirs(dir, exist_ok=True);

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
lsp_d=dict(
    l=3e-6, w=8.14e-6,I=5e17,
    T=120e-15,
    lim=(-40, 10, -20, 20),
    tlim=(-30, 0, -15, 15),
    res=(800, 800),
    description="long wavelength",
    targetdat="watercolumn.dat",
    timestep=8e-17);

def mksim(pbsbase,**d):
    print("making {}".format(pbsbase));
    myd = sd(lsp_d, **d);
    lsp=genlsp(**myd);
    pbs=genpbs(pbsbase=pbsbase);
    pbs = re.sub("../scripts/autozipper","../../scripts/autozipper",pbs);
    output(lsp,pbs,pbsbase,
           dats=["sine700points.dat", myd['targetdat']],
           dir=pbsbase);

Is = [5e17,1e18,3e18,1e19];
for I in Is:
    mksim("longl_{}".format(I),I=I);

for I in Is:
    mksim("longl_f20_{}".format(I),
          I=I,fp=(-20,0,0));

for I in Is:
    mksim("longl_{}-no-preplasma".format(I),
          I=I,
          lim=(-20,20,-25,25),
          tlim=(-10,10,-15,15),
          res=(800,1000),
          fp=(-5,0,0),
          totaltime=600e-15,
          pext_species=(10,11),
          targetdat="nopreplasma-thicker.dat",
          description="long wavelength, no preplasma");

for I in [2e17,1e18,3e18]:
    mksim("longl_longer-{}".format(I),
          I=I,
          lim=(-45,10,-20,20),
          tlim=(-35,0,-15,15),
          res=(1100,800),
          fp=(-20,0,0),
          targetdat="watercolumn-longer.dat",
          description="long wavelength, longer preplasma");

for I in [1e18,3e18,1e19]:
    mksim("longl_tnsa_{}".format(I),
          I=I,
          lim=(-20,20,-25,25),
          tlim=(-10,10,-15,15),
          res=(800,1000),
          fp=(-5,0,0),
          totaltime=2e-12,
          dumpinterval=5e-16,
          timestep=1e-16,
          no_pmovies=True,
          targetdat="nopreplasma-thicker.dat",
          pext_species=(10,11),
          description="long wavelength tnsa");


#now, high res tnsa
for I in [1e18,3e18,1e19]:
    mksim("longl_hrtnsa_{}".format(I),
          I=I,
          lim=(-20,20,-25,25),
          tlim=(-10,10,-15,15),
          res=(1600,2000),
          fp=(-5,0,0),
          totaltime=2e-12,
          dumpinterval=5e-16,
          timestep=5e-17,
          no_pmovies=True,
          targetdat="nopreplasma-thicker.dat",
          pext_species=(10,11),
          description="long wavelength tnsa");
    mksim("red_hrtnsa_{}".format(I),
          I=I,
          l=800e-9,
          w=2.2e-6,
          T=42e-15,
          lim=(-20,20,-25,25),
          tlim=(-10,10,-15,15),
          res=(1600,2000),
          fp=(-5,0,0),
          totaltime=2e-12,
          dumpinterval=5e-16,
          timestep=5e-17,
          no_pmovies=True,
          targetdat="nopreplasma-thicker.dat",
          pext_species=(10,11),
          description="long wavelength tnsa");

#these are simulations with longer scale length
def mkscale_sim(I=1e18,dat="5.625um",fp=(-4,0,0)):
    datf="water-{}.dat".format(dat);
    mksim("longl_l={}_{}".format(dat,I),
          lim=(-50,50,-25,25),
          tlim=(-40,40,-15,15),
          res=(1000,500),
          fp=fp,
          totaltime=400e-15,
          dumpinterval=5e-16,
          timestep=5e-17,
          no_pmovies=True,
          targetdat=datf,
          pext_species=(10,11),
          description="long wavelength with scale {}".format(dat));

[ mkscale_sim(I,dat,fp)
  for I in [2.1333e17,5e17,1e18,3e18]
  for dat in ["5.625um"]
  for fp in [(-40,0,0)]];


