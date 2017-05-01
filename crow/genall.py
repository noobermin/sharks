#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy, c;
import numpy as np;

#there are two possibilities,
#one is to have a system approximating crow et. al
#the other is to have a conductor that provides
#charge at on boundary

#we can try to model both, but the mathematical
#model of the conductor is suspect.

#one way to define "large" is to make sure the
#total time of the simulation is shortert than
#the width divided by the sound speed.

#we'll just do that here. The conductor will be later
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
n0 = 1e21
Tes= np.logspace(10, 2e5, 50)
L = 100;
dl= 1e-3
def targtemp(Te, pbsbase):
    cs = np.sqrt(2 * Te / 511e3) * c;
    d = dict(
        pbsbase=pbsbase,
        description='crow simulation with T_e = {}'.format(Te),
        nolaser=True,
        lim = (-L,     L,     0,0, 0,0),
        tlim= (-L/2.0, L/2.0, 0,0, 0,0),
        res = (2*L/dl, 0, 0),
        timestep = dl * 1e-6 / c * 0.75,
        totaltime = L * 1e-6 / cs,
        fp =(0,0,0),
        tref = (0,0,0),
        #target
        dens_dat = 'n.dat',
        dats = [
            ('n.dat',
             dict(f_1D=mktarget(
                 xdim=[-100e-4, 100e-4],
                 sdim=[-100e-4, 100e-4],
                 solid=1e21,
                 sh=0.0,))),
            # ('T.dat',
            #  dict(f_1D=mktarget(
            #      xdim=[-100e-4, 100e-4],
            #      sdim=[-100e-4, 100e-4],
            #      solid=Te,
            #      sh=0.0,))),
        ],
        lsptemplate="hotH3d_tmpl.lsp",
        speciesl = ['p', 'e'],
        fracs    = [1.0, 1.0],
        thermal_energy = [1.0, Te],
        pext_species=(10,11),
        lspexec='lsp-explicit-10-x',
        dir=True);
    return d;

def mkpbsbase(d):
    l = d['l']/1e-6;
    if l > 1:
        l = int(l);
    else:
        l = '{:0.1f}'.format(l)
    d['pbsbase']=pbsfmt.format(
        l=l,I=d['I'],scale=d['expf']);

d = targtemp(10, 'test');
gensim(**d);
