#!/usr/bin/env python2
'''
Generate the watercolumn.dat files from this simulation.

Usage:
  ./testwatercolumn.py [options]

Options:
   --solid=SOLID -d SOLID       Set the solid density. [default: 1e23]
   --radius=RADIUS -r RADIUS    Set the radius of the column. [default: 30e-4]
   --scale=SCALE -s SCALE       Set the scale-length of the plasma. [default: 1.5e-4]
'''
from mkdat import mkdat;
import numpy as np;
from docopt import docopt;
import matplotlib.pyplot as plt;
from matplotlib.colors import LogNorm

def mkcolumn(scale, R, solid,
             xstart=-25e-4,xend=15e-4,
             ystart=-15e-4,yend=15e-4,
             xoff=25e-4,yoff=0):
    def F(x,y,z):
        if x > xend or x < xstart:
            return 1.0;
        elif y > yend or y < ystart:
            return 1.0;
        r = np.sqrt((x-xoff)**2 + (y-yoff)**2);
        if r < R:
            return solid;
        else:
            return solid*np.exp(-(r-R)/scale);
    return np.vectorize(F);
opts=docopt(__doc__,help=True);

solid = float(opts['--solid'])
radius = float(opts['--radius'])
scale = float(opts['--scale'])

f=mkcolumn(scale,radius,solid)
X,Y,Z = np.mgrid[-30e-4:20e-4:100j,
                 -20e-4:20e-4:100j,
                 -10e-4:10e-4:100j];

S=f(X,Y,Z);

S=S[:,:,50]; X=X[:,:,50]; Y=Y[:,:,50];

plt.pcolormesh(X,Y,S,norm=LogNorm(),
               vmax=solid,vmin=1);
plt.colorbar();
plt.show();
