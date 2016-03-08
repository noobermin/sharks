#!/usr/bin/env python2
'''
Generate an lsp file.

Usage:
  ./genlsp.py [options]

Options:
   --I=I -I I     Set the laser intesity in W/cm^2. [default: 3e18]
   --l=L -l L     Set the laser wavelength in m. [default: 780e-9]
   --w=W -w W     Set the Gaussian waist in m. [default: 2.17e-6]
   --T=T -T T     Set the pulse duration in s. [default: 60e-15]
   --lim=L -x L   Set the spatial limits of the sim as a tuple of
                  limits of the form (xmin,xmax,ymin,ymax)
                  in microns. [default: (-30, 5, -20, 20)]
   --res=R -r R   Set the spatial resolution as a tuple of the
                  form (xres,yres). [default: (1400,1600)]
   --resd=R       Set the spatial resolution as a tuple of the
                  form (xres,yres) but where the resolutions are
                  number of divisions of the wavelength in
                  each direction. If this is set, the usual
                  res option is ignored.
   --tlim=L -t L  Set the spatial limits of the target as a tuple of
                  limits of the form (xmin,xmax,ymin,ymax)
                  in microns [default: (-30, 0, -15, 15)]
   --fp=F -f F    The focal point as a tuple of positions in
                  microns [default: (0,0,0)]
   --domains=D    Set the number of domains. [default: 48]
   --time=T       Total simulation time in s.[default: 300e-15]
   --step=T       Time steps in s. [default: 4e-17]
'''

import re;
import numpy as np;
defaults = {
    'I':3e18,
    'l':780e-9,
    'w':2.17e-6,
    'lim':(-30,5,-20,20),
    'res':(1400,1600),
    'tlim':(-30,0,-15,15),
    'fp':(0,0,0),
    'domains':48,
    'totaltime':300e-15,
    'timestep':4e-17
};
def genlsp(**kw):
    pass;
from docopt import docopt;
opts=docopt(__doc__,help=True);
#requires pys
from pys import parse_ftuple

c  = 299792458
e0 = 8.8541878176e-12
E0 = np.sqrt(2*float(opts['--I'])*1e4/(c*e0))*1e-5

gettuple = lambda l,length=4,scale=1: parse_ftuple(
    opts[l],length=length,scale=scale);

xmin,xmax, ymin,ymax = gettuple("--lim",scale=1e-4)
fp = " ".join([str(i) for i in gettuple("--fp",length=3,scale=1e-4)]);
l = float(opts['--l'])*100.0
if opts['--resd']:
    xres,yres = gettuple("--resd",length=2,scale=1);
    xcells = (xmax-xmin)/(l/xres);
    ycells = (ymax-ymin)/(l/yres);
else:
    xcells,ycells = gettuple("--res",length=2,scale=1);
w0 = float(opts['--w'])*100.0;
T  = float(opts['--T'])*1e9;
targ_xmin,targ_xmax, targ_ymin,targ_ymax = gettuple('--tlim',scale=1e-4)
domains=int(opts['--domains']);
# we have that na~l/(pi*w), and the f-number~1/2na, thus
# f-number ~ pi*w/2l
fnum=np.pi*w0/2/l;
totalt=float(opts['--time'])*1e9
timestep=float(opts['--step'])*1e9;
couraunt = min(
    ((xmax-xmin)/xcells/c)*1e9,
    ((ymax-ymin)/ycells/c)*1e9)
if timestep > couraunt:
    import sys
    sys.stderr.write("warning: timestep exceeds couraunt limit\n");
with open("hotwater2d_tmpl.lsp") as f:
    s=f.read();
print(s.format(
    xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,
    xcells=xcells,ycells=ycells,
    l=l,w0=w0,E0=E0,
    fnum=fnum,
    targ_xmin=targ_xmin, targ_xmax=targ_xmax,
    targ_ymin=targ_ymin, targ_ymax=targ_ymax,
    fp=fp,pulse=T,
    intensity=opts['--I'],
    domains=domains,totalt=totalt,
    timestep=timestep
));
