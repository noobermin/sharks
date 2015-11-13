#!/usr/bin/env python2
'''
Create the dat file for the exponential fall-off.

Usage:
  ./mklin.py [options]

Options:
  --x-dims=XDIM -x XDIM      Set the x dimensions. [default: (-27.5e-4,0e-4)]
  --scale=SCALE -l SCALE     Set the scale length. [default: 1.5e-4]
  --solid-dims=SDIM -s SDIM  Set the solid dimensions. [default: (-10e-4,0)]
  --solid=SDIM -S SDIM       Set the solid number density. [default: 1.0e23]
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;

def mkdecay(solid, sdims, xmin, l):
    def out(x):
        if x < xmin or x > sdims[1]:
            return 0.0;
        elif sdims[0] <= x <= sdims[1]:
            return solid;
        else:
            return -np.abs(x-sdims[0])/l;
    return np.vectorize(out);

opts = docopt(__doc__,help=True);
xmin,xmax = eval(opts['--x-dims']);
l = float(opts['--scale']);
n_s = float(opts['--solid']);
sdims = eval(opts['--solid-dims']);
x = np.linspace(xmin-1e-5,xmax,100);
y = mkdecay(n_s, sdims, xmin,l)(x);
s = StringIO();
np.savetxt(s,np.array([x,y]).T,fmt='%.8e',); s.write("\n");
print(s.getvalue());
