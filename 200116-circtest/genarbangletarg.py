#!/usr/bin/env python
import numpy as np;
from genangletarg import mkpill;
dx = 0.02
lmn, lmx = -11.5,11.5
width =  0.4;
off = 1.0/np.sqrt(2)
xlim = [lmn,lmx,lmn,lmx]
F1=mkpill(
    a=[-8,-8],
    b=[2,7],
    xlim=xlim,
    width=width,L=0.1,);
X,Y=np.mgrid[
    lmn:lmx + dx:dx,
    lmn:lmx + dx:dx];
import matplotlib.pyplot as plt;
from matplotlib.colors import LogNorm;
plt.pcolormesh(X,Y,F1(X,Y),norm=LogNorm(), vmin=1e16, vmax=4e22);
plt.axis('equal');
plt.colorbar();
plt.show();
