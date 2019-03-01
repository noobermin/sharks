#!/usr/bin/env python3
'''
Create the dat file for the exponential fall-off.

Usage:
  ./mklin.py [options]

Options:
  --x-length=L -x L       Length of x-dimension. [default: 27.5]
  --scale=SCALE -l SCALE  Set the scale length. [default: 1.5]
  --solid-length=L -s L   Set the solid dimensions. [default: 10]
  --solid=N -S N          Set the solid number density. [default: 1.0e23]
'''
from docopt import docopt
import numpy as np;
from gendat import genonescale
opts = docopt(__doc__,help=True);
xlen=float(opts['--x-length']);
solid_len=float(opts['--solid-length']);
scale = float(opts['--scale']);
n_s = float(opts['--solid']);
print(genonescale(
    xlen=xlen,
    solid_len=solid_len,
    expf=scale,
    n_s=n_s).decode('utf-8'));
