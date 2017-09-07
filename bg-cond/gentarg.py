#!/usr/bin/env python2
import numpy as np;

def mkbgtarg(dim=[-44e-4,9e-4,-29e-4,29e-4,],
             N0=1.08e22,
             N_bg=1e19,
             L=1.5e-4,
             twidth=30e-4,
             sdim=[-7.5e-4,2.5e-4],):
    xlim = dim[:2];
    ylim = dim[2:];

    tylim = (ylim[0]+ylim[1])/2.0 - twidth/2.0, (ylim[0]+ylim[1])/2.0 + twidth/2.0;
    flim = sdim[0]-np.abs(np.log(N0/N_bg)*L), sdim[0];
    @np.vectorize
    def f(x,y):
        good = xlim[0] <= x <= xlim[1];
        good&= ylim[0] <= y <= ylim[1];
        if not good:
            return 0.0;
        if tylim[0] < y < tylim[1]:
            if sdim[0] < x < sdim[1]:
                return N0;
            elif flim[0] < x < flim[1]:
                return np.exp(-np.abs(x-sdim[0])/L)*N0;
        return N_bg;
    return f;

if __name__ == "__main__":
    dx = 0.5e-4
    xmn, xmx = -45e-4,10e-4,
    ymn, ymx = -30e-4,30e-4,
    bg = 2.6e14
    F=mkbgtarg(N_bg=bg);
    X,Y=np.mgrid[
        xmn:xmx + dx:dx,
        ymn:ymx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    print(np.min(F(X,Y)));
    p=plt.pcolormesh(X,Y,F(X,Y),norm=LogNorm(),vmin=1e14);
    plt.colorbar(p)
    plt.axis('equal');
    plt.show();
