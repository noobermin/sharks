#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy;
import numpy as np;
c=299792458
cycles = 80e-15/(780e-9/c);
Es = [10,1,0.1,0.01,0.001,1e-4];
defd = dict(
    autozipper=True,
    dir=True,
    pbses='defaults',
    #movne
);
pbsfmt='{l}um-{I:0.2e}-l={scale:0.3}um'
def mkpbsbase(d):
    l = d['l']/1e-6;
    if l > 1:
        l = int(l);
    else:
        l = '{:0.1f}'.format(l)
    d['pbsbase']=pbsfmt.format(
        l=l,I=d['I'],scale=d['expf']);

def mktarget(
        xdim=(-0.05,   0.05),
        sdim=(-0.0015, 0.0015),
        solid=3e22,
        sh = 7e17):
    @np.vectorize
    def out(x):
        if x <= xdim[0] or x >= xdim[1]:
            return 0.0;
        elif sdim[0] <= x <= sdim[1]:
            return solid;
        else:
            return sh;
    return out;

d = fromenergy(3e-3,cycles=cycles,l=780e-9);
d.update(
    nolaser=True,
    pbsbase='oned_test',
    lim =( -550, 550,   0,0,0,0),
    tlim=( -500, 500,   0,0,0,0),
    res =( 1100*100, 0, 0),
    lspexec='lsp-10-x',
    fp=(0,0,0),
    tref=(0.0,0.0,0.0),
    #target
    dens_dat='target.dat',
    externalf_1D=True,
    new_externalf=True,
    f_1D=mktarget(),
    dats=[
        ('temp.dat', dict(f_1D=mktarget(sh=1, solid=500)))],
    dat_xres=1000,
    timestep = 1e-16,
    dumpinterval=5e-15,
    totaltime= 2e-12,
    description="1D",
    pext_species=(10,11),
    angular=True,
    pbses='defaults',
    dir=True,
    movne=dict(clim=(1e17,1e23)),
    movni=dict(clim=(1e17,1e23)),
    movdq=dict(clim=(-1e19,1e19),
               linthresh=1e15),
    movrho=dict(clim=(-1e19,1e19),
                linthresh=1e15),
    target_temps = (
        dict(dat="temp.dat"), None, None),
);
gensim(**d);
# 2D sim for absorption
d.update(
    pbsbase='absorption',
    lim =(  -25,  25, -25,25,0,0),
    tlim=(  -15,  15, -15,15,0,0),
    res =( 50*30,  50*30, 0),
    lspexec='lsp-10-xy',
    fp=(0,0,0),
    #target
    dens_dat='surround_target.dat',
    externalf_1D=True,
    f_1D=mktarget(
        xdim = (  0.0, 30e-4),
        sdim = (14e-4, 16e-4),
        solid= 1e23,
        sh   = 2e18,
    ),
    dat_xres=1000,
    timestep     = 5e-17,
    dumpinterval = 1e-15,
    totaltime= 200e-15,
    description="2D absorption",
    pext_species=(10,11),
    angular=True,
    region_split=('y', 3),
    domains=96,
    pbses='defaults',
    dir=True,
);
gensim(**d);
