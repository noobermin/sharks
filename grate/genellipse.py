#!/usr/bin/env python
'''
usage: ./gencircle (circle|drop) [<output>]
'''

import numpy as np;

def mkellipse(No=3e22,
              a = 4e-5,
              b = 2e-5,
              floor=0.0,
              zero=0.0,
              angle=45,):
    x = np.linspace(-a,a,200)
    angle = angle/180.0 * np.pi;
    #topy  = np.sqrt(b**2 - b**2topx**2/a**2)
    def fup(x,y):
        #identify x with x on the major axis of the ellipse
        #"rotate" that x onto the x axis as xp
        xp = x / np.cos(angle);
        #map xp to point on ellipse
        yp = np.sqrt(b**2 - b**2*xp**2/a**2);
        #rotate back
        return yp*np.cos(angle)  - xp*np.sin(angle);
    def fdown(x,y):
        #identify x with x on the major axis of the ellipse
        #"rotate" that x onto the x axis as xp
        xp = x / np.cos(angle);
        #map xp to point on ellipse
        yp = -np.sqrt(b**2 - b**2*xp**2/a**2);
        #rotate back
        return yp*np.cos(angle)  - xp*np.sin(angle);

    return fup,fdown;
    
    orig = [
        (xlim[1] + xlim[0]) / 2.0,
        (ylim[1] + ylim[0]) / 2.0];
    minL = 1e-9
    if not Lo or np.abs(Lo) < minL:
        outside = lambda r: np.zeroes(r.shape);
    else:
        outside = lambda r: np.exp(-np.abs(r-ro)/Lo)*No;
    
    if not Li or np.abs(Li) < minL:
        inside = lambda r: np.ones(r.shape)*Ni;
    else:
        inside = lambda r: np.exp(-np.abs(ri-r)/Li)*No;
    
    def f(x,y):
        out = np.zeros(x.shape);
        rsq = (orig[0] - x)**2 + (orig[1] - y)**2
        r = np.sqrt(rsq);
        oexp = outside(r);
        out[r>=ro] = oexp[r>=ro];
        
        middle = np.logical_and(r < ro, r > ri)
        out[middle] = No;
        iexp = inside(r);
        out[r<=ri] = iexp[r<=ri];
        out = np.where(out > floor, out, floor);
        
        limout = np.logical_or(x <= xlim[0], x >= xlim[1]);
        limout = np.logical_or(limout, y<=ylim[0]);
        limout = np.logical_or(limout, y>=ylim[1]);
        out[limout] = zero;
        return out;
    return f;

if __name__ == "__main__":
    from docopt import docopt
    opts=docopt(__doc__,help=True);
    dx = 0.025
    mn,mx = -16,16
    lmn, lmx = -20,20
    ro,ri = 5,3
    Lo=1.0;
    Li=1.0;
    
    # if opts['circle']:
    #     F=mkcircle(
    #         dim=[mn,mx,mn,mx],
    #         No=1e22,
    #         Ni=None,
    #         floor = 1e19,
    #         ro=ro,
    #         ri=ri,
    #         Lo=Lo,
    #         Li=Li,
    #         zero=1.0,);
    # elif opts['drop']:
    #     F=mkcircle(
    #         dim=[mn,mx,mn,mx],
    #         No=1e22,
    #         Ni=1e22,
    #         ro=ro,
    #         ri=ri,
    #         Lo=Lo,
    #         Li=None,
    #         zero=1.0,);
    # else:
    #     raise ValueError("Choose one! See --help");

    # X,Y=np.mgrid[
    #     lmn:lmx + dx:dx,
    #     lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    # S=F(X,Y)*3;
    # p=plt.pcolormesh(
    #     X,Y,S,
    #     cmap='plasma',
    #     norm=LogNorm(),
    #     vmin=1e18,
    #     vmax=1e23,
    # );
    fu,fd=mkellipse(a=4e-5,b=2e-5)
    x = np.linspace(-4e-5,4e-5,100);
    plt.plot(x,fu(x,1));
    plt.plot(x,fd(x,1));
    plt.axis('equal');
    plt.show();
    #plt.colorbar();
    #plt.contour(X,Y,S,[1e19,1.7e21],colors=['gray','darkred']);

    #if opts['<output>']:
    #    plt.savefig(opts['<output>']);
    #else:
    #    plt.show();
    
