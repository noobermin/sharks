#!/usr/bin/env python2
'''
Create the dat file for the jet.

Usage:
  ./mkjet.py [options]

Options:
  --help -h       Hi.
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;
n0 = 5e18;
xmin,xmax = 0, 150e-4;
prel,postl= 1e-4, 1e-4;
half = (xmax-xmin)/2.0
jetmin,jetmax = 5e-4,145e-4;
N = 201

@np.vectorize
def jet(x):
    if x <= xmin or x >= xmax:
        return 0.0;
    elif jetmin <= x <= jetmax:
        return n0;
    elif x < half:
        return np.exp(-np.abs(x-jetmin)/prel)*n0
    else:
        return np.exp(-np.abs(x-jetmax)/postl)*n0
x = np.linspace(xmin,xmax,N);
y = jet(x);
s = StringIO();
np.savetxt(s,np.array([x,y]).T,fmt='%.8e',); s.write("\n");
print(s.getvalue());
