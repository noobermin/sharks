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
    no_pmovies=False,
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
    discrete=(4,4,4),
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

####################################
# 10um scans
####################################
defds=[]
for E in Es:
    d = sd(fromenergy(E,cycles=cycles), **defd);
    d.update(
        lim =( -50, 10, -120, 120,0,0),
        tlim=( -40,  0, -110, 110,0,0),
        res =( 60*4, 240*4, 0),
        timestep = 5e-16,
        totaltime= d['T']*4,
        description="10um",
        angular=True,
    );
    defds.append(d);

#10um, scale=1.5um
for d in defds:
    d['pbsbase']=pbsfmt.format(
        l=int(d['l']/1e-6),I=d['I'],scale=d['expf']);
    gensim(**d);
#10um, scale=19.2um
longs = [sd(
    d,
    n_s=1e21,
    expf=19.2,
    lim =( -250, 10, -120, 120,0,0),
    tlim=( -240,  0, -110, 110,0,0),
    res =( 260*4, 240*4, 0),
    totaltime=d['T']*4,
    domains=64,
    #movne
    movne=dict(clim=(1e16,1e21)),
    movni=dict(clim=(1e16,1e21)),
    movdq=dict(clim=(-1e18,1e18),
               linthresh=1e15),
    movrho=dict(clim=(-1e18,1e18),
                linthresh=1e15),)
         for d in defds];
#hack to make the first longer.
longs[-1]['totaltime']  = longs[-1]['T']*4.75
for d in longs:
    mkpbsbase(d);
    gensim(**d);
    
####################################
# 3um scans
####################################
#3um, scale=1.5um
for E in Es:
    d = sd(fromenergy(E,l=3e-6,cycles=cycles), **defd);
    d.update(
        lim =( -50, 10, -60, 60, 0,0),
        tlim=( -40,  0, -50, 50, 0,0),
        res =( 60*10, 120*10, 0),
        timestep = 1e-16,
        domains=64,
        totaltime= d['T']*4,
        description="3um",
    );
    mkpbsbase(d);
    gensim(**d);

#3um, scale=5.77um
for E in Es:
    d = sd(fromenergy(E,l=3e-6,cycles=cycles), **defd);
    d.update(
        n_s=1e23,
        expf=5.77,
        lim =( -90, 10, -60, 60, 0,0),
        tlim=( -80,  0, -50, 50, 0,0),
        res =( 100*10, 120*10, 0),
        totaltime=d['T']*4,
        timestep = 1e-16,
        domains=64,
        description="3um w/ 5.77um scale plasma",
        #mov
        movne=dict(clim=(1e16,1e22)),
        movni=dict(clim=(1e16,1e22)),
        movdq=dict(clim=(-1e18,1e18),
                   linthresh=1e15,),
        movrho=dict(clim=(-1e18,1e18),
                   linthresh=1e15,)

    );
    mkpbsbase(d);
    gensim(**d);

#############################
# 0.78um scans
# DESPITE THE NAME, it's 780nm, NOT 800nm
#############################
for E in Es:
    d = sd(fromenergy(E,l=0.78e-6,cycles=cycles), **defd);
    d.update(
        n_s=1e23,
        expf=1.5,
        #
        lim =( -42.5, 10, -15, 15, 0,0),
        tlim=( -32.5,  0, -10, 10, 0,0),
        res =( 52.5*42, 30*42, 0),
        timestep = 5e-17,
        totaltime= d['T']*4,
        dumpinterval = 2e-16,
        description="780nm",
    );
    mkpbsbase(d);
    gensim(**d);
