#!/usr/bin/env python3
from genlsp import genlsp;
from genpbs import genpbs;
from gendat import gentargetdat,tlim_mvorig
import re;
import os;
from pys import sd,test;
import shutil as sh;
import numpy as np;
def mkdir(dir):
    os.makedirs(dir, exist_ok=True);

def output(dir='.',files=["sine700points.dat","watercolumn.dat","autozipper"]):
    if dir:
        mkdir(dir);
    for fname in files:
        if type(fname) == str:
            sh.copy(fname,dir);
        else:
            fname,outstr=fname;
            with open(dir+"/"+fname,'wb') as f:
                if type(outstr) == str:
                    outstr=outstr.encode('ascii');
                f.write(outstr);
    pass;
def scaletuple(t,scale=1e-4):
    return tuple([it*scale for it in t]);

lsp_d=dict(
    l=10e-6,
    description="10 um");

def mksim(pbsbase,**d):
    print("making {}".format(pbsbase));
    myd = sd(lsp_d, **d);
    lsp=genlsp(**myd);
    pbs=genpbs(pbsbase=pbsbase,lspexec='lsp-10-xy');
    nocol_pbs=genpbs(pbsbase=pbsbase,lspexec='lsp-10-xy-no_collisions');
    files = ["sine700points.dat", "autozipper"]
    files.append((pbsbase+".lsp", lsp));
    files.append((pbsbase+".pbs", pbs));
    files.append((pbsbase+"-nocoll.pbs", pbs));
    if test(d,'extra_files'):
        files.extend(d['extra_files']);
    output(dir=pbsbase,files=files);

def mkonescale(**d):
    #requires tlim to be specified
    tlim = scaletuple(d['tlim'],1e-4);
    tlim = tlim_mvorig(tlim);
    myd=sd(
        d,
        tlim=tlim,);
    if not test(d,'solidlen'): d['solidlen'] = 10e-4;
    if not test(d,'targetscale'): d['targetscale'] = 1.5e-4;
    myd.update(dict(
        sdim=(tlim[1]-d['solidlen'],tlim[1]),
        scale=d['targetscale']));
    return gentargetdat(**myd);
        
           
c=299792458
e=1.602176208e-19
e0  = 8.8541878176e-12
m_e=9.10938356e-31
r_e = e**2/m_e/c**2/(4*np.pi*e0)
def_cycles=40e-15/(780e-9/c);
def fromenergy(En,cycles=def_cycles,l=10e-6,l2w=2.75):
    w=l*l2w;
    T=cycles*l/c;
    I=En/(w**2*np.pi/2.0*T/2.0)*1e-4;
    return sd(
        lsp_d,
        w=w,T=T,I=I)
Es = [10,1,0.1,0.01,0.001,1e-4];
ds = [ fromenergy(E) for E in Es ];
#10um, scale=1.5um
for E in Es:
    d = fromenergy(E);
    d.update(dict(
        l   = 10e-6,
        lim =( -50, 10, -250, 250,0,0),
        tlim=( -40,  0, -240, 240,0,0),
        res =( 60*4, 500*4, 0),
        dens_dat = '1.5um.dat',
        timestep = 4e-16,
        dumpinterval=4e-15,
        totaltime= d['T']*3.5,
        fp = (16.3-40,0,0),));
    dens = mkonescale(**d);
    d['extra_files'] = [('1.5um.dat',dens)]
    name='{l}um-{I:0.2e}-l={scale}um'.format(l=int(d['l']/1e-6),I=d['I'],scale=1.5);
    mksim(name,**d);
