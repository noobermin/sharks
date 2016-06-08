#!/usr/bin/env python2
'''
Generate a dat file.
'''
try:
    from cStringIO import StringIO
except ImportError:
    from io import BytesIO as StringIO;
    
import re;
import numpy as np;
from pys import test,parse_numtuple,sd,take,mk_getkw;
joinspace = lambda l: " ".join([str(i) for i in l]);

c  = 299792458
c_cgs=c*100;
e0 = 8.8541878176e-12

defaults = {
    'scale': 1.5e-4,
    'tlim': (0,27.5e-4, 0,0,0.0 ,0.0,0.0),
    'n_s'  : 1e23,
    'sdim': (17.5e-4,27.5e-4, 0.0,0.0, 0.0,0.0),
    'type' : 'singlescale',
};
def gentargetdat(**kw):
    getkw=mk_getkw(kw,defaults);
    tlim = getkw('tlim');
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
            x = np.linspace(tlim[0],tlim[1],100);
            d = getkw('f_1D')(x);
        elif test(kw,'data1D'):
            x,d = getkw('data1D');
        s = StringIO();
        np.savetxt(s,np.array([x,d]).T,fmt='%.8e',);
        return s.getvalue();
    elif dim == 2:
        if test(kw,'f_2D'):
            x = np.linspace(tlim[0],tlim[1],100);
            if isnp.close(tlim[2]-tlim[3],0):
                y = np.linspace(tlim[4],tlim[5],100);
            else:
                y = np.linspace(tlim[2],tlim[3],100);
            X,Y = np.meshgrid(x,y);
            d = getkw('f_2D')(X,Y);
        elif test(kw,'data2D'):
            x,y,d = getkw('data2D');
        s = StringIO();
        s.write("{} {}\n".format(d.shape[0],d.shape[1]));
        np.savetxt(s,np.array([x]).T,fmt='%.8e')
        np.savetxt(s,np.array([y]).T,fmt='%.8e')
        np.savetxt(s,np.array(d).T,fmt='%.8e',);
        return s.getvalue();
    else:
        raise NotImplementedError("Not yet!");
        # if test(kw, 'f_3D'):
        #     x = np.linspace(tlim[0],tlim[1],100);
        #     y = np.linspace(tlim[2],tlim[3],100);
        #     z = np.linspace(tlim[4],tlim[5],100);
        #     X,Y,Z = np.meshgrid(x,y,z);
        #     d = getkw('f_3d')(X,Y,Z);
        # else:
        #     x,y,z,d = getkw('data3D');
        # s = StringIO();
        # s.write("{} {} {}\n".format(d.shape[0],d.shape[1], d.shape[2]));
        # np.savetxt(s,np.array([x]).T,fmt='%.8e')
        # np.savetxt(s,np.array([y]).T,fmt='%.8e')
        # np.savetxt(s,np.array([z]).T,fmt='%.8e')
        # np.savetxt(s,np.array(d).T,fmt='%.8e',); s.write("\n");
        # return s.getvalue();
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
    getkw=mk_getkw(kw,defaults);
    if getkw('type') == 'singlescale':
        tlim = getkw('tlim');
        xdim = tlim[0],tlim[1];
        return mkdecay(
            getkw('n_s'),getkw('sdim'),xdim,getkw('scale'))
    else:
        raise NotImplementedError("Coming soon!");
    #NOTE This uses xy indexing over ij indexing.

onescale_defaults = sd(
    defaults,
    solid_len=10e-4,
    xlen=27.5e-4,
);
def genonescale(**kw):
    getkw=mk_getkw(kw,onescale_defaults);
    slen = getkw("solid_len");
    xlen = getkw("xlen");
    kw['tlim']= (0.0, xlen) + (0.0,0.0,0.0,0.0);
    kw['sdim']= (xlen-slen, xlen) + (0.0,0.0,0.0,0.0);
    kw['f_1D']= genf(**kw);
    return gentargetdat(**kw);
