#!/usr/bin/env python3
'''
Test an exponential fall-off.

Usage:
  ./mklin.py [options]

Options:
  --x-len=XDIM -x XDIM      Set the xlength. [default: 27.5e-4]
  --scale=SCALE -l SCALE     Set the scale length. [default: 1.5e-4]
  --solid-len=L -L L         Set the depth of the solid. [default: 1e-3]
  --solid=S -S S             Set the solid number density. [default: 1.0e23]
'''

from docopt import docopt
import numpy as np;
from gendat import genonescale

opts = docopt(__doc__,help=True);
xlen = float(opts['--x-len']);
scale = float(opts['--scale']);
n_s = float(opts['--solid']);
slen= float(opts['--solid-len']);
print(genonescale(
    xlen=xlen,solid_len=slen,scale=scale,n_s=n_s
).decode('utf-8'));
