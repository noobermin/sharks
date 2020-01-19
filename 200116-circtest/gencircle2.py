#!/usr/bin/env python
'''
usage: ./gencircle (circle|drop) [<output>]
'''

import numpy as np;

def mkcircle(dim=[-5e-4,5e-4,-5e-4,5e-4,],
             No=3e22,
             Ni=3e20,
             ro=5e-4,
             ri=0.0,
             Lo=1.6e-4,
             Li=None,
             floor=0.0,
             zero=0.0,
):
    xlim = dim[:2];
    ylim = dim[2:];
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

def mkpartcircle(
        dim=[-5e-4,5e-4,-5e-4,5e-4,],
        N0=3e22,
        ro=5e-4,
        ri=0.0,
        L=1.6e-4,
        floor=0.0,
        zero=0.0,):


if __name__ == "__main__":
    from docopt import docopt
    opts=docopt(__doc__,help=True);
    dx = 0.025
    mn,mx = -16,16
    lmn, lmx = -20,20
    ro,ri = 5,3
    Lo=1.0;
    Li=1.0;
    if opts['circle']:
        F=mkcircle(
            dim=[mn,mx,mn,mx],
            No=1e22,
            Ni=None,
            floor = 1e19,
            ro=ro,
            ri=ri,
            Lo=Lo,
            Li=Li,
            zero=1.0,);
    elif opts['drop']:
        F=mkcircle(
            dim=[mn,mx,mn,mx],
            No=1e22,
            Ni=1e22,
            ro=ro,
            ri=ri,
            Lo=Lo,
            Li=None,
            zero=1.0,);
    else:
        raise ValueError("Choose one! See --help");

    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    S=F(X,Y)*3;
    p=plt.pcolormesh(
        X,Y,S,
        cmap='plasma',
        norm=LogNorm(),
        vmin=1e18,
        vmax=1e23,
    );
    plt.colorbar();
    plt.contour(X,Y,S,[1e19,1.7e21],colors=['gray','darkred']);
    plt.axis('equal');
    if opts['<output>']:
        plt.savefig(opts['<output>']);
    else:
        plt.show();
    
