#!/usr/bin/env python
'''
Usage: 
    ./genL0.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt, sdl;
from genlsp import gensim;
from genlsp.gensim import fromenergy_qs;
import numpy as np;
import shutil as sh;
import re;
from h2o_species import h2o_species_explicit as h2o_species;
from h2o_species import h2o_creation_plasma, h2o_creation_other;
e0 = 8.854e-12
c  = 299792458
#E = 0.5e-3; # 5mJ

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;
mkmovE = lambda d, I: sd(d['movE'],clim=(EfromI(I*1e-4),EfromI(I*2)))
mkmovB = lambda d, I: sd(d['movB'],clim=(BfromI(I*1e-5),BfromI(I*2)))
###########
# fixed variables
cycles = 80e-15 / (780e-9/c);
#l2w    = 2.20 / 0.78
width  = 10.0 / 0.78
l2L    = 1.50 / 0.78
#margin =  4.0 / 0.78
tstep  = 26; # 0.78e-6/c  / 1e-16

Es = [ 1.0, 0.1, 0.01, 0.001, 1e-4];
ls = [ 0.78e-4, 3.0e-4, 10.0e-4 ];
fns= [ 2.20*0.5*np.pi];
cs = [ 1.0 ];
Ls = [ 0.5, 1.0, 2.0, 4.0 ];
domains = 132;
defd = dict();
llabels = {
    0.78e-4:'0.8', 3.0e-4:'03', 10.0e-4:'10' };
species = h2o_species;
discrete = (4,4,1);

plasmacs = sdl(h2o_creation_plasma,
               lim = 'tlim',
               discrete_numbers = discrete,
               reference_point  = (0.0,0.0,0.0),
               drift_momentum   = (0.0,0.0,0.0),
               thermal_energy   = 1.0);
creations = plasmacs + h2o_creation_other;
pbsfmt='L0_{l}um-{I:0.0e}-L={scale:0.1f}'
def mksim(E,l,fn,cy,L,
          yresd=24,long_resd=24):
    d = fromenergy_qs(
        E,
        l     = l*1e-6,
        cycles= cycles*cy,
        fnum  = fn);
    d = sd(defd, **d);
    l_um = l*1e4
    mywidth  = np.ceil(width * l*1e4)*1e-4;
    margin = 4.0*l;
    mymargin= np.ceil(margin*1e4)*1e-4;
    myedges = mymargin+mywidth;
    timestep = l*1e-6/c/tstep;
    yresd = int(np.round((2*myedges) / (l / yresd)));
    llabel = llabels[l];
    scale = L*l;
    pbsbase = pbsfmt.format(
        l = llabel,
        I = d['I'],
        scale = scale*1e4,
        fn= np.pi*d['w']/2/d['l'],
        cs=cy,);
    print("processing {}".format(pbsbase));
    mycreate = creations
    #original targets
    d.update(
        ux=1.0,
        pbsbase=pbsbase,
        species=species,
        fracs    = (1,2,3),
        new_create = True,
        creation = creations,
        #target
        fp='nc',
        n_s=3.34e22,
        solid_len=l,
        expf=scale,
        two_scales=True,
        long_resd = long_resd,
        long_margin = (mymargin,mymargin),
        n_bmin = 1e16,
        n_fmin = 1e16,
        round_unit = 1e-4,
        roundup_pp = True,
        Lf = scale,
        Lb = scale/4,
        # others
        lim =( 0, 0, -myedges, myedges, 0, 0),
        tlim=( 0, 0, -mywidth, mywidth, 0, 0),
        res = (0,yresd,0),
        #
        restarts_only = True,
        restart_interval = 100,
        timestep = timestep,
        totaltime= d['T']*4,
        description=pbsbase,
        pbses='default',
        domains=domains,
        region_dom_split='y',
        #movs
        #movne =dict(clim=(1e16,1e23)),
        #movni =dict(clim=(1e16,1e23)),
        #movdq =dict(clim=(-1e19,1e19),linthresh=1e15),
        #movrho=dict(clim=(-1e19,1e19),linthresh=1e15),
        dir=True,
    );
    gensim(**d);
    

_ = [mksim(E,l,fn,cy,L)
     for E in Es
     for l  in ls
     for fn in fns
     for cy in cs
     for L in Ls];
