#!/usr/bin/env python
'''
Usage:
    ./timespacetest.py [options] <output>
    ./timespacetest.py [options] --plot

Options:
     --help -h        Help me.
     --plot           Plot instead.
     --npz -N         Output npy instead.
'''
from docopt import docopt;
from timespace import mkgauss, c;
import numpy as np;
import noobna;
opts = docopt(__doc__,help=True);

Th= 6e-6;
t0 = Th/np.sqrt(8*np.log(2));
Fnum=1.5
dt = 0.05e-6;
#t = np.arange(-1.5*Th,1.5*Th+dt,dt);
t = np.linspace(-4.1e-6,6.1e-6,205);
x = np.linspace(-11.0e-4,-10.9e-4, 3);
y = np.linspace(-5e-4, 5e-4, 101);
z = np.linspace(-5e-4, 5e-4, 101);

T,X,Y,Z = np.meshgrid(t,x,y,z,indexing='ij', sparse=True);
gauss = mkgauss(t0=t0,F=Fnum);
out = gauss(T,X,Y,Z);

#zero edges
out[ 0, :, :, :] = 0;
out[-1, :, :, :] = 0;

# don't zero x axis
#out[ :, 0, :, :] = 0;
#out[ :,-1, :, :] = 0;

out[ :, :, 0, :] = 0;
out[ :, :,-1, :] = 0;

out[ :, :, :, 0] = 0;
out[ :, :, :,-1] = 0;


print("shape of axes: {}".format(out.shape));
if opts['--plot']:
    import matplotlib.pyplot as plt;
    from lspplot.pc import pc;
    pc(out[:,0,:,0].T, p=(t*1e6,y), xlabel='fs', ylabel='cm');
    plt.show();
elif opts['--npz']:
    np.savez(opts['<output>'], d=out, t=t,x=x,y=y,z=z);
else:
    noobna.output_centered(opts['<output>'],[t,x,y,z],out,dtype='float64');
