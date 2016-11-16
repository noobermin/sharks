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
margin =  4.0 / 0.78
tstep  = 26; # 0.78e-6/c  / 1e-16

Es = [10, 1.0, 0.1, 0.01, 0.001, 1e-4];
ls = [ 0.78, 3.0, 10.0 ];
fns= [ 0.50, 1.0, 2.0 ];
cs = [ 1.0, 2.0];
domains = 64;
defd = dict(
    no_pmovies=True,
);
    
pbsfmt='{l}um-{I:0.0e}-L={scale:0.1f}-fn={fn:0.1f}-cs={cs}'
def mksim(E,l,fn,cy):
    scale = 1.5;
    d = fromenergy(
        E,
        l     = l*1e-6,
        cycles= cycles*cy,
        l2w   = l2w*fn,
    );
    d = sd(defd, **d);
    mywidth = np.ceil(width * l);
    mymargin= np.ceil(margin* l);
    myedges = np.ceil(margin* l)+mywidth;
    timestep = l*1e-6/c/tstep;
    yres = int(np.ceil((2*myedges) / (l / 20)));
    pbsbase = pbsfmt.format(
        l = '0.8' if l==0.78 else int(l),
        I = d['I'],
        scale = scale,
        fn= np.pi*d['w']/2/d['l'],
        cs= int(cy));
    pbses = mk_hpcmp_pbses(
        pbsbase=pbsbase,
        domains=domains, lspexec='lsp-10-xy');
    print("processing {}".format(pbsbase));  
    #original targets
    d.update(
        pbsbase=pbsbase,
        #target
        fp='nc',
        n_s=1e23,
        solid_len=10,
        expf=scale,
        scale_with_min=True,
        long_resd = 20,
        long_margin = (mymargin,mymargin),
        n_min = 1e17,
        roundup_pp = True,
        # others
        lim =( 0, 0, -myedges, myedges, 0, 0),
        tlim=( 0, 0, -mywidth, mywidth, 0, 0),
        res = (0,yres,0),
        timestep = timestep,
        dumpinterval = timestep*5,
        totaltime= d['T']*3.5,
        description=pbsbase,
        pbses=pbses,
        domains=domains,
        #movs
        movne =dict(clim=(1e17,1e23)),
        movni =dict(clim=(1e17,1e23)),
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
        cs= int(cy));
    d['pbsbase'] = pbsbase;
    print("processing {}".format(pbsbase));
    d['pbses'] = mk_hpcmp_pbses(
        pbsbase=pbsbase,
        domains=96, lspexec='lsp-10-xy');
    if np.isclose(l,10.0): d['n_min']=5e16;
    #note I DO NOT remake movnes, because 1e17 is close enough.
    gensim(**d);
    

_ = [mksim(E,l,fn,cy)
     for E in Es
     for l  in ls
     for fn in fns
     for cy in cs]

quit();
