#!/usr/bin/env python
import numpy as np;


def mkcircle(dim=[-7e-4,7e-4,-7e-4,7e-4,-7e-4,7e-4,],
             No=1e22,
             r=5e-4
             L=0.05e-4
             floor=0.0,
             zero=0.0,):
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
    def f(x,y,z):
        out = np.zeros(x.shape);
        rsq = (orig[0] - x)**2 + (orig[1] - y)**2 + (orig[2] - z)**2
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

if __name__=='__main__':
    dx = 0.02
    lmn, lmx = -11.5,11.5
    width =  0.4;
    off = 1.0/np.sqrt(2)
    xlim = [lmn,lmx,lmn,lmx];
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    plt.pcolormesh(X,Y,F1(X,Y),norm=LogNorm(), vmin=1e16, vmax=4e22);
    plt.axis('equal');
    plt.colorbar();
    plt.show();
