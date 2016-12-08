#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy;
import numpy as np;
c=299792458
cycles = 80e-15/(780e-9/c);
Es = [10,1,0.1,0.01,0.001,1e-4];
defd = dict(
    dumpinterval=1e-15,
    singlescale=True,
    no_pmovies=True,
    lspexec='lsp-10-xy',
    fp='nc',
    #target
    n_s=1e23,
    solid_len=10,
    expf=1.5,
    #pbs options
    autozipper=True,
    dir=True,
    pbses='defaults',
    #movne
    movne=dict(clim=(1e17,1e23)),
    movni=dict(clim=(1e17,1e23)),
    movdq=dict(clim=(-1e19,1e19),
               linthresh=1e15),
    movrho=dict(clim=(-1e19,1e19),
                linthresh=1e15),    
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

d = fromenergy(4e-6,cycles=cycles,l=780e-9);
d.update(**defd);
d.update(
    pbsbase='beamtest_only',
    lim =( -25, 15, -15, 15,0,0),
    tlim=( -20,  0, -10, 10,0,0),
    res =( 40*20, 30*20, 0),
    timestep = 1e-16,
    totaltime= d['T']*3.5,
    description="Beamtest",
    angular=True,
);
gensim(**d)
