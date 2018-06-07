#!/usr/bin/env python
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
   --dens_dat=D      Set the target .dat filename [default: watercolumn.dat]
   --dumpinterval=T  Specify the dump interval [default: 2e-16 ]
   --description=D   Set the description [default: Hotwater]
   --restart=R       Set the restart time.
'''
import sys;
import re;
import numpy as np;
from pys import test,parse_numtuple,sd,take,mk_getkw;
from collections import OrderedDict;
joinspace = lambda l: " ".join([str(i) for i in l]);
mt  = lambda t,m=1e-4: tuple([i*m for i in t]);
scaletuple=mt;
import types;
def isvalue(v):
    a = isinstance(v, str);
    b = isinstance(v, float);
    c = isinstance(v, int);
    return a or b or c;

c  = 299792458
c_cgs=c*100;
e0 = 8.8541878176e-12

lspdefaults = dict(
    I=3e18,
    l=780e-9,
    w=2.17e-6,
    T=60e-15,
    lim=(-30,5,-20,20, -20, 20),
    res=(350,400,400),
    tlim=(-27.5,0, -15,15, -15, 15),
    tref= (None,None,None),
    fp=(0,0,0),
    domains=48,
    totaltime=300e-15,
    timestep=1e-16,
    components=(0,1,0),
    phases=(0,0,0),
    dens_dat='watercolumn.dat',
    dens_type= '30',
    dens_imul= 1.0,
    dens_flags= (True, False, False),
    energy_flags= (True, False, False),
    speciesl = ['e', 'O', 'p'],
    discrete=(3,3,3),
    description='Hotwater in 2d',
    pext_species=(10,),
    restart=None,
    lsptemplate='hotwater3d_tmpl.lsp',
    #dump
    dumpinterval=2e-16,
    dumpsteps=(),
    dumptimes=(),
    #if these aren't set, we ignore other options
    dump_field=True,
    dump_scalar=True,
    dump_particle=False,
    #this is bad now...
    funcnum = 10,#a "global" which holds the number count"
    other_funcs = '',
    #conductor
    cond_temp = 1.0,
    cond_fraction = 0.0,
    cond_threshold= 0.0,
    #boundary hacks
    freespace = None,
);

###############
## options
#6.2.2
restart_opts = ('Restarts', dict(
    dump_restart_flag=False,
    maximum_restart_dump_time=None,
    rename_restart_flag=True,
    restart_interval=None,
),)
#6.2.3 balancing, todo
balance_opts = ('Load Balancing', dict(
    balance_interval = 0.0,
    balance_interval_ns = 0.0,
    load_balance_flag=False,
    region_balance_flag=None,
    initial_balance_flag=None,
),)
#6.2.4 Field solution, do not touch.
#...
options_dont_touch = ''';Field Solution and Modification
 time_bias_coefficient 0
 time_bias_iterations 1
;Implicit Field Algorithm
 error_current_filtering_parameter 0.95
 implicit_iterations 10
 implicit_tolerance 1.e-5
;Matrix Solution Algorithm
 preconditioner JACOBI
 linear_solution GMRES
;Fluid Physics Algorithm
 fluid_electron_streaming_factor 0.1
 fluid_ion_streaming_factor 0.01 ;Tony insists this is 0.01 instead of 0.005
 flux_limit_fraction 0.2

'''
#6.2.8 Kinematics Checks
kinematic_opts = ('Kinematics', dict(
    plasma_frequency_limit=2.0,#default in manual
),)
#6.2.9 Collisions, let's try some, or not
#6.2.12 diagnostics
dump_opts = dict(
    accelerations =None,
    charge_density=None,
    collision_energies=None,
    current_density=None,
    montecarlo_diagnostics=None,
    number_densities=True,
    plasma_quantities=True,
    temperatures=None,
    potential=None,
    velocities=None,
    time_zero=None,
);
#no shame.
keys = list(dump_opts.keys());
for k in keys:
    dump_opts["dump_"+k+"_flag"] = dump_opts[k];
    del dump_opts[k];
dump_opts.update(
    spatial_skip_x = 1,
    spatial_skip_y = 1,
    spatial_skip_z = 1,
    probe_interval = 1,
    probe_output_digits=None,
);
    
    
dump_opts = ("Diagnostic Dumps",dump_opts);

bigdumps = ['field','scalar','particle'];

numeric_opts = ('Numeric Checks', dict(
    domain_boundary_check=True,
    plasma_frequency_check=None,
    print_convergence_flag=None,
    print_region_flag=None,
    dump_timing_flag=True,
    report_timing_flag=None,
),);

def genoptions(**kw):
    if test(kw,"options"):
        kw = sd(kw,kw['options']);
    #quirks
    getkw_outer = mk_getkw(kw,lspdefaults,prefer_passed=True);
    kw['maximum_restart_dump_time'] = getkw_outer('restart')
    def genopt(k,getkw=getkw_outer,flag=False):
        if not flag: flag = k;
        i = getkw(k);
        if re.search("_ns$",flag):
            if isvalue(i):
                i*=1e9;
            else:
                mt(i,1e9);
        if i is None or i is ():
            return "";
        elif i is True:
            return "{} ON\n".format(flag);
        elif i is False:
            return "{} OFF\n".format(flag);
        elif isvalue(i):
            return "{} {}\n".format(flag,i);
        else:
            return "{} {} end\n".format(flag,joinspace(i));
    def genopts(opts):
        title,opts = opts;
        getkw = mk_getkw(kw,opts,prefer_passed=True);
        tmpl=";;{}\n{}\n"
        all_opts = "".join([
            genopt(k,getkw) for k in sorted(opts.keys()) ]);
        return tmpl.format(title,all_opts);
    out=''.join([
        genopts(iopts)
        for iopts in [restart_opts, balance_opts,]
    ]);
    out+=options_dont_touch
    out+=''.join([
        genopts(iopts) for iopts in [kinematic_opts,dump_opts,]
    ]);

    #now we do big dumps
    kw['interval_ns'] = getkw_outer("dumpinterval");
    kw['times_ns']    = getkw_outer("dumptimes");
    kw['steps']       = getkw_outer("dumpsteps");
    def gen_dumpopt(dump,opt):
        label = "{}_dump_{}".format(dump,opt);
        if test(kw, label):
            return genopt(label);
        else:
            return genopt(opt,flag=label);
    for dump in bigdumps:
        if not getkw_outer("dump_{}".format(dump)) : continue;
        out += "dump_{}s_flag ON\n".format(dump);
        for iopt in ['interval_ns','times_ns','steps']:
            out += gen_dumpopt(dump,iopt);
    return out;
    

pext_defaults = sd(
    lspdefaults,
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
    planes = list(zip(dirs,lims));
    if kw['zcells'] == 0:
        del planes[4:6];
    if kw['ycells'] == 0:
        del planes[2:4];
    def formatsp(sp,i):
        return [
            dict(i=i+j+1,
                 species=sp,
                 direction=d,
                 start_time=getkw('start_time'),
                 stop_time =getkw('stop_time'),
                 position  =joinspace(lim))
            for j,(d,lim) in enumerate(planes)];
    pextplanes = [
        tmpl.format(**d)
        for i,sp in enumerate(getkw('species'))
        for d in formatsp(sp,len(planes)*i)];
    ret = joinspace(pextplanes);
    if test(kw, 'extrapexts'):
        ppl = len(pextplanes);
        expext_def = dict(
            species=10,
            direction='X',
            start_time=0,
            stop_time=1,
            position=(0.0,0.0,0.0),
        );
        expexts = [];
        for p in getkw('extrapexts'):
            if test(p,'species') and p['species'] != 'all':
                expexts.append(p);
            elif test(p,'species') and type(p['species']) != str:
                expexts += [ sd(p, species = sp) for sp in p['species']];
            else:
                expexts += [ sd(p, species = sp) for sp in getkw('species') ];
        for i,ep in enumerate(expexts):
            pgetkw = mk_getkw(p, expext_def, prefer_passed = True);
            ret+=tmpl.format(
                i=ppl+i+1,
                species   = pgetkw('species'),
                direction = pgetkw('direction'),
                start_time = pgetkw('start_time'),
                stop_time = pgetkw('stop_time'),
                position  = joinspace(pgetkw('position')),);
    return ret;


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
number_of_cells AUTO; {cells}
;
'''
def mkregion_str(regions,split_cells=None):
    def format_region(region):
        if not test(region,"cells"):
            region['cells'] = ""
        else:
            region['cells'] = "cells = {}".format(region['cells'])
        if split_cells is not None and split_cells/region['domains'] < 4:
            print("warning: {} limits less than 4 cells thick".format(
                region['split'][0]));
        return region_tmpl.format(**region);
    
    return ''.join([format_region(region)
                    for region in regions ]);

unireg_defaults = sd(
    lspdefaults,
    region_split=('z',1),
    region_dom_split='x',    
)
def genregions_uniform(subdivs,**kw):
    '''
    genregions in a uniform fashion

    subdivs is a list of tuples, each of which specify a range to divide
    along an axis. There are two options, the first is
       (d, split)
    in which d is a string representing the dimension, and split is
    the number of subdivions along that axis.
    The section option is
       (d, split, dmin, dmax) or (d, split, (dmin, dmax))
    where dmin is the minimum along the d axis and dmax is the max.

    The subdivisions are cartesian multiplied (or cartesian product).
    '''
    getkw = mk_getkw(kw, unireg_defaults);
    lims = mt(getkw('lim'));
    dims = 'xyz';
    out={}
    for subdiv in subdivs:
        if len(subdiv) == 3:
            subdiv = subdiv[:2] + subdiv[2];
        elif len(subdiv) == 2:
            i=dims.index(subdiv[0])
            subdiv = subdiv + tuple(lims[i*2:i*2+2])
        ax, split, mn, mx = subdiv;
        if ax not in out:
            out[ax]=[];
        out[ax].extend(list(
            np.linspace(mn,mx,split+1)));
    for i,dim in enumerate(dims):
        if dim not in out:
            out[dim] =lims[i*2:i*2+2];
    regs = [ dict(xmin=xmin,xmax=xmax,
                  ymin=ymin,ymax=ymax,
                  zmin=zmin,zmax=zmax,)
             for xmin,xmax in zip(out['x'],out['x'][1:])
             for ymin,ymax in zip(out['y'],out['y'][1:])
             for zmin,zmax in zip(out['z'],out['z'][1:]) ];
    for i,reg in enumerate(regs):
        reg['i'] = i+1;
    if test(kw,"domains_per_region"):
        for reg in regs:
            reg['domains'] = getkw("domains_per_region");
    else:
        ndom = getkw("domains")//len(regs);
        ex   = getkw("domains") %len(regs);
        for reg in regs:
            reg['domains'] = ndom;
        regs[-1]['domains'] += ex;
    for reg in regs:
        reg['split'] = "{}SPLIT".format(
            getkw("region_dom_split").upper());
    return regs;

def genregions(**kw):
    if test(kw,'region_split'):
        regs = genregions_uniform([kw['region_split']],**kw);
    elif test(kw, 'region_splits'):
        regs = genregions_uniform(kw['region_splits'],**kw);
    else:
        regs = genregions_uniform([],**kw);
    return mkregion_str(regs);

densdefaults = sd(
    lspdefaults,
    fracs = [1.0, 0.33, 0.67],
);
densityfile_tmpl = '''
type {type}
data_file {targetdat}
independent_variable_multiplier {imul}
dependent_variable_multiplier {dmul}
'''
densitypairs_tmpl = '''
type 0
data_pairs
{data}
end
'''

plainconst_tmpl = '''type 1
coefficients {data} end
'''

tempdefaults = sd(
    lspdefaults,
    thermal_energy = (1.0, 1.0, 1.0),
    target_temps  = (None, None, None));
species_tempdefault = dict(
    dat  = 'temp.dat',
    type = '30',
    imul = 1.0,
    frac = 1.0,
    energy_flags = (True, False, False),
);

def gentemp(**kw):
    getkw = mk_getkw(kw, tempdefaults);
    speciesl = getkw('speciesl');
    otherfuncs = '';
    funcnum = getkw('funcnum');
    if test(kw,'target_temps'):
        Q = kw['target_temps'];
        def process_temp(iq):
            if not iq: return None;
            if hasattr(iq, '__call__'):
                xres = getkw('dat_xres')
                x = np.linspace(kw['txmin'][0],kw['txmax'][1],xres);
                iq = iq(x);
                raise ValueError("Not implemented yet!");
            elif type(iq) is dict:
                _getkw = mk_getkw(iq, species_tempdefault);
                ret = densityfile_tmpl.format(
                    targetdat = _getkw('dat'),
                    type = _getkw('type'),
                    imul = _getkw('imul'),
                    dmul = _getkw('frac'));
            return ret;                
        ss = [ process_temp(iq) for iq in Q ];
    else:
        Q = [dict()]*len(speciesl);
        ss= [None]  *len(speciesl);
    for iq,species,s,e in zip(Q,speciesl,ss,getkw('thermal_energy')):
        cur = 'thermal_energy {}\n'.format(e);
        if s:
            otherfuncs += "function{}\n".format(funcnum);
            otherfuncs += s;
            # if 'energy_flags' in iq:
            #     energyflags = iq['energy_flags'];
            # else:
            #     energyflags = getkw('energy_flags');
            cur += 'spatial_function {}\n'.format(funcnum);
            # cur += 'energy_flags {}\n'.format(
            #     joinspace([
            #         1 if i else 0
            #         for i in getkw("dens_flags")]));
            funcnum += 1;
        kw['{}_thermalopts'.format(species)] = cur;
    if otherfuncs != '':
        if not test(kw, 'other_funcs'):
            kw['other_funcs'] = ''
        kw['other_funcs'] += otherfuncs;
    return kw;

def gendens(**kw):
    getkw = mk_getkw(kw, densdefaults);
    speciesl =  getkw('speciesl');
    outputfmt = "n_{}";
    if test(kw,'target_density'):
        Q = kw['target_density'];
        fracs = getkw('fracs');
        if test(kw, 'target_density_plainconst'):
            ret = {
                outputfmt.format(species) : plainconst_tmpl.format(data=Q*f)
                for species,f in zip(speciesl,fracs) };
            kw.update(ret);
            return kw;
        if type(Q) == tuple:
        #the reason for tuple and not a general iterable
        #is when we pass a single scale, for example, which
        #we scale by fracs
            pass;
        else:
            if hasattr(Q[0], '__call__'):
                Q = [  lambda x: frac*iQf(x)
                       for frac,iQf in zip(fracs,Q) ];
            else:
                Q = [ frac*iQ
                      for frac,iQ in zip(fracs,Q) ];
        if hasattr(Q[0],'__call__'):
            #invariant: txmin,txmax are in cm.
            x = np.linspace(kw['txmin'][0],kw['txmax'][1],20);
            Q[:] = [iQ(x) for iQ in Q];
        ret = {
            outputfmt.format(species) : densitypairs_tmpl.format(data = iQ)
            for species,iQ in zip(speciesl,Q) };
        kw.update(ret)
        return kw;
    else:
        kw['dens_dat'] = getkw('dens_dat');
        kw['dens_imul'] = getkw('dens_imul');
        kw['dens_type'] = getkw('dens_type');
        kw['fracs']     = getkw('fracs');
        def copy_kw(l):
            if type(kw[l]) != tuple:
                kw[l] = (kw[l],)*len(speciesl)
        copy_kw('dens_dat');
        copy_kw('dens_imul');
        copy_kw('dens_type');
        for i,species in enumerate(speciesl):
            kw['n_'+species] = densityfile_tmpl.format(
                targetdat = kw['dens_dat'][i],
                type = kw['dens_type'][i],
                imul = kw['dens_imul'][i],
                dmul = kw['fracs'][i]);
        return kw;
    pass;
outletdefaults = sd(
    lspdefaults,
    lasertfunc=1,
    laserafunc=2,
    laser_time_delay=0.0,);
laserdefaults = sd(
    outletdefaults,
    outlet = 'xmin',
    label = None,
);

all_lims = [
    '{}{}'.format(i,j)
    for i in ['x','y','z']
    for j in ['min', 'max']
];

all_limsft = [
    '{}{}'.format(i,j)
    for i in ['x','y','z']
    for j in ['f', 't']
]

otherside = lambda s: s[:-2] + ('ax' if s[-2:] == 'in' else 'in');
def outlet_coords(iside,d):
    out = {k:d[k] for k in all_lims };
    out[otherside(iside)] = out[iside];
    return out;

frsp_defs = dict(
    num_of_cells = 4,
    model_type = 'WAVEABC',
    freesp_delta = 1e-4,
    freesp_refp = [0.0,0.0,0.0],
    freesp_label='freespace boundaries',
    keep_outlets=[],
);

def genoutlets(**kw):
    outlet_tmpl='''
;{label}
outlet
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
phase_velocity 1.0
drive_model NONE''';
    freespace_tmpl='''
;{label}
freespace
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
model_type {model_type}
{num_of_cells}
phase_velocity 1.0
reference_point {refp}
''';
    laser10_tmpl='''
;laser
outlet
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
phase_velocity 1.0
drive_model LASER
reference_point {fp}
components {components}
phases {phases}
temporal_function {lasertfunc}
analytic_function {laserafunc}
time_delay {time_delay}
'''
    retoutlets = ''
    laserkw =  kw['laseroutlet'] if test(kw, 'laseroutlet') else dict();
    laserkw = sd(kw, **laserkw);
    getkw = mk_getkw(laserkw,outletdefaults,prefer_passed = True);
    lset = set();
    side_label = dict(
        xmin='front',
        xmax='back',
        ymin='left',
        ymax='right',
        zmin='bottom',
        zmax='top');
    ls = [];
    if not test(laserkw, 'multilaser') and not test(laserkw,'nolaser'):
        ls = [ sd(laserkw, outlet='xmin') ];
    elif test(laserkw,'multilaser'):
        ls = kw['multilaser'];
        print("experimental multi-lasers");
        print("if you put more than one laser on a single outlet,");
        print("be sure to be using my modifications to lsp for it.");
        ls = kw['multilaser'];
    #lasers
    for l in ls:
        l = sd(laserkw, **l);
        lgetkw = mk_getkw(l, laserdefaults, prefer_passed = True);
        outlet = lgetkw('outlet');
        if outlet not in all_lims:
            raise ValueError('Unknown outlet "{}"'.format(outlet));
        lset.add(outlet);
        retoutlets += laser10_tmpl.format(
            fp = joinspace(mt(lgetkw("fp"))),
            components = joinspace(lgetkw("components")),
            phases =  joinspace(lgetkw("phases")),
            lasertfunc = lgetkw('lasertfunc'),
            laserafunc = lgetkw('laserafunc'),
            time_delay = lgetkw('laser_time_delay'),
            **outlet_coords(outlet, l)
        );
    just_outlets = [i for i in all_lims if i not in lset];
    if test(kw,'freespace'):
        getkwfr = mk_getkw(
            sd(kw,**kw['freespace']),frsp_defs,prefer_passed=True);
        di=dict();
        di['model_type'] = getkwfr('model_type');
        if di['model_type'] not in ["WAVEABC","UNIAXIAL","CFSPML"]:
            raise ValueError("unrecognized model_type for freespace");
        if di['model_type']=="WAVEABC":
            di['num_of_cells'] = "";
        else:
            di['num_of_cells'] = "number_of_cells {}".format(
                getkwfr('num_of_cells'));
        keeps = getkwfr('keep_outlets');
        if keeps is None: keeps = [];
        just_outlets = [ i for i in just_outlets
                         if i in keeps ];
        if test(kw,'frlim'):
            for dim,lim in zip(kw['frlim'],all_lims):
                di[lim] = dim;
        else:
            dx = getkwfr('freesp_delta');
            keepset = lset.union(just_outlets);
            for lim in all_lims:
                di[lim] = getkw(lim);
                if lim in keepset:
                    if 'min' in lim:
                        di[lim] -= dx;
                    else:
                        di[lim] += dx;
        di['refp'] = joinspace(getkwfr('freesp_refp'));
        di['label']= getkwfr('freesp_label');
        retoutlets += freespace_tmpl.format(**di);
    #outlet boundaries which and are not removed by freespace
    for side in just_outlets:
        if laserkw[side[0]+'cells'] > 0:
            retoutlets += outlet_tmpl.format(
                label = side_label[side],
                **outlet_coords(side, laserkw));
    return retoutlets;

condb_objdef=sd(
    lspdefaults,
    width=10.0,
    potential=0, #should usually be zero
    medium=0,    #and this too.
    outlet=None,
    type="BLOCK",
    start=0,
    sweep_direction='Z',
);
condb_defaults = sd(
    lspdefaults,
    conductors=[]);
condb_tmpl='''
object{i} {type}
conductor on medium {medium} potential {potential}
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
'''
condf_tmpl='''
object{i} {type}
conductor on medium {medium} potential {potential}
from {xf:e} {yf:e} {zf:e}
'''
#shape of cd['to'] should either be list of tuples or tuple
#each tuple is a triple of coordinates.
condt_tmpl="to   {xt:e} {yt:e} {zt:e}\n"

def genconductors(**kw):
    getkw=mk_getkw(kw, condb_defaults);
    conductorss='';
    for I,conductor in enumerate(getkw('conductors')):
        cd = sd(condb_objdef, **conductor);
        coords=dict();
        if test(cd,'outlet'):
            outlet = cd['outlet'];
            if outlet not in all_lims:
                raise ValueError('Unknown outlet "{}"'.format(outlet));
            coords = outlet_coords(outlet,kw);
            cd['width']*=1e-4;
            cd['start']*=1e-4;
            if outlet[-2:] == 'ax':
                sign = 1.0;
            else:
                sign =-1.0
            cd['type']= 'BLOCK';
            coords[outlet] += sign*(cd['width'] + cd['start']);
            coords[otherside(outlet)] += sign*cd['start'];
            cd['from'] = (coords['xmin'],coords['ymin'],coords['zmin']);
            cd['to']   = (coords['xmax'],coords['ymax'],coords['zmax']);
        conductorss += condf_tmpl.format(
            i=I+1,
            xf=cd['from'][0],yf=cd['from'][1],zf=cd['from'][2],
            **cd);
        def mk_to(cd):
            '''generate the to's'''
            return ''.join([
                condt_tmpl.format(xt=xt,yt=yt,zt=zt)
                for xt,yt,zt in cd['to'] ]);
        
        if cd['type'] == 'BLOCK':
            if type(cd['to']) == list: cd['to'] = cd['to'][0]
            conductorss += condt_tmpl.format(
                xt=cd['to'][0],yt=cd['to'][1],zt=cd['to'][2]);
        elif cd['type'] == 'PARALLELPIPED':
            conductorss += mk_to(cd);
        elif cd['type'] == 'TRILATERAL':
            conductorss += mk_to(cd);
            conductorss += 'sweep_direction {sweep_direction}\n'.format(
                **cd);
        else:
            raise ValueError(
                "Unknown conductor type '{}'".format(cd['type']));
    return conductorss;
    
def genlsp(**kw):
    def getkw(l,scale=None):
        if test(kw, l):
            ret = kw[l]
        else:
            ret = lspdefaults[l];
        if scale:
            return [scale*i for i in ret];
        return ret;
    def mkdims(s=''):
        return [s+'x',s+'y',s+'z']
    fmtd = {};

    fmtd['options'] = genoptions(**kw);
    fmtd['E0'] = np.sqrt(2*getkw('I')*1e4/(c*e0))*1e-5
    xmin,xmax, ymin,ymax, zmin,zmax = getkw('lim',scale=1e-4)
    kw['xmin'],kw['xmax']=xmin,xmax
    kw['ymin'],kw['ymax']=ymin,ymax
    kw['zmin'],kw['zmax']=zmin,zmax
    txmin,txmax,tymin,tymax,tzmin,tzmax=getkw('tlim',scale=1e-4);
    kw['txmin'],kw['txmax']=txmin,txmax
    kw['tymin'],kw['tymax']=tymin,tymax
    kw['tzmin'],kw['tzmax']=tzmin,tzmax 

    l=fmtd['l'] = getkw('l')*100.0
    if test(kw,'resd'):
        xres,yres,zres = getkw("resd");
        kw['xcells'] = (xmax-xmin)/(l/xres) if xres > 0 else 0;
        kw['ycells'] = (ymax-ymin)/(l/yres) if yres > 0 else 0;
        kw['zcells'] = (zmax-zmin)/(l/zres) if zres > 0 else 0;
    else:
        kw['xcells'], kw['ycells'], kw['zcells'] = getkw("res");
    xcells, ycells, zcells = kw['xcells'], kw['ycells'], kw['zcells'];
    #generating outlets
    other_outlets=genoutlets(**kw);
    conductors=genconductors(**kw);
    #dealing with conductors
    fmtd['cond_temp'] = getkw('cond_temp');
    fmtd['cond_fraction'] = getkw('cond_fraction');
    fmtd['cond_threshold']= getkw('cond_threshold');
    #others
    w0=fmtd['w0'] = getkw('w')*100.0;
    fmtd['pulse']  = getkw('T')*1e9;
    #generating grid
    ygrid=zgrid='';
    if ycells > 0:
        ygrid=''';
ymin             {ymin:e}
ymax             {ymax:e}
y-cells          {ycells}'''.format(ymin=ymin,ymax=ymax,ycells=ycells);
    if zcells > 0:
        zgrid=''';
zmin             {zmin:e}
zmax             {zmax:e}
z-cells          {zcells}'''.format(zmin=zmin,zmax=zmax,zcells=zcells);
    fmtd['domains']=getkw('domains');
    # we have that na~l/(pi*w), and the f-number~1/2na, thus
    # f-number ~ pi*w/2l
    fmtd['fnum']=np.pi*w0/2/l;
    fmtd['totaltime']=getkw('totaltime')*1e9
    fmtd['timestep']=getkw('timestep')*1e9;
    # calculate courant
    couraunt = min(
        ((xmax-xmin)/xcells/c_cgs)*1e9 if xcells > 0 else float('inf'),
        ((ymax-ymin)/ycells/c_cgs)*1e9 if ycells > 0 else float('inf'),
        ((zmax-zmin)/zcells/c_cgs)*1e9 if zcells > 0 else float('inf'),)
    if fmtd['timestep'] > couraunt:
        print("warning: timestep exceeds couraunt limit\n");
    #target
    kw = gendens(**kw);
    kw = gentemp(**kw);
    for species in getkw('speciesl'):
        l = 'n_'+species;        
        fmtd[l] = kw[l];
        l = '{}_thermalopts'.format(species);
        fmtd[l] = kw[l];
    fmtd['discrete']  = joinspace(getkw("discrete"));
    fmtd['dens_flags']= joinspace([
        1 if i else 0 for i in getkw("dens_flags")]);
    for idim,v in zip(mkdims(),getkw('tref')):
        if v is None: v = kw['t'+idim+'min'];
        fmtd['targref'+idim] = v;
    fmtd['dumpinterval']=getkw('dumpinterval')*1e9;
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
'''.format(dumpinterval=fmtd['dumpinterval']);
    else:
        pmovies = '';
    fmtd['other_funcs'] = getkw('other_funcs');
    lsptemplate=getkw("lsptemplate");
    with open(lsptemplate) as f:
        s=f.read();
    s=s.format(
        xmin=xmin,xmax=xmax,
        ymin=ymin,ymax=ymax,
        zmin=zmin,zmax=zmax,
        xcells=xcells,ycells=ycells,zcells=zcells,
        ygrid=ygrid,
        zgrid=zgrid,
        other_outlets=other_outlets,
        objects=conductors,
        targ_xmin=txmin, targ_xmax=txmax,
        targ_ymin=tymin, targ_ymax=tymax,
        targ_zmin=tzmin, targ_zmax=tzmax,
        intensity=getkw('I'),
        pmovies=pmovies,
        regions=regions,
        pexts=pexts,
        description=description,
        **fmtd
    );
    return s;
if __name__ == "__main__":
    print("!!!!!! This probably no longer works! Use at your own risk!");
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

