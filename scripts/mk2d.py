#!/usr/bin/env python2
'''
Create the dat file for 2D data.

Usage:
  ./mklin.py [options]

Options:
'''
from docopt import docopt
import numpy as np;
from cStringIO import StringIO;
def mklsp_type40(F,x,y):
    

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
