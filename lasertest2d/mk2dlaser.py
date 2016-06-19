#!/usr/bin/env python2
'''
Create the laser as an external field. Called creates a test plot.

Usage:
  ./lasergen.py [options]

Options:
  --l=L -l L             Set the wavelength. [default: 0.780e-6]
  --w=W -w W             Set the waist. [default: 2.17e-6]
  --I=I -I I             Set the intensity in W/cm^2. [default: 3e18]
  --Z=Z -z Z             Set z position. [default: -30e-4]
  --x-dims=XDIM -x XDIM  Set the independent variable
                         limits. [default: (-30e-4, 30e-4)]
  --samples=S -S S       Set the number of samples. [default: 101]
'''
import numpy as np;
import lasergen as lg;
from StringIO import StringIO
if __name__ == "__main__":
    from docopt import docopt;
    import matplotlib.pyplot as plt;
    opts = docopt(__doc__,help=True);
    w0 = float(opts['--w']);
    l  = float(opts['--l']);
    I = float(opts['--I']);
    zpos=float(opts['--Z']);
    xdims=eval(opts['--x-dims']);
    N=int(opts['--samples']);
    E0 = lg.intensity_to_E(I);
    #to kV/cm, V/m*1kV/1000V*1m/100cm = V/m* 1e-5
    E0*=1e-5;
    F=  lg.mkgauss(l,w0,dim='2D');
    x = np.linspace(xdims[0],xdims[1],N);
    y = E0*F(x,0,zpos);
    s = StringIO();
    np.savetxt(s,np.array([x,y]).T,fmt='%.8e',); s.write("\n");
    print(s.getvalue());

