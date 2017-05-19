#!/usr/bin/env python2
import numpy as np;

def mk45(dim=[-5e-4,5e-4,-5e-4,5e-4,],
         N0=1.08e22,
         width=0.5e-4,
         dropcorners=False,):
    xlim = dim[:2];
    ylim = dim[2:];
    def _corner(x,y,good):
        ret = y < width/np.sqrt(2) + ylim[0] -(x-xlim[0])
        ret|= y > -width/np.sqrt(2) + ylim[1] -(x-xlim[1])
        ret = np.logical_not(ret);
        return np.logical_and(ret,good);
    def roundcorner(x,y,good):
        ret = y <  ylim[0] + width - (x-xlim[0])
        ret|= y >  ylim[1] - width - (x-xlim[1])
        ret = good and not ret;
        ret|= (x-xlim[0]-width/2)**2 + (y-ylim[0]-width/2)**2 <= width**2/4.0;
        ret|= (x-xlim[1]+width/2)**2 + (y-ylim[1]+width/2)**2 <= width**2/4.0;
        return ret;
    if dropcorners == True:
        corner = _corner;
    elif dropcorners == 'round':
        corner = roundcorner;
    else:
        corner = lambda x,y,g: g;
    @np.vectorize
    def f(x,y):
        good = xlim[0] <= x <= xlim[1];
        good&= ylim[0] <= y <= ylim[1];
        good&=np.abs(y - x)*np.sqrt(2) < width;
        good =corner(x,y,good);
        
        if good:
            return N0;
        else:
            return 0.0;
    return f;
if __name__ == "__main__":
    dx = 0.02
    mn,mx = -6,6,
    lmn, lmx = -6,6
    width =  2;
    F=mk45(dim=[mn,mx,mn,mx],width=width,dropcorners='round');
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    plt.pcolormesh(X,Y,F(X,Y));
    plt.axis('equal');
    plt.show();
