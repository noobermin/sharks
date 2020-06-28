#!/usr/bin/env python
'''
usage: gauss3D_fac.py <outputR> <outputI>
'''
import numpy as np;

c  = 29.9792458
def mkgauss3D(l=0.8e-4, F=3.0, t0=60e-6, phi0=0):
    k = 2*np.pi/l;
    w0 = F*l/(np.pi/2.0);
    xr = k*w0**2/2.0;
    E0 = 1.0;
    def _f(x): return np.sqrt(1 + (x/xr)**2);
    def _r(y,z): return np.sqrt(y**2 + z**2);
    def _phi(t,x,y,z):
        return k*(x-c*t) - 0.5*np.arctan2(x,xr) + x/xr*(_r(y,z)/w0/_f(x))**2 + phi0
    def _T(t,x):
        return np.exp(-(t/t0)**2);
    def _gauss(t,x,y,z):
        return \
            E0/_f(x)*np.exp(1j*_phi(t,x,y,z)-(_r(y,z)/_f(x)/w0)**2)*_T(t,x)
    return _gauss;


if __name__ == '__main__':
    from docopt import docopt;
    import noobna as nbna;

    opts = docopt(__doc__,help=True);
    x = np.linspace(-11.5e-4,-10.5e-4,  3);
    y = np.linspace(-11.0e-4, 11.0e-4,221);
    z = np.linspace(-11.0e-4, 11.0e-4,221);

    
    X,Y,Z = np.meshgrid(x,y,z,indexing='ij');
    gauss = mkgauss3D();
    D = gauss(0,X,Y,Z);
    RD = np.real(D);
    ID = np.imag(D);
    nbna.output(opts['<outputR>'],[x,y,z],RD);
    nbna.output(opts['<outputI>'],[x,y,z],ID);
