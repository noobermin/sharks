#!/usr/bin/env python2
'''
Create the dat file for the exponential fall-off.

Usage:
  ./mklin.py [options]

Options:
  --x-dims=XDIM -x XDIM      Set the x dimensions. [default: (0.0, 27.5e-4)]
  --scale=SCALE -l SCALE     Set the scale length. [default: 1.5e-4]
  --solid-dims=SDIM -s SDIM  Set the solid dimensions. [default: (17.5e-4, 27.5e-4)]
  --solid=SDIM -S SDIM       Set the solid number density. [default: 1.0e23]
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;
from gendat import gentargetdat
opts = docopt(__doc__,help=True);
xdim = eval(opts['--x-dims']);
xdim = min(*xdim),max(*xdim)
scale = float(opts['--scale']);
n_s = float(opts['--solid']);
sdim = eval(opts['--solid-dims']);
sdim = min(*sdim),max(*sdim);
print(gentargetdat(
    sdim=sdim + (0,0,0,0,),
    tlim=xdim + (0,0,0,0,),
    scale=scale,
    n_s=n_s))

