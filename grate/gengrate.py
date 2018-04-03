#!/usr/bin/env python
'''
usage: ./gengrate [<output>]
'''

import numpy as np;

def mkgrate(N0=1.08e22,
            h = 4e-5,
            w = 3e-5,
            floor=0.0,
            angle=45,
            spacing=0.65e-4):
    phi = angle/180 * np.pi;
    yax = h;
    #semiminor axis
    xax = w/2;
    def f(x,y):
        out = np.ones(x.shape).astype(bool);
        rx = x*np.cos(phi) + y*np.sin(phi)
        ry =-x*np.sin(phi) + y*np.cos(phi)
        nx = rx - np.round(rx/spacing)*spacing
        out[ry >= h]  = False;
        out[np.abs(nx) > xax]= False;
        el = yax*np.sqrt(1-nx**2/xax**2)
        el = np.nan_to_num(el)
        out[ry > el] = False;
        out[ry < 0.0]= False;
        out = np.where(out, N0, floor);
        return out;
    return f;

def mk45dum(N0=1.08e22,
            angle=45,
            floor=0.0,
            width=6e-5):
    phi = angle/180*np.pi;
    def f(x,y):
        out = np.ones(x.shape).astype(bool);
        ry =-x*np.cos(phi) + y*np.sin(phi);
        out[ry >= 0.0] = False;
        out[ry <-width] = False;
        return np.where(out, N0, floor);
    return f;

if __name__ == "__main__":
    from docopt import docopt
    opts=docopt(__doc__,help=True);
    dx = 0.025e-4
    mn,mx = -16e-4,16e-4
    lmn, lmx = -4e-4,4e-4
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
    
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    from lspplot.pc import pc;
    # S=F(X,Y)*3;
    # p=plt.pcolormesh(
    #     X,Y,S,
    #     cmap='plasma',
    #     norm=LogNorm(),
    #     vmin=1e18,
    #     vmax=1e23,
    # );
    f=mkgrate(h=0.2e-4,w=0.66e-4,spacing=0.66e-4,floor=1e18);
    S=f(X,Y);
    g=mk45dum(N0=1e21);
    S2=g(X,Y);
    r=pc(S+S2,p=(X*1e4,Y*1e4),log=True,lims=(1e19,1e22),rotate=True);
    plt.axis('equal');
    if opts['<output>']:
        plt.savefig(opts['<output>']);
    else:
        plt.show();
    
