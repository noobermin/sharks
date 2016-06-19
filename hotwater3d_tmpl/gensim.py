#!/usr/bin/env python3
from genlsp import genlsp,lspdefaults
from genpbs import genpbs,gen_movne,pbsdefaults,movne_defaults;
from gendat import gentargetdat,genonescale,datdefaults;
import re;
import os,stat;
from pys import sd,test,mk_getkw;
import shutil as sh;
import numpy as np;

c=299792458
e=1.602176208e-19
e0  = 8.8541878176e-12
m_e=9.10938356e-31
r_e = e**2/m_e/c**2/(4*np.pi*e0)
def_cycles=40e-15/(780e-9/c);
nc = lambda l,gm=1,m=m_e,q=e: e0*m*(2*np.pi*c/l)**2/q**2/gm*1e-6

def mkdir(dir):
    os.makedirs(dir, exist_ok=True);

def output(dir='.',files=["sine700points.dat","watercolumn.dat","autozipper"]):
    if dir:
        mkdir(dir);
    for file in files:
        if type(file) == str:
            sh.copy(file,dir);
        else:
            fname=dir+'/'+file[0]
            outstr=file[1];
            with open(fname,'wb') as f:
                if type(outstr) == str:
                    outstr=outstr.encode('ascii');
                f.write(outstr);
            if len(file)>2:
                os.chmod(fname, file[2]);
    pass;
def scaletuple(t,scale=1e-4):
    return tuple([it*scale for it in t]);
defaults = sd(datdefaults,**pbsdefaults);
defaults = sd(defaults,**lspdefaults);
defaults.update(dict(
    pbsbase="hotwater3d",
    autozipper=None,
    movne=False,
    angular=False,
    pbses=None,
    dir=None,
));

def get_roundfpx(d):
    dx = -np.log(nc(d['l'])/d['n_s'])*d['expf'];
    return d['tlim'][1]-d['solid_len']-dx;

def gensim(**kw):
    getkw =  mk_getkw(kw,defaults);
    pbsbase=getkw("pbsbase");
    files = ["sine700points.dat"];
    pbses = getkw("pbses");
    if test(kw, "autozipper"):
        files.append('zipper');
    files.append('loopscript');
    # for singlescale
    if test(kw,'singlescale'):
        if type(getkw('fp')) != tuple:
            fpx = get_roundfpx(kw);
            if getkw('fp') != 'nc':
                fpx += getkw('fp');
            kw['fp'] = (fpx,0.0,0.0);
        tlim = getkw('tlim')
        kw['xlen'] = tlim[1]-tlim[0];
        dens = genonescale(**kw);
        kw['dens_dat'] = "{}um.dat".format(getkw('expf'));
        files.append((kw['dens_dat'], dens));
    elif getkw('externalf_1D'):
        tlim = getkw('tlim');
        kwp = sd(kw, tlim=(0, tlim[1]-tlim[0], 0,0, 0,0))
        dens = gentargetdat(**kwp);
        if not test(kw, 'dens_dat'):
            kw['dens_dat'] = "watercolumn.dat";
        files.append((kw['dens_dat'], dens));
    if test(kw, "movne"):
        if type(kw['movne']) == dict:
            movned = sd(kw,**kw['movne']);
        if not test(movned,'n_c'):
            movned['n_c'] = nc(kw['l']);
        movne=gen_movne(**movned);
        #adding it to pbs
        if test(kw, "concurrents"):
            kw['concurrents'] += [('movne','./movne')];
        else:
            kw['concurrents'] = [('movne','./movne')];
        files.append( ('movne',movne,0o755) );
    if test(kw,'angular'):
        #adding it to pbs
        if test(kw, "concurrents"):
            kw['concurrents'] += [('genangular','./genangular')];
        else:
            kw['concurrents'] = [('genangular','./genangular')];
        files.append('genangular');
    lsp=genlsp(**kw);
    files.append((pbsbase+".lsp", lsp));
    if pbses is None:
        files.append((pbsbase+".pbs",genpbs(**kw)))
    else:
        for pbs in pbses:
            files.append(
                (pbs['pbsname']+".pbs", genpbs(**sd(kw,**pbs)))
            );
    if test(kw,'extra_files'):
        files.extend(kw['extra_files']);
    dir=getkw('dir');
    if dir == True: dir = pbsbase;
    output(dir=dir,files=files);        

def fromenergy(En,cycles=def_cycles,l=10e-6,l2w=2.75):
    w=l*l2w;
    T=cycles*l/c;
    I=En/(w**2*np.pi/2.0*T/2.0)*1e-4;
    return sd(defaults,w=w,T=T,I=I)
