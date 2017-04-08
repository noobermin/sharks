#!/usr/bin/env python3
from pys import sd,test;
from gensim import gensim, fromenergy, nc;
from genpbs import mk_hpcmp_pbses;
import numpy as np;
from mksim import mksim;

Es = [1.0, 0.1, 0.01, 0.001, 1e-4];
ls = [ 0.78, 3.0, 10.0 ];
fns= [ 0.5,  1.0];
cs = [ 0.5,  1.0];

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

