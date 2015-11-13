#!/usr/bin/env python2
'''
Generate the watercolumn.dat files from this simulation.

Usage:
  ./genwatercolumn.py [options]

Options:
   --solid=SOLID -d SOLID       Set the solid density. [default: 1e23]
   --radius=RADIUS -r RADIUS    Set the radius of the column. [default: 30e-4]
   --scale=SCALE -s SCALE       Set the scale-length of the plasma. [default: 1.5e-4]
'''
from mkdat import mkdat;
import numpy as np;
from docopt import docopt;

def mkcolumn(scale, r, solid):
    def F(x,y,z):
        if (x**2+y**2) < r**2:
            return solid;
        else:
            return solid*np.exp(-(x**2+y**2)/scale);
    return np.vectorize(F);
opts=docopt(__doc__,help=True);

solid = float(opts['--solid'])
radius = float(opts['--radius'])
scale = float(opts['--scale'])


print(mkdat(mkcolumn(scale,radius,solid)));
