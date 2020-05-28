#!/usr/bin/env python
'''
Usage:
    ./timespacetest.py [options] <output>

Options:
     --help -h        Help me.
'''
from docopt import docopt;
from timespace import mkgauss, c;
import numpy as np;
import noobna;
opts = docopt(__doc__,help=True);

Th= 10e-6;
T = Th/np.sqrt(8*np.log(2));

dt = 0.10e-6;
t = np.arange(-Th,Th+dt,dt);
x = np.linspace(-13.3e-4,-13.2e-4, 3);
y = np.linspace(-8.0e-4, 8.0e-4, 161);
z = np.linspace(-8.0e-4, 8.0e-4, 161);

T,X,Y,Z = np.meshgrid(t,x,y,z,indexing='ij', sparse=True);
gauss = mkgauss(t0=T);
out = gauss(T,X,Y,Z);
print("shape of axes: {}".format(out.shape));
noobna.output_centered(opts['<output>'],[t,x,y,z],out,dtype='float64');
