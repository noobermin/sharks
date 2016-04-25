#!/usr/bin/env python2
'''
Generate an lsp file.

Usage:
  ./genlsp.py [options]

Options:
   --I=I -I I        Set the laser intesity in W/cm^2. [default: 3e18]
   --l=L -l L        Set the laser wavelength in m. [default: 780e-9]
   --w=W -w W        Set the Gaussian waist in m. [default: 2.17e-6]
   --T=T -T T        Set the pulse duration in s. [default: 60e-15]
   --lim=L -x L      Set the spatial limits of the sim as a tuple of
                     limits of the form (xmin,xmax,ymin,ymax)
                     in microns. [default: (-30, 5, -20, 20, -20, 20)]
   --res=R -r R      Set the spatial resolution as a tuple of the
                     form (xres,yres). [default: (350,400, 400)]
   --resd=R          Set the spatial resolution as a tuple of the
                     form (xres,yres) but where the resolutions are
                     number of divisions of the wavelength in
                     each direction. If this is set, the usual
                     res option is ignored.
   --tlim=L -t L     Set the spatial limits of the target as a tuple of
                     limits of the form (xmin,xmax,ymin,ymax)
                     in microns [default: (-27.5, 0, -15, 15, -15, 15)]
   --comp=C          Set the components (polarization) [default: (0,1,0)]
   --phases=PS       Set the component phases [default: (0,0,0)]
   --fp=F -f F       The focal point as a tuple of positions in
                     microns [default: (0,0,0)]
   --domains=D       Set the number of domains. [default: 48]
   --no-pmovies      Turn off pmovies.   
   --totaltime=T     Total simulation time in s.[default: 300e-15]
   --timestep=T      Time steps in s. [default: 4e-17]
   --pext-species=S  List of pext species to track. [default: (10,)]  
   --targetdat=D     Set the target .dat filename [default: watercolumn.dat]
   --dumpinterval=T  Specify the dump interval [default: 2e-16 ]
   --description=D   Set the description [default: Hotwater]
   --restart=R       Set the restart time.
'''

import re;
import numpy as np;
from pys import test,parse_numtuple,sd,take;
joinspace = lambda l: " ".join([str(i) for i in l]);

c  = 299792458
c_cgs=c*100;
e0 = 8.8541878176e-12

defaults = {
    'I':3e18,
    'l':780e-9,
    'w':2.17e-6,
    'T':60e-15,
    'lim':(-30,5,-20,20, -20, 20),
    'res':(350,400,400),
    'tlim':(-27.5,0, -15,15, -15, 15),
    'fp':(0,0,0),
    'domains':48,
    'totaltime':300e-15,
    'timestep':1e-16,
    'components':(0,1,0),
    'phases':(0,0,0),
    'targetdat':'watercolumn.dat',
    'dumpinterval':2e-16,
    'description':'Hotwater in 2d',
    'pext_species':(10,),
    'restart':None,
};

pext_defaults = sd(
    defaults,
    species=(10,),
    start_time=0,
    stop_time=1);

def genpext(**kw):
    def getkw(l,scale=None):
        if test(kw, l):
            ret = kw[l]
        else:
            ret = pext_defaults[l];
        if scale:
            return [scale*i for i in ret];
        return ret;

    tmpl='''
;
extract{i}
species {species}
direction {direction}
maximum_number  1000000000
start_time {start_time}
stop_time  {stop_time}
at {position}
'''
    lims = list(getkw('lim',scale=1e-4));
    lims[0] = [lims[0],0,0];
    lims[1] = [lims[1],0,0];
    lims[2] = [0,lims[2],0];
    lims[3] = [0,lims[3],0];
    lims[4] = [0,0,lims[4]];
    lims[5] = [0,0,lims[5]];
    dirs = ['X','X','Y','Y','Z','Z'];
    def formatsp(sp,i):
        return [
            dict(i=i+j+1,
                 species=sp,
                 direction=d,
                 start_time=getkw('start_time'),
                 stop_time =getkw('stop_time'),
                 position  =joinspace(lim))
            for j,(d,lim) in enumerate(zip(dirs,lims))];
    return joinspace(
        [tmpl.format(**d)
         for i,sp in enumerate(getkw('species'))
         for d in formatsp(sp,4*i)])

region_defaults = sd(
    defaults,
    region_split=('z',1),
    region_dom_split='x');

region_tmpl=''';
region{i}
xmin             {xmin:e}
xmax             {xmax:e}

ymin             {ymin:e}
ymax             {ymax:e}

zmin             {zmin:e}
zmax             {zmax:e}
;
number_of_domains {domains}
split_direction {split}
number_of_cells AUTO ; {cells}
;
'''

def mkregion_str(regions):
    def format_region(region):
        if not test(region,"cells"):
            region['cells'] = ""
        else:
            region['cells'] = "cells = {}".format(region['cells'])
        return region_tmpl.format(**region);
    
    return ''.join([format_region(region)
                    for region in regions ]);

def genregions(**kw):
    def getkw(l,scale=None):
        if test(kw, l):
            ret = kw[l]
        else:
            ret = region_defaults[l];
        if scale:
            return [scale*i for i in ret];
        return ret;
    regsplit_dir, subdivs = getkw('region_split');
    
    nonsplits = [x for x in ['x','y','z']
                 if x != regsplit_dir ];
    limkw = [x+lims
             for x in ['x','y','z']
             for lims in ['min','max']];
    lims = {k:lim for k,lim in zip(limkw,getkw('lim',scale=1e-4))};
    
    total_doms = getkw('domains');
    doms =  [total_doms//subdivs for i in range(subdivs)];
    doms[-1] += total_doms % subdivs;
    lmn,lmx = regsplit_dir+'min', regsplit_dir+'max';
    mn,mx = lims[lmn],lims[lmx]
    edges = [mn+i*(mx-mn)/subdivs
             for i in range(subdivs)] + [mx];
    mins = edges[:-1];
    maxs = edges[1:];
    if test(kw,"xcells") and test(kw,"ycells") and test(kw,"zcells"):
        zcells_per_region = [kw['zcells']//subdivs 
                             for i in range(subdivs)]
        zcells_per_region[-1] += kw['zcells'] % subdivs;
        
        cellses = [ kw['xcells']*kw['ycells']*zc
                    for i,zc in enumerate(zcells_per_region)];
    else:
        cellses = [None for i in range(subdivs)];
    reg = sd(lims,split=getkw("region_dom_split").upper()+"SPLIT")
    regions = [ sd(reg,**{lmn:mn,lmx:mx,'i':i+1,'domains':di,'cells':cells})
                for i,(mn,mx,di,cells) in enumerate(zip(mins,maxs,doms,cellses)) ];
    return mkregion_str(regions);
        
def genlsp(**kw):
    def getkw(l,scale=None):
        if test(kw, l):
            ret = kw[l]
        else:
            ret = defaults[l];
        if scale:
            return [scale*i for i in ret];
        return ret;

    E0 = np.sqrt(2*getkw('I')*1e4/(c*e0))*1e-5
    xmin,xmax, ymin,ymax, zmin,zmax = getkw('lim',scale=1e-4)
    fp = joinspace(getkw("fp",scale=1e-4));
    components = joinspace(getkw("components"));
    phases = joinspace(getkw("phases"));
    l = getkw('l')*100.0
    if test(kw,'resd'):
        xres,yres,zres = getkw("resd");
        kw['xcells'] = (xmax-xmin)/(l/xres);
        kw['ycells'] = (ymax-ymin)/(l/yres);
        kw['zcells'] = (zmax-zmin)/(l/zres);
    else:
        kw['xcells'], kw['ycells'], kw['zcells'] = getkw("res");
    xcells, ycells, zcells = kw['xcells'], kw['ycells'], kw['zcells']
    w0 = getkw('w')*100.0;
    T  = getkw('T')*1e9;
    txmin,txmax,tymin,tymax,tzmin,tzmax=getkw('tlim',scale=1e-4);
    domains=getkw('domains');
    # we have that na~l/(pi*w), and the f-number~1/2na, thus
    # f-number ~ pi*w/2l
    fnum=np.pi*w0/2/l;
    totaltime=getkw('totaltime')*1e9
    timestep=getkw('timestep')*1e9;
    couraunt = min(
        ((xmax-xmin)/xcells/c_cgs)*1e9,
        ((ymax-ymin)/ycells/c_cgs)*1e9,
        ((zmax-zmin)/zcells/c_cgs)*1e9,)
    if timestep > couraunt:
        import sys
        sys.stderr.write("warning: timestep exceeds couraunt limit\n");
    targetdat = getkw('targetdat');
    dumpinterval=getkw('dumpinterval')*1e9;
    description=getkw('description');
    restart = getkw('restart');

    pexts = genpext(**sd(kw,species=getkw('pext_species')));
    if test(kw, "regions"):
        regions = kw['regions'];
    else:
        regions = genregions(**kw);
    if not test(kw,"no_pmovies"):
        pmovies ='''
particle_movie_interval_ns {dumpinterval}
particle_movie_components Q X Y Z VX VY VZ XI YI ZI
'''.format(dumpinterval=dumpinterval);
    else:
        pmovies = '';
    restarts = "maximum_restart_dump_time {}".format(restart) if restart else "";
    with open("hotwater3d_tmpl.lsp") as f:
        s=f.read();
    s=s.format(
        xmin=xmin,xmax=xmax,
        ymin=ymin,ymax=ymax,
        zmin=zmin,zmax=zmax,
        xcells=kw['xcells'],ycells=kw['ycells'],zcells=kw['zcells'],
        l=l,w0=w0,E0=E0,
        fnum=fnum,
        targ_xmin=txmin, targ_xmax=txmax,
        targ_ymin=tymin, targ_ymax=tymax,
        targ_zmin=tzmin, targ_zmax=tzmax,
        fp=fp,pulse=T,components=components,phases=phases,
        intensity=getkw('I'),
        pmovies=pmovies,
        regions=regions,
        pexts=pexts,
        domains=domains,
        totaltime=totaltime,
        timestep=timestep,
        targetdat=targetdat,
        dumpinterval=dumpinterval,
        description=description,
        restarts=restarts,
    );
    return s;
if __name__ == "__main__":
    from docopt import docopt;
    opts=docopt(__doc__,help=True);
    gettuple = lambda l,length=6,scale=1,intype=float: parse_numtuple(
        opts[l],intype,length=length,scale=scale);
    #requires pys
    from pys import parse_ftuple
    kw =dict(
        lim = gettuple("--lim"),
        fp  = gettuple("--fp",length=3),
        w   = float(opts['--w']),
        T   = float(opts['--T']),
        l   = float(opts['--l']),
        I   = float(opts['--I']),
        tlim= gettuple('--tlim'),
        domains=int(opts['--domains']),
        totaltime=float(opts['--time']),
        timestep=float(opts['--step']),
        components=gettuple("--comp",length=3),
        phases=gettuple("--phases",length=3),
        pext_species= gettuple("--pext-species",length=None,intype=int),
        description=opts['--description'],
        targetdat=opts['--targetdat'],
        no_pmovies=opts['--no-pmovies'],
        restart = float(opts['--restart']) if opts['--restart'] else None,
    );
    if opts['--resd']:
        kw.update({'resd':gettuple("--resd",length=2,scale=1)});
    else:
        kw.update({'res':gettuple("--res",length=2,scale=1)});
    print(genlsp(**kw));

