#!/usr/bin/env python3
from genlsp import genlsp;
from genpbs import genpbs;
from gendat import gentargetdat,genonescale;
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
           
c=299792458
e=1.602176208e-19
e0  = 8.8541878176e-12
m_e=9.10938356e-31
r_e = e**2/m_e/c**2/(4*np.pi*e0)
def_cycles=40e-15/(780e-9/c);
nc = lambda l,gm=1,m=m_e,q=e: e0*m*(2*np.pi*c/l)**2/q**2/gm*1e-6

def fromenergy(En,cycles=def_cycles,l=10e-6,l2w=2.75):
    w=l*l2w;
    T=cycles*l/c;
    I=En/(w**2*np.pi/2.0*T/2.0)*1e-4;
    return sd(
        lsp_d,
        w=w,T=T,I=I)
Es = [10,1,0.1,0.01,0.001,1e-4];
ds=[]
for E in Es:
    d = fromenergy(E);
    d.update(dict(
        l   = 10e-6,
        lim =( -50, 10, -120, 120,0,0),
        tlim=( -40,  0, -110, 110,0,0),
        res =( 60*5, 240*5, 0),
        timestep = 2e-16,
        dumpinterval=1e-15,
        totaltime= d['T']*3.0,));
    ds.append(d);
nc10um = nc(10e-6);
def get_roundfpx(dens,d):
    dx = -np.log(nc(d['l'])/dens['n_s'])*dens['scale']/1e-4;
    return d['tlim'][1]-dens['solid_len']-dx;


####################################
# 10um scans
####################################
#10um, scale=1.5um
densd = dict(
    xlen = 40e-4,
    solid_len=10e-4,
    n_s=1e23,
    scale=1.5e-4);
for d in ds:
    mydensd = sd(densd, xlen=(d['tlim'][1]-d['tlim'][0])*1e-4);
    dens = genonescale(**mydensd);
    fpx = get_roundfpx(mydensd,d);
    d['extra_files'] = [('1.5um.dat',dens)]
    d.update(dict(
        dens_dat='1.5um.dat',
        fp = (fpx,0,0)));
    name='{l}um-{I:0.2e}-l={scale:0.2}um'.format(
        l=int(d['l']/1e-6),I=d['I'],scale=mydensd['scale']/1e-4);
    mksim(name,**d);
#10um, scale=19.2um
densd19 = sd(densd,
    solid_len=10e-4,
    n_s=1e21,
    scale=19.2e-4);
for d in ds:
    mydensd = sd(densd19, xlen=d['tlim'][1]-d['tlim'][0]);
    d=sd(
        d,
        lim =( -250, 10, -120, 120,0,0),
        tlim=( -240,  0, -110, 110,0,0),
        res =( 260*4, 240*4, 0),
        totaltime=d['T']*3.5,)
    dens = genonescale(**mydensd);
    fpx = get_roundfpx(mydensd,d);
    d['extra_files'] = [('19.2um.dat',dens)]
    d.update(dict(
        dens_dat='19.2um.dat',
        fp = (fpx,0,0)));
    name='{l}um-{I:0.2e}-l={scale:0.3}um'.format(
        l=int(d['l']/1e-6),I=d['I'],scale=mydensd['scale']/1e-4);
    mksim(name,**d);
