#!/usr/bin/env python
import numpy as np;

def mkpill(
        a=[-5e-4,-5e-4],
        b=[5e-4,5e-4],
        xlim=[-8e-4,8e-4,-8e-4,8e-4,],
        N0=1.08e22,
        width=0.5e-4,
        L=0.10e-4,
        floor=1e17,):
    ylim = xlim[2:];
    xlim = xlim[:2];
    ax,ay = a;
    bx,by = b;
    if ax-width/2 < xlim[0] or \
       ay-width/2 < ylim[0] or \
       bx+width/2 > xlim[1] or \
       by+width/2 > ylim[1]:
        raise ValueError("points with radius must lie within xlim!");
    m = (by-ay) / (bx-ax);
    #def _corner(x,y,good):
    #    ret = y < width/np.sqrt(2)  + ytlim[0] -(x-xtlim[0])
    #    ret|= y > -width/np.sqrt(2) + ytlim[1] -(x-xtlim[1])
    #    ret = np.logical_not(ret);
    #    return np.logical_and(ret,good);
    #def roundcorner(x,y,good):
    if floor is None:
        setfloor = lambda out,g: out;
    else:
        def _setfloor(out,good):
            flit = np.logical_and(
                out < floor, good);
            out[flit] = floor;
            return out;
        setfloor = _setfloor;
    def corner(x,y,good):
        # width is the y-intercept since width/2 is the center
        # of the ball on each end.
        ret = y-ay  < - (x-ax)*m;
        ret|= y-by  > - (x-bx)*m;
        ret = np.logical_and(good,~ret);
        ret|= (x-ax)**2 + (y-ay)**2 <= width**2/4.0;
        ret|= (x-bx)**2 + (y-by)**2 <= width**2/4.0;
        return ret;
    #if dropcorners == True:
    #    corner = _corner;
    #elif dropcorners == 'round':
    #if dropcorners is True:
    #    corner = roundcorner;
    #else:
    #    corner = lambda x,y,g: g;

    def f(x,y):
        out = np.zeros(x.shape);
        good = np.logical_and(xlim[0] <= x,x <= xlim[1]);
        good&= np.logical_and(ylim[0] <= y,y <= ylim[1]);
        solid= np.logical_and(
            good,
            np.abs((y-ay) - (x-ax)*m)/np.sqrt(2) < width/2.0);
        solid= corner(x,y,solid);
        out[solid]=N0;
        #setting surface fall off.
        falloffs = np.logical_and(good, ~solid);
        out[falloffs] = 1e19;
        D = np.abs((y-ay) - (x-ax)*m)/np.sqrt(1+m**2) - width/2.0;
        linarea = np.logical_and(
            y-ay >  -(x-ax)/m,
            y-by <  -(x-bx)/m);
        linarea&= falloffs;
        out[linarea] = N0*np.exp(-D/L)[linarea];

        #setting corner fall off.
        Ddn= np.sqrt((x-ax)**2 + (y-ay)**2) - width/2.0;
        dnarea = np.logical_and(falloffs, y-ay <=  -(x-ax)/m);
        out[dnarea] = N0*np.exp(-Ddn/L)[dnarea];

        Dup= np.sqrt((x-bx)**2 + (y-by)**2) - width/2.0;
        uparea = np.logical_and(falloffs, y-by >=  -(x-bx)/m);
        out[uparea] = N0*np.exp(-Dup/L)[uparea];
        out = setfloor(out,good);
        return out;
    return f;
if __name__ == "__main__":
    dx = 0.02
    mn,mx = -10,10,
    lmn, lmx = -11.5,11.5
    width =  0.4;
    off = 1.0/np.sqrt(2)
    xlim = [lmn,lmx,lmn,lmx]
    F1=mkpill(
        a=[mn+off,mn-off],
        b=[mx+off,mx-off],
        xlim=xlim,
        width=width,L=0.1,);
    F2=mkpill(
        a=[mn-off,mn+off],
        b=[mx-off,mx+off],
        xlim=xlim,
        width=width,L=0.1,);
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    plt.pcolormesh(X,Y,F1(X,Y)+F2(X,Y),norm=LogNorm(), vmin=1e16, vmax=4e22);
    plt.axis('equal');
    plt.colorbar();
    plt.show();
