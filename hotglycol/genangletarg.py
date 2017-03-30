#!/usr/bin/env python2
import numpy as np;
import matplotlib.pyplot as plt;

def mk45(dim=[-5e-4,5e-4,-5e-4,5e-4,],
         N0=1.08e22,
         width=0.5e-4,
         dropcorners=False,):
    xlim = dim[:2];
    ylim = dim[2:];
    def _corner(x,y):
        ret = y < width/np.sqrt(2) + ylim[0] -(x-xlim[0])
        ret|= y > -width/np.sqrt(2) + ylim[1] -(x-xlim[1])
        return not ret;
    if dropcorners:
        corner = _corner;
    else:
        corner = lambda x,y: True;
    @np.vectorize
    def f(x,y):
        good = xlim[0] <= x <= xlim[1];
        good&= ylim[0] <= y <= ylim[1];
        good&=corner(x,y);
        good&=np.abs(y - x)*np.sqrt(2) < width
        if good:
            return 1.0
        else:
            return 0.0;
    return f;
if __name__ == "__main__":
    dx = 0.2
    mn,mx = -6,6,
    width =  2*np.sqrt(2);
    F=mk45(dim=[mn,mx,mn,mx],width=width,dropcorners=True);
    X,Y=np.mgrid[
        mn:mx + dx:dx,
        mn:mx + dx:dx];
    plt.pcolormesh(X,Y,F(X,Y));
    plt.show();
