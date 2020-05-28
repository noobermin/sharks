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

Th= 40e-6;
T = Th/np.sqrt(8*np.log(2));

dt = 0.50e-6;
t = np.arange(-Th,Th+dt,dt);
x = np.linspace(-20.1e-4, 20.1e-4, 5);
y = np.linspace(-11.0e-4, 11.0e-4, 221);
z = np.linspace(-11.0e-4, 11.0e-4, 221);

T,X,Y,Z = np.meshgrid(t,x,y,z,indexing='ij', sparse=True);
gauss = mkgauss();
out = gauss(T,X,Y,Z);
print("shape of axes: {}".format(out.shape));
noobna.output_centered(opts['<output>'],[t,x,y,z],out,dtype='float64');
