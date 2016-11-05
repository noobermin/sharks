#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy;
import numpy as np;
c=299792458
e=1.602176208e-19
e0  = 8.8541878176e-12
m_e=9.10938356e-31
r_e = e**2/m_e/c**2/(4*np.pi*e0)
a0 = lambda I,l=.8e-4: np.sqrt(r_e/c/m_e/(c**2)*2/np.pi * I * l**2)
cycles = 80e-15/(780e-9/c);
Es = [10,1,0.1,0.01,0.001,1e-4];
defd = dict(
    singlescale=True,
    no_pmovies=True,
    lspexec='lsp-10-xy',
    fp='nc',
    #pbs options
    autozipper=True,
    dir=True,
)
pbsfmt='{l}um-{I:0.2e}-l={scale:0.3}um'
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
def mk_noextrapbs(d):
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
            pbsname=pbsbase+"_garnet_20",
            cluster='garnet',
            queue='standard_sm',
            walltime=20),

        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_24",
            cluster='garnet',
            queue='standard_sm',
            walltime=24),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_short",
            cluster="garnet",
            queue="standard_lw",
            walltime=48),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_64",
            cluster="garnet",
            queue="standard_lw",
            walltime=64),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_72",
            cluster="garnet",
            queue="standard_lw",
            walltime=72),
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
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_24",
            cluster='armstrong',
            queue='standard',
            walltime=24),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_36",
            cluster='armstrong',
            queue='standard',
            walltime=36),
    ];
    return dd;
#crazy
Es = [10,1,0.1,0.01,0.001,1e-4];
for E in Es:
    d = sd(fromenergy(E,l=3e-6,cycles=cycles), **defd);
    d.update(
        n_s=1e23,
        solid_len=9,
        expf=d['l']/1e-6,
        lim =( -90, 30, -60, 60, 0,0),
        tlim=( -40, 10, -50, 50, 0,0),
        res =( 120*10, 120*10, 0),
        timestep = 1.5e-16,
        totaltime= d['T']*5.0,
        description="3um",
        dumpinterval=1e-15,
        domains=120,
        #
        pext_species=(10,11),
        #movne
        movne={'clim':(1e15,1e19)},
    );
    mkpbsbase(d);
    mkpbs(d);
    gensim(**d);
    dd=mk_noextrapbs(d);
    gensim(**dd);
