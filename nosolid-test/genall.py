#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy;
import numpy as np;
c=299792458
cycles = 80e-15/(780e-9/c);
E = 1e-2;
defd = dict(
    lspexec='lsp-10-xy',
    fp='nc',
    #target
    n_s=1e22,
    solid_len=10,
    expf=1.5,
    #movne
    movne={'clim':(1e16,1e22)},
    #pbs options
    angular=True,
    autozipper=True,
    dir=True,
)
pbsfmt='nosolid-{l}um-{I:0.2e}-l={scale:0.3}um'
def mkpbsbase(d):
    l = d['l']/1e-6;
    if l > 1:
        l = int(l);
    else:
        l = '{:0.1f}'.format(l)
    d['pbsbase']=pbsfmt.format(
        l=l,I=d['I'],scale=d['expf']);
def mkpbs(d):
    pbsbase = d['pbsbase']
    d['pbses'] = [
        dict(pbsname=pbsbase),
        dict(pbsname=pbsbase+'-nocoll',
             lspexec='lsp-10-xy-no_collisions')
    ];
    return d;
def mk_extrapbs(d):
    dd = sd(d);
    pbsbase = dd['pbsbase']
    hpcmp_defpbs =  dict(
        pbsbase=pbsbase,
        pbsname=pbsbase,
        cluster='oakley',
        autozipper=False,
        queue=None,
        ppn=None,);
    dd['movne'] = False;
    dd['angular']=False;
    dd['pbses'] = [
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet",
            cluster='garnet',
            queue='standard_lw'),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_short",
            cluster='garnet',
            queue='standard_lw',
            walltime=48),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_24",
            cluster='garnet',
            queue='standard_sm',
            walltime=24),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_20",
            cluster='garnet',
            queue='standard_sm',
            walltime=20),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_shorter",
            cluster='garnet',
            queue='standard_sm',
            walltime=12),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_debug",
            cluster='garnet',
            queue='debug',),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_debug",
            cluster='armstrong',
            queue='debug'),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong",
            cluster='armstrong',
            queue='standard'),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_short",
            cluster='armstrong',
            queue='standard',
            walltime=48),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_shorter",
            cluster='armstrong',
            queue='standard',
            walltime=14),

    ];
    return dd;

d = sd(fromenergy(E,l=.78e-6,cycles=cycles), **defd);
d.update(
    lim =( 0, 0, -20, 20, 0, 0),
    tlim=( 0, 0, -15, 15, 0, 0),
    res =( 60*40, 40*40, 0),
    timestep = 4e-17,
    totaltime= d['T']*3.0,
    description="nosolid test",
    # target shit.
    scale_with_min = True,
    exf = 1.5,
    n_s = 1e22,
    long_res= 40,
    long_margin = [5,5],
    roundup_ten_pp = True,
    n_min = 1e18,
    solid_len = 10.0,
);
mkpbsbase(d);
d=mkpbs(d);
gensim(**d);
dd=mk_extrapbs(d);
gensim(**dd);

#for 7 micron scale
d.update(
    long_res=40,
    n_s = 1e22,
    n_min = 5e19,
    expf = 7.2,
);
mkpbsbase(d);
d=mkpbs(d);
gensim(**d);
dd=mk_extrapbs(d);
gensim(**dd);
