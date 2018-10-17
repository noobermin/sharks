#!/usr/bin/env python
'''
Usage: 
    ./genall.py [options]

Options:
     --make-target=A         Make the target for the dict with pbsbase
                             of A.
     --make-all-targets      Make all targets.
'''
from docopt import docopt
opts=docopt(__doc__,help=True);
from pys import sd, parse_ituple, savetxt;
from genpbs import genpbs;
from genlsp import mkregion_str
from gensim import gensim, fromenergy,c;
from gendat import gendat;
import numpy as np;
import shutil as sh;
e0 = 8.854e-12;
#E = 0.5e-3; # 5mJ
I = 5e18;
l = 0.8e-6
w0=1.6e-6 / np.sqrt(2*np.log(2))
T0=15e-15
#from gen45 import mk45_clean_neutral2d;

targds=[];
def addtotargs(d,f):
    d['mktargf'] = f;
    targds.append(d);

EfromI = lambda i: np.sqrt(i*1e4 * 2 / c / e0);
BfromI = lambda i: EfromI(i)/c*1e4;

d3d=dict(
    l=l,
    w=w0,
    T=T0*2,
    I=I,
    lim =(-3, 0, -7, 7, -4, 4),
    res =(3*20,14*20,8*10),
    timestep = 1e-16,
    totaltime=100e-15,
    fp=(0.0,0.0,0.0),
    phases = [np.pi/4.0, 0.0, -7e-4],
    pbsbase='angle',
    description="lasertests: angle test",
    dumpinterval=1.0e-15,
    #regions
    domains=44,
    region_dom_split='y',
    pbses='defaults',
    #density
    lspexec='lsp-10-3d',
    lsptemplate='emonly_tmpl.lsp',
    dir=True,
    #restart_interval=10,
    dump_restart_flag=True,
    #movs
    #pmovies
    no_pmovies=True,
    #particle dumps
    dump_particle=False,
    dump_field=True,
    dump_scalar=False,
    dump_number_densities_flag=False,
    dump_plasma_quantities_flag=False,
    movE=dict(
        clim=(EfromI(1e17),EfromI(5e18))
    ),
);
gensim(**d3d);

d3d_exp=sd(
    d3d,
    lim =(-3, 0, -10, 10, -4, 4),
    totaltime=120e-15,
    res =(3*20,20*20,8*10),
    phases = [np.pi/4.0, 0.0, -10e-4],
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
    pbsbase='angle2',
);
gensim(**d3d_exp);

d3d_exp3=sd(
    d3d,
    lim =(-4, 0, -11, 10, -4, 4),
    T=20e-15,
    totaltime=150e-15,
    res =(3*20,20*20,8*10),
    phases = [np.pi/4.0, 0.0, -10e-4],
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
    time_bias_iterations=0,
    pbsbase='angle3',
);
gensim(**d3d_exp3);



d3d_cfspml = sd(
    d3d,
    lim =(-3, 0, -10, 10, -4, 4),
    totaltime=120e-15,
    res =(3*20,20*20,8*10),
    phases = [np.pi/4.0, 0.0, -10e-4],
    freespace=dict(
        model_type='CFSPML',
        freesp_delta = 0.2e-4,
        num_of_cells = 8,),
    pbsbase='anglefreesp',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_cfspml);

d3d_cfspml2 = sd(
    d3d,
    lim =(-2, 2, -18, 12, -4, 4),
    totaltime=150e-15,
    res =(4*20, 30*20, 8*10),
    phases = [np.pi/4.0, 0.0, -18e-4],
    freespace=dict(
        frlim=[1e-4,2e-4, -18e-4, 12e-4, -4e-4, 4e-4],
        keep_outlets=['xmax','ymin','ymax','zmin','zmax'],
        model_type='CFSPML',
        freesp_delta = 0.0,
        num_of_cells = 8,),
    pbsbase='anglefreesp2',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_cfspml2);


cond = dict(
    outlet = 'xmin',
    start  = 0.0,
    width  = 0.1,);
d3d_cfspml3 = sd(
    d3d,
    lim =(-2, 2, -15, 15, -6, 6),
    totaltime=150e-15,
    res =(4*20, 30*20, 12*10),
    phases = [np.pi/4.0, 0.0, -15e-4],
    freespace=dict(
        frlim=[-2e-4,2e-4, -15e-4,15e-4, -6e-4,6e-4],
        model_type='CFSPML',
        freesp_delta = 0.0,
        num_of_cells = 10,),
    conductors=[
        sd(cond, outlet='xmax'),
        sd(cond, outlet='ymax'),
        sd(cond, outlet='ymin'),
        sd(cond, outlet='zmax'),
        sd(cond, outlet='zmin'),],
    pbsbase='anglefreesp3',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_cfspml3);

cond = dict(
    outlet = 'xmin',
    start  = 0.0,
    width  = 0.1,);
d3d_cfspml4 = sd(
    d3d_cfspml3,
    nolaser=True,
    lim =(-2, 2, -15, 15, -6, 6),
    totaltime=150e-15,
    res =(4*20, 30*20, 12*10),
    phases = [np.pi/4.0, 0.0, -15e-4],
    freespace=dict(
        frlim=[-2e-4,2e-4, -15e-4,15e-4, -6e-4,6e-4],
        model_type='CFSPML',
        freesp_delta = 0.0,
        num_of_cells = 8,),
    planewave_boundary=dict(
        pwblim = [-1.5e-4, 3e-4, -16e-4, 16e-4, -7e-4, 7e-4],
    ),
    conductors=[
        sd(cond, outlet='xmin'),
        sd(cond, outlet='xmax'),
        sd(cond, outlet='ymax'),
        sd(cond, outlet='ymin'),
        sd(cond, outlet='zmax'),
        sd(cond, outlet='zmin'),],
    pbsbase='anglefreesp4',
    lsptemplate='emonly83_tmpl.lsp',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_cfspml4);

d3d_cfspml5 = sd(
    d3d_cfspml4,
    nolaser=True,
    lim =(-2, 2, -15, 15, -6, 6),
    totaltime=150e-15,
    res =(4*20, 30*20, 12*10),
    freespace=dict(
        frlim=[-2e-4,2e-4, -15e-4,15e-4, -6e-4,6e-4],
        model_type='CFSPML',
        freesp_delta = 0.0,
        num_of_cells = 10,),
    planewave_boundary=dict(
        pwblim = [ -2e-4, 3e-4,
                  -16e-4, 16e-4,
                   -7e-4, 7e-4],
        rotation=270,
    ),
    pbsbase='anglefreesp5',
    lsptemplate='emonly83_tmpl.lsp',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_cfspml5);



d3d_pwb = sd(
    d3d_cfspml4,
    nolaser=True,
    lim =(-2, 2, -15, 15, -6, 6),
    totaltime=150e-15,
    res =(4*20, 30*20, 12*10),
    planewave_boundary=dict(
        pwblim = [-1.5e-4, 3e-4, -16e-4, 16e-4, -7e-4, 7e-4],
        rotation=270,
    ),
    freespace = None,
    pbsbase='pwoutlets',
    lsptemplate='emonly83_tmpl.lsp',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_pwb);




d3d_pwb2 = sd(
    d3d_pwb,
    T=20e-15,
    time_bias_iterations=0,
    nolaser=True,
    lim =(-2, 2, -15, 15, -6, 6),
    totaltime=110e-15,
    res =(4*20, 30*20, 12*10),
    planewave_boundary=dict(
        pwblim = [-1.5e-4, 3e-4, -14e-4, 14e-4, -5e-4, 5e-4],
        rotation=270,
        pwfunc=1,
    ),
    freespace = None,
    conductors= [],
    pbsbase='pwout2',
    lsptemplate='emonly83_tmpl.lsp',
    movE=dict(
        clim=(1e10,EfromI(5e18))
    ),
);
gensim(**d3d_pwb2);


d3d_pwb3 = sd(
    d3d_pwb2,
    l=1e-6,
    T=30e-15,
    totaltime=80e-15,
    time_bias_iterations=0,
    nolaser=True,
    lim =(-5, 5, -7.5, 7.5, -7.5, 7.5),
    res =(10*16, 15*16, 15*16),
    planewave_boundary=dict(
        pwblim = [-4.5e-4, 10e-4, -10e-4, 10e-4, -10e-4, 10e-4],
        rotation=0,
        azimuth=0,
        freq=3e14,
        pwfunc=3,
    ),
    freespace = dict(
        frlim_whole=True,
        model_type='CFSPML',
        num_of_cells = 6,),
    conductors=[
        sd(cond, outlet='xmin'),
        sd(cond, outlet='xmax'),
        sd(cond, outlet='ymax'),
        sd(cond, outlet='ymin'),
        sd(cond, outlet='zmax'),
        sd(cond, outlet='zmin'),],
    pbsbase='pwout3',
    lsptemplate='emonly83_tmpl.lsp',
    movE=dict(
        clim=(8e9,EfromI(5e18))
    ),
);
gensim(**d3d_pwb3);
d3d_pwb3r = sd(
    d3d_pwb3,
    planewave_boundary=sd(d3d_pwb3['planewave_boundary'],
        pwfunc=1,
    ),
    pbsbase='pwout3r');
gensim(**d3d_pwb3r);


gensim(**sd(
    d3d_exp,
    freespace=dict(
        model_type='WAVEABC',
        freesp_delta = 0.2e-4,
        keep_outlets=['xmax','ymin','ymax','zmin','zmax'],),
    pbsbase='anglefreesp_abc',)
);

