#!/usr/bin/env python2
import numpy as np;

def mkcircle(dim=[-5e-4,5e-4,-5e-4,5e-4,],
             No=3e22,
             Ni=3e20,
             ro=5e-4,
             ri=0.0):
    xlim = dim[:2];
    ylim = dim[2:];
    orig = [
        (xlim[1] + xlim[0]) / 2.0,
        (ylim[1] + ylim[0]) / 2.0];
    @np.vectorize
    def f(x,y):
        good = xlim[0] <= x <= xlim[1];
        good&= ylim[0] <= y <= ylim[1];
        rsq = (orig[0] - x)**2 + (orig[1] - y)**2
        out = good and (ri**2 <= rsq <= ro**2);
        inn = good and (rsq < ri**2);
        if out:
            return No;
        elif inn:
            return Ni;
        else:
            return 0.0;
    return f;

def fuzzcircle(
        dim=[-5e-4,5e-4,-5e-4,5e-4,],
        No=3.34e22,
        ro=5e-4,
        zero=0.0,
        L=1.5e-4,
        prexp=False,):
    xlim = dim[:2];
    ylim = dim[2:];
    orig = [
        (xlim[1] + xlim[0]) / 2.0,
        (ylim[1] + ylim[0]) / 2.0];
    if prexp:
        No = No/(L**2/ro**2 + (L/ro + 1)**2);
        print(No);
    def f(x,y):
        out = np.zeros(x.shape);
        rsq = (orig[0] - x)**2 + (orig[1] - y)**2
        r = np.sqrt(rsq);
        #iexp = np.exp(-np.abs(r-ri)/L)*No;
        oexp = np.exp(-np.abs(r-ro)/L)*No;
        #out[r < ri] = iexp[r < ri];
        out[r > ro] = oexp[r > ro];
        #out[np.logical_and(ri <= r, r<= ro)] = No;
        out[r <= ro] = No;
        limout = np.logical_or(x <= xlim[0], x >= xlim[1]);
        limout = np.logical_or(limout, y<=ylim[0]);
        limout = np.logical_or(limout, y>=ylim[1]);
        out[limout] = zero;
        return out;
    return f;

if __name__ == "__main__":
    dx = 0.05
    mn,mx = -16,16
    lmn, lmx = -20,20
    ro,ri = 5,3
    L=1.0
    F=fuzzcircle(
        dim=[mn,mx,mn,mx],
        ro=ro,
        L=L,
        prexp=True,
        zero=1.0,);
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    S=F(X,Y)*3;
    p=plt.pcolormesh(
        X,Y,S,
        cmap='magma',
        norm=LogNorm(),
        vmin=1e18,
        vmax=1e23,
    );
    plt.colorbar();
    plt.contour(X,Y,S,[1e19,1.7e21]);
    plt.axis('equal');
    plt.show();
