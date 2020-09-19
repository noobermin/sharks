#!/usr/bin/env python
'''
Usage:
    ./nourtest.py [options]

Options:
     --help -h        Help me.
     --time=T -t T    Set plot time. [default: 40e-6]
'''
from docopt import docopt;
from nouranalytics import gauss,E_r,phase,phi,c;
import numpy as np;
opts = docopt(__doc__,help=True);


x = np.linspace(-10e-4, 10e-4, 101);
y = np.linspace(-13.2e-4,  13.2e-4, 101);
z = np.linspace(-2.2e-4,  2.2e-4, 11);
X,Y,Z = np.meshgrid(x,y,z,indexing='ij');

R = np.sqrt(Y**2 + Z**2);
t0= float(opts['--time']);
T = 60e-6/np.sqrt(8*np.log(2));
#t = t0-X/c;
def sinT(t):
    r = np.sin(t/(2*T));
    return np.where(np.logical_or(t < 0.0,t>2*T),0.0,r)
Er = E_r(t0,X,R)*1e11;
# make Er into Ey and Ez...flipping to lsp coordinate system.
cs = np.where(R>0,Y/R,0.0);
sn = np.where(R>0,Z/R,0.0);
Ey = cs*Er;
Ez = sn*Er;
from lspplot.pc import pc;
import matplotlib.pyplot as plt;
pc(Ey[:,:,5].T, p=(y,x),
   lims=(-1e11,1e11),log=True,linthresh=1e9,rotate=True,flip=True);
plt.show();
