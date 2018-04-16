#!/usr/bin/env python
'''
Generate a dat file.
'''
from io import BytesIO; #we python3 now
    
import re;
import numpy as np;
from pys import test,parse_numtuple,sd,take,mk_getkw;
mt  = lambda t,m=1e-4: tuple([i*m for i in t]);

c  = 299792458
c_cgs=c*100;
e0 = 8.8541878176e-12

datdefaults = {
    'expf': 1.5,
    'tlim': (0,27.5, 0,0,0.0 ,0.0,0.0),
    'n_s'  : 1e23,
    'n_min' : 1e18,
    'long_margin' : [2.5, 5.0],
    'sdim': (17.5,27.5, 0.0,0.0, 0.0,0.0),
    'type' : 'singlescale',
    'unit' : 1e-4,
    'dat_xres'  : 100,
    'datfmt'  : '%.8e',
};
def gendats(ds,**kw):
    return [ gendat(**sd(kw, d))
             for d in ds ];
def gendat(**kw):
    getkw=mk_getkw(kw,datdefaults);
    xres = getkw('dat_xres');
    yres=zres=xres;
    if test(kw,'dat_yres'): yres = kw['dat_yres'];
    if test(kw,'dat_zres'): zres = kw['dat_zres'];
    unit=getkw('unit');
    tlim = mt(getkw('tlim'),m=unit);
    fmt = getkw('datfmt');
    if test(kw,'f_1D') or test(kw, 'data1D'):
        dim = 1;
    elif (test(kw,'f_2D') or test(kw, 'data2D')) and test(kw, 'tlim'):
        dim = 2;
    elif (test(kw,'f_3D') or test(kw, 'data3D')) and test(kw, 'tlim'):
        dim = 3;
    else:
        raise ValueError("Cannot reckon data dimensionality");
    if dim == 1:
        if test(kw,'f_1D'):
            x = np.linspace(tlim[0],tlim[1],xres);
            d = getkw('f_1D')(x);
        elif test(kw,'data1D'):
            x,d = getkw('data1D');
        s = BytesIO();
        np.savetxt(s,np.array([x,d]).T,fmt=fmt,);
        return s.getvalue();
    elif dim == 2:
        if test(kw,'f_2D'):
            x = np.linspace(tlim[0],tlim[1],xres);
            if np.isclose(tlim[2],tlim[3]):
                y = np.linspace(tlim[4],tlim[5],yres);
            else:
                y = np.linspace(tlim[2],tlim[3],yres);
            X,Y = np.meshgrid(x,y,indexing='ij');
            d = getkw('f_2D')(X,Y);
        elif test(kw,'data2D'):
            x,y,d = getkw('data2D');
        s = BytesIO();
        np.savetxt(s,np.array(list(d.shape)).reshape(1,-1), fmt='%i');
        np.savetxt(s,np.array(x).reshape(1,-1), fmt=fmt);
        np.savetxt(s,np.array(y).reshape(1,-1), fmt=fmt);
        np.savetxt(s,np.array(d).T,fmt=fmt,);
        return s.getvalue();
    else:
        s = BytesIO();
        if test(kw, 'f_3D'):
            X,Y,Z = np.mgrid[
                tlim[0]:tlim[1]:xres*1j,
                tlim[2]:tlim[3]:yres*1j,
                tlim[4]:tlim[5]:zres*1j];
            d = getkw('f_3D')(X,Y,Z);
            np.savetxt(s,np.array(list(d.shape)).reshape(1,-1), fmt='%i');
            np.savetxt(s,X[:,0,0].reshape(1,-1),fmt=fmt);
            np.savetxt(s,Y[0,:,0].reshape(1,-1),fmt=fmt);
            np.savetxt(s,Z[0,0,:].reshape(1,-1),fmt=fmt);
            del X,Y,Z;
        elif test(kw,'data3D'):
            x,y,z,d = getkw('data3D');
            np.savetxt(s,np.array(list(d.shape)).reshape(1,-1), fmt='%i');
            np.savetxt(s,np.array(x).reshape(1,-1),fmt=fmt);
            np.savetxt(s,np.array(y).reshape(1,-1),fmt=fmt);
            np.savetxt(s,np.array(z).reshape(1,-1),fmt=fmt);
        #manual is probably best.
        zl = d.shape[-1];
        for i in range(zl):
            np.savetxt(s,np.array(d[:,:,i]).T,fmt=fmt);
        return s.getvalue();
    pass;

def mkdecay(solid, sdim, xdim, l):
    def out(x):
        if x <= xdim[0] or x >= xdim[1]:
            return 0.0;
        elif sdim[0] <= x <= sdim[1]:
            return solid;
        else:
            return np.exp(-np.abs(x-sdim[0])/l)*solid;
    return np.vectorize(out);

def tlim_mvorig(tlim):
    return (
        0, tlim[1]-tlim[0],
        0, tlim[3]-tlim[2],
        0, tlim[5]-tlim[4])

def genf(**kw):
    getkw=mk_getkw(kw,datdefaults);
    if getkw('type') == 'singlescale':
        tlim = mt(getkw('tlim'),m=getkw('unit'));
        xdim = tlim[0], tlim[1];
        return mkdecay(
            getkw('n_s'), mt(getkw('sdim'),m=getkw('unit')),
            xdim, getkw('expf')*getkw('unit'));
    else:
        raise NotImplementedError("Coming soon!");

onescale_defaults = sd(
    datdefaults,
    solid_len=10,
    xlen=27.5,
);
def genonescale(**kw):
    getkw=mk_getkw(kw,onescale_defaults);
    slen = getkw("solid_len");
    xlen = getkw("xlen");
    kw1 = sd(
        kw,
        tlim=(0.0, xlen) + (0.0,0.0,0.0,0.0),
        sdim= (xlen-slen, xlen) + (0.0,0.0,0.0,0.0));
    kw1['f_1D']= genf(**kw1)
    return gendat(**kw1);
