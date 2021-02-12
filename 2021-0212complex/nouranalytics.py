#!/usr/bin/env python
'''
Usage:
    ./nour2.py [options] <namefmt>

Options:
     --help -h        Help me.
'''
from docopt import docopt;
import numpy as np;

E0 = 1.0;
l  = 0.8e-4;
F  = 2.0
w0 = r0 = 2*l*F/np.pi;
k  = 2*np.pi/l;
c  = 29.9792458
om = k*c;
zr = k*r0**2/2.0;

z0 = -20e-4
ts = -20e-4/c
phi0 = 0.0;
t0 = 40e-6;
print(zr);
def f(z): return np.sqrt(1 + (z/zr)**2);
#def phi(t,z,r): return om*t - k*z + 2 * np.arctan2(z,zr) - z/zr * (r/(r0*f(z)))**2 + phi0
def phi(t,z,r): return -om*t + k*z - 2*np.arctan2(z,zr) + z/zr * (r/(r0*f(z)))**2 + phi0
print(f(z0));

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

if __name__ == '__main__':
    opts = docopt(__doc__,help=True);
    x = np.linspace(-20.1e-4, -19.9e-4, 5);
    y = np.linspace(-13.2e-4,  13.2e-4, 201);
    z = np.linspace(-13.2e-4,  13.2e-4, 201);
    X,Y,Z = np.meshgrid(x,y,z,indexing='ij');
    
    R = np.sqrt(Y**2 + Z**2);
    #Ex = E_z(t0, X, R);
    #Er = E_r(t0, X, R);
    Er_sp = E_r_sp(X,R)*phase(X,R);
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
