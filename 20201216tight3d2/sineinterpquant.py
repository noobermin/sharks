#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --help           Help me help you.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
import numpy as np;
import matplotlib.pyplot as plt;

def mkdom(f):
    dom = 2*np.pi/f;
    return np.arange(0,2*np.pi + dom,dom);

domref = mkdom(200);
dom32   = mkdom(32);
dom24   = mkdom(24);



def mklintrp(ts,t,f):
    samp = f(ts);
    TS,T = np.meshgrid(ts,t,indexing='ij');
    bot = np.argmax(T<TS,axis=0) - 1
    top = bot + 1;
    Is = [];
    ws = [];
    for tv,b in zip(t,bot):
        if b == -1:
            if tv < ts[0]:
                b = 0;
                w = 1.0;
            elif tv >= ts[-1]:
                b = len(ts) - 2;
                w = 0.0;
        else:
            w = (tv - ts[b])/(ts[b+1]-ts[b])
        Is.append(b);
        ws.append(w);
    Is = np.array(Is);
    ws = np.array(ws);
    test = samp[Is]*(1-ws) + samp[Is+1]*ws;
    ref  = f(t);
    return ts,samp,test,ref;

c = 29.9792458;
d50a = 2*np.pi/0.710e-4*c*50e-9;
dom50atto = np.arange(0,2*np.pi + d50a,d50a);

N  = 24;
dt = 2*np.pi * np.linspace(0,1.0,N+1) + 2*np.pi/N/2.0;
cosdom = 0.5*(1+np.cos(2*dt));
cosdom = np.concatenate([[0],4*np.pi*(np.cumsum(cosdom))/N]);
print(cosdom);

#ts,samp,t,r  = mklintrp(dom50atto, domref,np.sin);
ts,samp,t,r  = mklintrp(cosdom, dom50atto,np.sin);

rdiff = (t-r)**2 / r**2;
rdiff = np.where(r!=0,rdiff, 0.0);
print(rdiff);
import matplotlib.pyplot as plt;
_, (ax1,ax2) = plt.subplots(2,1,sharex=True);
ax1.plot(dom50atto,r,label='reference',alpha=0.4);
ax1.scatter(ts,samp,marker='o',label='samples',c='yellowgreen',alpha=1.0);
ax1.scatter(dom50atto,t,marker='+',label='test',c='orangered',alpha=1.0);
ax1.legend();


ax2.scatter(dom50atto,np.abs(r),marker='x',label='reference');
ax2.scatter(dom50atto,np.abs(t),marker='+',label='test');
ax2.legend();
ax2.set_yscale('log');
ax2.set_ylim(1e-6,2);

plt.xlim(domref[0],domref[-1]);
plt.show();
