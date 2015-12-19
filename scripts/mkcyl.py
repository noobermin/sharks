#!/usr/bin/env python2
'''
Create the dat file for the lab as a transverse disk. Note that
dimensions must be positive for now. 

Usage:
  ./mklin.py [options]

Options:
  --x-dims=DIM -x DIM        Set the X dimensions. [default: (0, 27.5e-4)]
  --y-dims=DIM -y DIM        Set the Y dimensions. [default: (0e-4, 40e-4)]
  --z-dims=DIM -z DIM        Set the Z dimensions. [default: (0e-4, 40e-4)]
  --scale=SCALE -l SCALE     Set the scale length. [default: 1.5e-4]
  --solid-dims=SDIM -s SDIM  Set the solid dimensions. [default: (0,10e-4)]
  --solid=SDIM -S SDIM       Set the solid number density. [default: 1.0e23]
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;
from mkdat import mkdat, unitstep, mkdecay

opts = docopt(__doc__,help=True);
xmin,xmax = eval(opts['--x-dims']);
ymin,ymax = eval(opts['--y-dims']);
zmin,zmax = eval(opts['--z-dims']);
l = float(opts['--scale']);
n_s = float(opts['--solid']);
sdims = eval(opts['--solid-dims']);
Xexp = mkdecay(n_s, sdims, (xmin,xmax), l);
y0 = (ymax-ymin)/2.0 #+ 0.0
z0 = (zmax-zmin)/2.0 #+ 0.0
r = (y0+z0)/2.0 #average
Cyl = np.vectorize(lambda y,z: unitstep((y0-y)**2+(z0-z)**2 - r**2))
xlen,ylen,zlen = 50,50,50
n_e = lambda X,Y,Z: Xexp(X)*Cyl(Y,Z);
out=mkdat(n_e,
          xr=(xmin,xmax,20j),
          yr=(ymin,ymax,20j),
          zr=(zmin,zmax,20j));
print(out);
