#!/usr/bin/env python
'''
Usage:
    ./nour2.py [options] <namefmt>

Options:
     --help -h        Help me.
     --x-dims=X       Set X dimensions. [default: (-20.1e-4,-19.9e-4,5)]
     --y-dims=Y       Set Y dimensions. [default: (-13.2e-4,13.2e-4,201)]
     --z-dims=Z       Set Z dimensions. [default: (-13.2e-4,13.2e-4,201)]
     --f-num=F        Set f-number. [default: 2]
     --t0=T           Set t0. [default: 40e-6]
'''
from docopt import docopt;
import numpy as np;

def mkEfs(l=0.8e-4,F=2,phi0=0.0,t0=40e-6):
    E0=1.0;
    w0 = r0 = 2*l*F/np.pi;
    k  = 2*np.pi/l;
    c  = 29.9792458
    om = k*c;
    zr = k*r0**2/2.0;

    def f(z): return np.sqrt(1 + (z/zr)**2);
    #def phi(t,z,r):
    #    return om*t - k*z + 2 * np.arctan2(z,zr) - z/zr * (r/(r0*f(z)))**2 + phi0
    def phi(t,z,r):
        return -om*t + k*z - 2*np.arctan2(z,zr) + z/zr * (r/(r0*f(z)))**2 + phi0


    def gauss(t,z,r):
        return E0 / f(z)*np.cos(phi(t,z,r))*np.exp( -(r/(f(z)*r0))**2)*np.exp( -((t-z/c)/(2*t0))**2);
    def gauss_sp(z,r):
        return E0 / f(z) * np.exp( - (r/(f(z)*r0))**2 );

    def E_r(t, z, r):
        return  r / (r0*f(z)) * gauss(t,z,r);
    def E_z(t, z, r):
        A = 2/k*r0*f(z);
        return A*( (1 - (r/(r0*f(z)))**2)*np.sin(phi(t,r,z)) - z/zr*(r/(r0*f(z)))**2*np.cos(phi(t,r,z)))*gauss(t,z,r);

    def E_r_sp(z,r):
        return r / (r0*f(z)) * gauss_sp(z,r);
    def phase(z,r):
        return np.exp(1j*(k*z-2*np.arctan2(z,zr) + z/zr*(r/(r0*f(z)))**2 + phi0));
    return E_r_sp,phase;
if __name__ == '__main__':
    from pys import parse_ftuple;
    opts = docopt(__doc__,help=True);
    F    = float(opts['--f-num']);
    t0   = float(opts['--t0']);
    xmin,xmax,xres = parse_ftuple(opts['--x-dims'],3);
    ymin,ymax,yres = parse_ftuple(opts['--y-dims'],3);
    zmin,zmax,zres = parse_ftuple(opts['--z-dims'],3);
    xres,yres,zres = int(xres),int(yres),int(zres);
    x = np.linspace(xmax, xmin, xres);
    y = np.linspace(ymax, ymin, yres);
    z = np.linspace(zmax, zmin, zres);
    
    X,Y,Z = np.meshgrid(x,y,z,indexing='ij');
    
    R = np.sqrt(Y**2 + Z**2);
    #Ex = E_z(t0, X, R);
    #Er = E_r(t0, X, R);
    Erf,phasef = mkEfs(F=F,t0=t0);
    Er_sp = Erf(X,R)*phasef(X,R);
    # make Er into Ey and Ez...flipping to lsp coordinate system.
    cs = np.where(R>0,Y/R,0.0);
    sn = np.where(R>0,Z/R,0.0);
    Ey = cs*Er_sp;
    Ez = sn*Er_sp;
    Ersq = np.sqrt(np.abs(Ey)**2 + np.abs(Ez)**2);
    out = dict(
        Ey_real=np.real(Ey), Ey_imag=np.imag(Ey),
        Ez_real=np.real(Ez), Ez_imag=np.imag(Ez));
    namefmt = opts['<namefmt>'];
    names = {
        k : namefmt.format(k) for k in out };
    print("basic statistics");
    print("max: {:e}".format(np.max(Ersq)));
    print("min: {:e}".format(np.min(Ersq)));
    #np.savez(opts['<output>'],Ey=Ey,Ez=Ez);
    from noobna import output;
    for k in out:
        name = names[k]
        output(name,(x,y,z),out[k]);
