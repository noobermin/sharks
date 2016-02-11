#!/usr/bin/env python2
'''
Create the dat file for the tnsa target

Usage:
  ./mklin.py [options]

Options:
  --scale=SCALE -l SCALE     Set the pre-plasma scale length. [default: 1.5e-4]
  --solid-dims=SDIM -s SDIM  Set the solid dimensions. [default: (-1e-5,1e-4)]
  --pp-dims=PDIMS -p PDIMS   Set the pre-plasma's 
                             dimensions. [default: (1e-4,21e-4)]
  --solid=SDIM -S SDIM       Set the solid number density. [default: 1.0e23]
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;
opts = docopt(__doc__,help=True);

pdims = eval(opts['--pp-dims']);
l = float(opts['--scale']);
sdims = eval(opts['--solid-dims']);
n_s = float(opts['--solid']);

dims = pdims+sdims;
minx=min(*dims);
maxx=max(*dims);
@np.vectorize
def water_target(x):
    if sdims[0] < x < sdims[1]:
        return n_s;
    elif pdims[0] < x < pdims[1]:
        return np.exp(-(x-pdims[0])/l)*n_s;
    else:
        return 0.0;
x = np.linspace(minx, maxx, 101);
y = water_target(x);
s = StringIO();
np.savetxt(s,np.array([x,y]).T,fmt='%.8e',); s.write("\n");
print(s.getvalue());
