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

def mkdecay(solid, solidstart, solidend, l):
    def out(x):
        if x > solidend:
            return 0;
        if solidstart <= x <= solidend:
            return solid;
        else:
            return np.exp( -(x-solidstart)/l )*solid;
    return np.vectorize(out);

opts = docopt(__doc__,help=True);
xmin,xmax = eval(opts['--x-dims']);
l = float(opts['--scale']);
n_s = float(opts['--solid']);
smin,smax = eval(opts['--solid-dims']);

x = np.linspace(xmin,xmax,100);
y =mkdecay(n_s, smin, smax, l)(x);
f = StringIO();
np.savetxt(f,np.array([x,y]).T,fmt='%.8e',); f.write("\n");
print(f.getvalue());
