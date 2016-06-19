#!/usr/bin/env python2
'''
Create the laser as an external field. Called creates a test plot.

Usage:
  ./lasergen.py [options]

Options:
  --l=L -l L          Set the wavelength. [default: 0.780e-6]
  --w=W -w W          Set the waist. [default: 2.17e-6]
  --I=I -I I          Set the intensity in W/cm^2. [default: 1e18]
  --log -L            Log10 the plot.
  --Z=Z -z Z          Set zscale. [default: 10]
  --R=R -r R          Set rscale. [default: 5]
  --2D -2             Test 2D laser.
'''
import numpy as np;
c = 299792458;
e0= 8.854187817e-12
def mkgauss(l,w0,phase_shift=0.0,dim='2D'):
    '''
    Create a gauss laser function.
    '''
    if dim not in ['2D', '3D']:
        raise ValueError(
            "Unimplemented dim '{}',not '2D' or 3D'".format(dim));

    zr = np.pi*w0**2/l;
    w = lambda z: w0*np.sqrt(1+(z/zr)**2)
    R = lambda z: z*(1+(zr/z)**2);
    if dim == '2D':
        phi = lambda z: np.arctan(z/zr);
    else:
        phi = lambda z: 0.5*np.arctan(z/zr);
    def gauss(x,y,z):
        return np.exp(-(x**2+y**2)/w(z)**2)
    phase = lambda x,y,z: np.cos(
        2*np.pi/l * (z + (x**2+y**2)/(2*R(z)))-phi(z)+phase_shift);

    if dim == '2D':
        return lambda x,y,z: np.sqrt(w0/w(z))*gauss(x,y,z)*phase(x,y,z)
    else:
        return lambda x,y,z: w0/w(z)*gauss(x,y,z)*phase(x,y,z)

def intensity_to_E(I):
    return  np.sqrt(2*(I*1e4)/(e0*c));
    
if __name__ == "__main__":
    from docopt import docopt;
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    opts = docopt(__doc__,help=True);
    w0 = float(opts['--w']);
    l  = float(opts['--l']);
    I = float(opts['--I']);
    E0 = intensity_to_E(I);
    F=mkgauss(E0,l,w0,dim='2D' if opts['--2D'] else '3D');
    rscale = float(opts['--R'])
    zscale = float(opts['--Z']);
    Z,Y = np.mgrid[
        -l*zscale :l*zscale :200j,
        -w0*rscale:w0*rscale:200j];
    #X=Z*0.0
    norm = LogNorm() if opts['--log'] else None;
    E = F(Y*0.0,Y,Z)*E0;
        
    Z/=l; Y/=w0;
    plt.title("$I$");
    maxI = c*e0*E0**2/2.0*1e-4
    plt.pcolormesh(Y,Z, c*e0*E**2/2.0*1e-4,
                   vmax=maxI, vmin=0,
                   norm=norm,cmap='viridis');
    plt.xlim(Y.min(),Y.max());
    plt.ylim(Z.min(),Z.max());
    cb=plt.colorbar();
    cb.set_label("$W/cm^2$");
    plt.show();
    
