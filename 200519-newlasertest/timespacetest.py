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

T = 60e-6/np.sqrt(8*np.log(2));

dt = 0.50e-6;
t = np.arange(-T,T+dt,dt);
x = np.linspace(-20.1e-4, 20.1e-4, 5);
y = np.linspace(-11.0e-4, 11.0e-4, 441);
z = np.linspace(-11.0e-4, 11.0e-4, 441);

T,X,Y,Z = np.meshgrid(t,x,y,z,indexing='ij', sparse=True);
gauss = mkgauss();
out = gauss(T,X,Y,Z);
noobna.output_centered(opts['<output>'],[t,x,y,z],out);
