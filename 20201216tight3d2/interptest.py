#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt, sdl;
import numpy as np;
c = 29.9792458;
def testf(t):
    r  = 1e-4;
    w0 = 1.05e-4;
    rs = r**2;
    x  = -8.8e-4;
    l  = 0.71e-4;
    xr = np.pi*w0**2/l;
    w  = w0*(1 + (x/xr)**2);
    gs = rs*x/( x**2 + xr**2);
    k  = 2*np.pi/l;
    phase = k*x - np.arctan(x/xr) + k*gs
    T0  = 7e-6;
    tau = T0/np.sqrt(8*np.log(2));
    Ey0 = np.exp(-rs/w**2) * w0/w * np.cos(-k*c*t + phase)*np.exp(-((t+gs/c)/tau)**2)
    return Ey0;

def mkt(dt,s=0):
    return np.arange(-10.5e-6 + s,10.5e-6+dt + s,dt);
def mktbetter():
    #tamp start
    tms = [-10.15e-6,-10.10e-6,10.05e-6];
    hm  = np.arange(-10.0e-6,-7.0e-6,0.2e-6);
    mid = np.arange( -7.0e-6, 7.0e-6,0.1e-6);
    hp  = np.arange(  7.0e-6,10.0e-6,0.2e-6);
    tps = [10.0e-6,10.05e-6,10.10e-6,10.15e-6];
    t = np.concatenate([
        tms,hm,mid,hp,tps]);
    return t;
    
    
ts1 = mkt(20e-9);
T = 0.71e-4/c;
ts2 = mkt(T/32,s=0.0)
d1 = testf(ts1);
d2 = testf(ts2);

import matplotlib.pyplot as plt;
_, (ax1,ax2) = plt.subplots(2,1,sharex=True);
ax1.scatter(ts1,d1,marker='x',label='high');
ax1.scatter(ts2,d2,marker='+',label='low (len = {})'.format(len(ts2)));
ax1.axvline(-7e-6,ls='--',c='gray');
ax1.axvline( 7e-6,ls='--',c='gray');
ax1.legend();


ax2.scatter(ts1,np.abs(d1),marker='x',label='high');
ax2.scatter(ts2,np.abs(d2),marker='+',label='low');
ax2.axvline(-7e-6,ls='--',c='gray');
ax2.axvline( 7e-6,ls='--',c='gray');
ax2.legend();
ax2.set_yscale('log');
ax2.set_ylim(1e-6,3e-1);

plt.xlim(ts1[0],ts1[-1]);
plt.show();


