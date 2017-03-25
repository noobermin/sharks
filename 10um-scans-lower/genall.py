#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy, nc;
from genpbs import mk_hpcmp_pbses;
import numpy as np;
c=299792458
# fixed variables
cycles = 80e-15 / (780e-9/c);
l2w    = 2.20 / 0.78
width  = 10.0 / 0.78
l2L    = 1.50 / 0.78
#margin =  4.0 / 0.78
tstep  = 32; # 0.78e-6/c  / 1e-16

Es = [1.0, 0.1, 0.01, 0.001, 1e-4];
ls = [ 0.78, 3.0, 10.0 ];
fns= [ 0.5,  1.0];
cs = [ 0.5,  1.0];
domains = 96;
defd = dict(
);
    
pbsfmt='{l}um-{I:0.0e}-L={scale:0.1f}-f={fn:0.1f}-cs={cs:0.1f}'
def mksim(E,l,fn,cy,
          yresd=30,
          long_resd=30,
          timemul='default'):
    scale = 1.5;
    d = fromenergy(
        E,
        l     = l*1e-6,
        cycles= cycles*cy,
        l2w   = l2w*fn,
    );
    d = sd(defd, **d);
    mywidth = np.ceil(width * l);
    margin = 15.0;
    mymargin= np.ceil(margin);
    myedges = np.ceil(margin)+mywidth;
    timestep = l*1e-6/c/tstep;
    yresd = int(np.round((2*myedges) / (l / yresd)));
    pbsbase = pbsfmt.format(
        l = '0.8' if l==0.78 else int(l),
        I = d['I'],
        scale = scale,
        fn= np.pi*d['w']/2/d['l'],
        cs=cy,);
    pbses = mk_hpcmp_pbses(
        pbsbase=pbsbase,
        domains=domains, lspexec='lsp-10-xy');
    print("processing {}".format(pbsbase));  
    #original targets
    if timemul == 'default': timemul=4.0/cy;
    d.update(
        pbsbase=pbsbase,
        #target
        fp='nc',
        n_s=1e23,
        solid_len=10,
        expf=scale,
        scale_with_min=True,
        long_resd = long_resd,
        long_margin = (mymargin,mymargin),
        n_min = 1e16,
        roundup_pp = True,
        # others
        lim =( 0, 0, -myedges, myedges, 0, 0),
        tlim=( 0, 0, -mywidth, mywidth, 0, 0),
        res = (0,yresd,0),
        timestep = timestep,
        dumpinterval = timestep*2,
        totaltime= d['T']*timemul,
        description=pbsbase,
        pbses=pbses,
        domains=domains,
        region_dom_split='y',
        #movs
        movne =dict(clim=(1e16,1e23)),
        movni =dict(clim=(1e16,1e23)),
        movdq =dict(clim=(-1e19,1e19),linthresh=1e15),
        movrho=dict(clim=(-1e19,1e19),linthresh=1e15),
        dir=True,
    );
    gensim(**d);
    #scaled targets
    if np.isclose(l,0.78): return;
    scale = d['expf'] = l2L*l;
    pbsbase = pbsfmt.format(
        l = int(l),
        I = d['I'],
        scale = scale,
        fn= np.pi*d['w']/2/d['l'],
        cs= cy);
    d['pbsbase'] = pbsbase;
    print("processing {}".format(pbsbase));
    d['pbses'] = mk_hpcmp_pbses(
        pbsbase=pbsbase,
        domains=domains, lspexec='lsp-10-xy');
    #if np.isclose(l,10.0): d['n_min']=1e16;
    #note I DO NOT remake movnes, because 1e17 is close enough.
    gensim(**d);
    

_ = [mksim(E,l,fn,cy)
     for E in Es
     for l  in ls
     for fn in fns
     for cy in cs]
#half energies
Ehalf = [0.5, 0.05, 0.005, 5e-4];
_ = [mksim(E, l, 1.0, 0.5)
     for E in Ehalf
     for l in ls]

