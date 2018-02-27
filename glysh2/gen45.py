#!/usr/bin/env python
'''usage: gen45.py (45|pinprick_plasma|pinprick_neutrals|pinprick_real|neutral_only)'''
from docopt import docopt;
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
        ret = np.logical_and(good,np.logical_not(ret));
        ret|= (x-xlim[0]-width/2)**2 + (y-ylim[0]-width/2)**2 <= width**2/4.0;
        ret|= (x-xlim[1]+width/2)**2 + (y-ylim[1]+width/2)**2 <= width**2/4.0;
        return ret;
    if dropcorners == True:
        corner = _corner;
    elif dropcorners == 'round':
        corner = roundcorner;
    else:
        corner = lambda x,y,g: g;
    def f(x,y):
        out = np.zeros(x.shape);
        good =np.logical_and(xlim[0] <= x, x <= xlim[1]);
        good&=np.logical_and(ylim[0] <= y, y <= ylim[1]);
        good&=np.abs(y-x)*np.sqrt(2) < width;
        good =corner(x,y,good);
        out[good]=N0;
        return out;
    return f;

def mk45_pinprick_neutral3d(
        dim=[-35e-4,35e-4,-35e-4,35e-4,-30e-4,30e-4],
        N0=1.08e22,
        laser_radius=2.2e-4,
        L = 1e-4,
        mindensity=None,
        scalemax=None,
        width=0.5e-4,
        floor=0.0,):
    longmask = lambda x,y,z: y <= x + width/np.sqrt(2.0);
    spotmask = lambda x,y,z: np.sqrt(y**2 + z**2) <= laser_radius;
    dfront = lambda x,y: np.abs(y-x-width/np.sqrt(2))/np.sqrt(2);
    if scalemax:
        restrict_front = lambda d: d < scalemax
        minN = N0*np.exp(-scalemax/L);
        print("minimum density: {:e}".format(minN));
    elif mindensity:
        scalemax = np.log(N0/mindensity)*L
        restrict_front = lambda d: d < scalemax
        print("maximum dfront: {:e}".format(scalemax));
    else:
        restrict_front = lambda d: np.ones(d.shape).astype(bool);
    def f_neutral(x,y,z):
        out = np.ones(x.shape)*floor;
        good =np.abs(y-x)*np.sqrt(2) < width;
        out[good] = N0;
        infront =np.logical_and(
            y >= x + width/np.sqrt(2.0),
            spotmask(x,y,z));
        d = dfront(x,y);
        infront&=restrict_front(d);
        out[infront]=N0*np.exp(-d/L)[infront];
        out = np.where(out > floor, out,floor);
        return out;
    return f_neutral;



def mk45_pinprick_neutral(
        dim=[-35e-4,35e-4,-35e-4,35e-4],
        N0=1.08e22,
        laser_radius=2.2e-4,
        L = 1e-4,
        mindensity=None,
        scalemax=None,
        width=0.5e-4,
        floor=0.0,):
    longmask = lambda x,y: y <= x + width/np.sqrt(2.0);
    spotmask = lambda x,y: np.logical_and(
        y <= -x -width/np.sqrt(2.0) + np.sqrt(2)*laser_radius,
        y >= -x -width/np.sqrt(2.0) - np.sqrt(2)*laser_radius);
    dfront = lambda x,y: np.abs(y-x-width/np.sqrt(2))/np.sqrt(2);
    if scalemax:
        restrict_front = lambda d: d < scalemax
        minN = N0*np.exp(-scalemax/L);
        print("minimum density: {:e}".format(minN));
    elif mindensity:
        scalemax = np.log(N0/mindensity)*L
        restrict_front = lambda d: d < scalemax
        print("maximum dfront: {:e}".format(scalemax));
    else:
        restrict_front = lambda d: np.ones(d.shape).astype(bool);
    def f_neutral(x,y):
        out = np.ones(x.shape)*floor;
        good =np.abs(y-x)*np.sqrt(2) < width;
        out[good] = N0;
        infront =np.logical_and(
            y >= x + width/np.sqrt(2.0),
            spotmask(x,y));
        d = dfront(x,y);
        infront&=restrict_front(d);
        out[infront]=N0*np.exp(-d/L)[infront];
        out = np.where(out > floor, out,floor);
        return out;
    return f_neutral;

def mk45_pinprick_plasma(
        dim=[-35e-4,35e-4,-35e-4,35e-4],
        N0=1.08e22,
        laser_radius=2.2e-4,
        L = 1e-4,
        depth = 1e-4,
        mindensity=None,
        scalemax=None,
        width=0.5e-4,
        floor=0.0,):
    xlim = dim[:2];
    ylim = dim[2:];
    longmask = lambda x,y: np.logical_and(
        y <= x + width/np.sqrt(2.0),
        y >= x + (width-depth)/np.sqrt(2.0));
    spotmask = lambda x,y: np.logical_and(
        y <= -x -width/np.sqrt(2.0) + np.sqrt(2)*laser_radius,
        y >= -x -width/np.sqrt(2.0) - np.sqrt(2)*laser_radius);
    dfront = lambda x,y: np.abs(y-x-width/np.sqrt(2))/np.sqrt(2);
    if scalemax:
        restrict_front = lambda d: d < scalemax
        minN = N0*np.exp(-scalemax/L);
        print("minimum density: {:e}".format(minN));
    elif mindensity:
        scalemax = np.log(N0/mindensity)*L
        restrict_front = lambda d: d < scalemax
        print("maximum dfront: {:e}".format(scalemax));
    else:
        restrict_front = lambda d: np.ones(d.shape).astype(bool);
    def f_plasma(x,y):
        out = np.ones(x.shape)*floor;
        longm = longmask(x,y);
        #a gaussian radius on both sides
        spotm = spotmask(x,y)
        out[np.logical_and(longm,spotm)]=N0;
        infront =np.logical_and(
            y >= x + width/np.sqrt(2.0),
            spotm);
        d = dfront(x,y);
        infront&=restrict_front(d);
        out[infront]=N0*np.exp(-d/L)[infront];
        out = np.where(out > floor, out,floor);
        return out;
    def f_neutral(x,y):
        out = np.ones(x.shape)*floor;
        good =np.abs(y-x)*np.sqrt(2) < width;
        out[good] = N0;
        inside = np.logical_and(longmask(x,y),spotmask(x,y));
        out[inside] = floor;
        return out;
    return f_plasma, f_neutral;



def mk45_pinprick_plasma_old(
        dim=[-35e-4,35e-4,-35e-4,35e-4],
        N0=1.08e22,
        laser_radius=2.2e-4,
        L = 1e-4,
        depth = 1e-4,
        mindensity=None,
        scalemax=None,
        width=0.5e-4,
        floor=0.0,):
    xlim = dim[:2];
    ylim = dim[2:];
    longmask = lambda x,y: np.logical_and(
        x-y <= width/np.sqrt(2.0),
        x-y >= (width-depth)/np.sqrt(2.0));
    spotmask = lambda x,y: np.logical_and(
        x+y <= -width/np.sqrt(2.0)+np.sqrt(2)*laser_radius,
        x+y >= -width/np.sqrt(2.0)-np.sqrt(2)*laser_radius);
    dfront = lambda x,y: np.abs(x-y-width/np.sqrt(2.0))/np.sqrt(2);
    if scalemax:
        restrict_front = lambda d: d < scalemax
        minN = N0*np.exp(-scalemax/L);
        print("minimum density: {:e}".format(minN));
    elif mindensity:
        scalemax = np.log(N0/mindensity)*L
        restrict_front = lambda d: d < scalemax
        print("maximum dfront: {:e}".format(scalemax));
    else:
        restrict_front = lambda d: np.ones(d.shape).astype(bool);
    def f_plasma(x,y):
        out = np.ones(x.shape)*floor;
        longm = longmask(x,y);
        #a gaussian radius on both sides
        spotm = spotmask(x,y)
        out[np.logical_and(longm,spotm)]=N0;
        infront =np.logical_and(
            x-y >= width/np.sqrt(2.0),
            spotm);
        d = dfront(x,y);
        infront&=restrict_front(d);
        out[infront]=N0*np.exp(-d/L)[infront];
        out = np.where(out > floor, out,floor);
        return out;
    def f_neutral(x,y):
        out = np.ones(x.shape)*floor;
        good =np.abs(y-x)*np.sqrt(2) < width;
        out[good] = N0;
        inside = np.logical_and(longmask(x,y),spotmask(x,y));
        out[inside] = floor;
        return out;
    return f_plasma, f_neutral;


if __name__ == "__main__":
    opts = docopt(__doc__,help=True);
    dx = 0.01
    mn,mx = -10,10,
    lmn, lmx = -10,10
    width =  4;
    L = 1.0;
    depth=2.0;
    if opts['45']:
        F=mk45(dim=[mn,mx,mn,mx],width=width,dropcorners=True);
    elif opts['pinprick_plasma']:
        F=mk45_pinprick_plasma(
            dim=[mn,mx,mn,mx],
            width=width,
            laser_radius=2.0,
            L=L,
            depth=depth,
            mindensity=1e19,
            floor=1.0)[0];
    elif opts['pinprick_neutrals']:
        F=mk45_pinprick_plasma(
            dim=[mn,mx,mn,mx],
            width=width,
            laser_radius=2.0,
            mindensity=1e19,
            L=L,
            depth=depth,
            floor=1.0)[1];
    elif opts['pinprick_real']:
        dx = 0.005
        mn,  mx  = -5.0,5.0
        lmn, lmx = -5.0,5.0
        F=mk45_pinprick_plasma(
            dim=[mn,mx,mn,mx],
            width=0.46,
            laser_radius=2.2,
            L=0.04,
            depth=0.08,
            mindensity=1e18,
            floor=1.0)[1];
    elif opts['neutral_only']:
        F=mk45_pinprick_neutral(
            dim=[mn,mx,mn,mx],
            width=width,
            laser_radius=2.0,
            mindensity=1e19,
            L=L,
            floor=1.0);
    X,Y=np.mgrid[
        lmn:lmx + dx:dx,
        lmn:lmx + dx:dx];
    import matplotlib.pyplot as plt;
    from matplotlib.colors import LogNorm;
    plt.pcolormesh(X,Y,F(X,Y),norm=LogNorm(),vmin=1e18,vmax=1e22);
    plt.axis('equal');
    plt.colorbar();
    plt.show();
