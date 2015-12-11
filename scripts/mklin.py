#!/usr/bin/env python2
'''
Create the dat file for the exponential fall-off in 1D. Note that
dimensions must be positive for now. 

Usage:
  ./mklin.py [options]

Options:
  --x-dims=XDIM -x XDIM      Set the x dimensions. [default: (0, 27.5e-4)]
  --scale=SCALE -l SCALE     Set the scale length. [default: 1.5e-4]
  --solid-dims=SDIM -s SDIM  Set the solid dimensions. [default: (0,10e-4)]
  --solid=SDIM -S SDIM       Set the solid number density. [default: 1.0e23]
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;

def mkdecay(solid, sdims, xdims, l):
    def out(x):
        if x <= xdims[0] or x >= xdims[1]:
            return 0.0;
        elif sdims[0] <= x <= sdims[1]:
            return solid;
        else:
            return np.exp(-np.abs(x-sdims[1])/l)*solid;
    return np.vectorize(out);

opts = docopt(__doc__,help=True);
xdims = eval(opts['--x-dims']);
l = float(opts['--scale']);
n_s = float(opts['--solid']);
sdims = eval(opts['--solid-dims']);
x = np.linspace(xdims[0],xdims[1],100);
y = mkdecay(n_s, sdims, xdims,l)(x);
s = StringIO();
np.savetxt(s,np.array([x,y]).T,fmt='%.8e',); s.write("\n");
print(s.getvalue());
