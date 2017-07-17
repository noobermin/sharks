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
if __name__ == "__main__":
    dx = 0.01
    mn,mx = -10,10,
    lmn, lmx = -11,11
    ro,ri = 5,3
    F=mkcircle(dim=[mn,mx,mn,mx],
               ro=ro,ri=ri,
               Ni=1e22,);
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    plt.pcolormesh(X,Y,F(X,Y));
    plt.axis('equal');
    plt.show();
