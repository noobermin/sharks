import sys;
import re;
import numpy as np;
from pys import test,parse_numtuple,sd,take,mk_getkw;
from collections import OrderedDict;
def joinspace(l): return " ".join([str(i) for i in l]);
mt  = lambda t,m=1e-4: tuple([i*m for i in t]);
scaletuple=mt;
import types;
def isvalue(v):
    a = isinstance(v, str);
    b = isinstance(v, float);
    c = isinstance(v, int);
    return a or b or c;
def coordtokeys(cd, coords, keyfmt):
    for xi, dim in zip(coords,'xyz'):
        cd[keyfmt.format(dim)] = xi;
def coordtokeysl(cd, l, keyfmt):
    coordtokeys(cd, cd[l], keyfmt);


c  = 299792458
c_cgs=c*100;
e0 = 8.8541878176e-12

lspdefaults = dict(
    ux=1e-4,
    I=3e18,
    l=780e-9,
    w=2.17e-6,
    T=60e-15,
    lim=(-30,5,-20,20, -20, 20),
    res=(350,400,400),
    tlim=(-27.5,0, -15,15, -15, 15),
    tref= (None,None,None),
    gammabeta = (0.0,0.0,0.0),
    gb_flags=(False,False,False),
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
    #newlaser
    laser_t0=0,
    lpmode=(0,0),
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
    balance_interval = 0,
    balance_interval_ns = 0.0,
    load_balance_flag=False,
    region_balance_flag=None,
    initial_balance_flag=None,
),)
#6.2.4 Field solution, do not touch.
#...
fieldmod_opts = ('Field Solution and Modification', dict(
    time_bias_coefficient=0.0,
    time_bias_iterations=1,),);

implicitfield_opts = ("Implicit Field Algorithm (mostly don't touch, for use in high density plasma)",dict(
    error_current_filtering_parameter=0.95,
    implicit_iterations=10,
    implicit_tolerance=1e-5),);
#6.2.6 Matrix Solution, mostly don't touch.
matrixsoln_opts = ("Matrix Solution Algorithm (mostly don't touch, \
for use in multi-domain decks)", dict(
    preconditioner='JACOBI',
    linear_solution='GMRES'),
)
#6.2.8 Kinematics Checks
kinematic_opts = ('Kinematics', dict(
    plasma_frequency_limit=2.0,#default in manual
),)
#6.2.9 Collisions
collisions_opts = ('Collision Algorithm', dict(
    binary_collision_species_flag=None,
    ion_stimulation_factor=1.0,
    electron_stimulation_factor=0.5,
    ionization_interval=1,
    scattering_interval=1,
    flux_limit_fraction=None,#0.2
),)

#6.2.9 Fluid Physics 
fluid_opts = ('Fluid Physics Algorithm', dict(
    fluid_streaming_factor=0.1,
    fluid_ion_streaming_factor=0.01,
    fluid_electron_streaming_factor=0.1,
    eulerian_maximum_temperature=1e4,),);

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
    allopts=[
        restart_opts,balance_opts,fieldmod_opts,
        implicitfield_opts, matrixsoln_opts, kinematic_opts,
        collisions_opts, fluid_opts, dump_opts];
    out=''.join([
        genopts(iopts)
        for iopts in allopts]);

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
    lims = list(getkw('lim',scale=getkw('ux')));
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
    lims = mt(getkw('lim'),getkw('ux'));
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
        def process_temp(ifunc):
            if not ifunc: return None;
            if hasattr(ifunc, '__call__'):
                xres = getkw('dat_xres')
                x = np.linspace(kw['txmin'][0],kw['txmax'][1],xres);
                ifunc = ifunc(x);
                raise ValueError("Not implemented yet!");
            elif type(ifunc) is dict:
                _getkw = mk_getkw(ifunc, species_tempdefault);
                ret = densityfile_tmpl.format(
                    targetdat = _getkw('dat'),
                    type = _getkw('type'),
                    imul = _getkw('imul'),
                    dmul = _getkw('frac'));
            return ret;
        def process_target_temparg(iq):
            if iq is None:
                return (None,None);
            elif (type(iq) == list or type(iq) == tuple) and len(iq) == 1:
                return process_temp(iq),None;
            else:
                return process_temp(iq[0]),process_temp(iq[1]);
        rs,ss = zip(*[ process_target_temparg(iq) for iq in Q ]);
    else:
        Q = [dict()]*len(speciesl);
        ss= [None]  *len(speciesl);
        rs= [None]  *len(speciesl);
    for iq,species,r,s,e in zip(Q,speciesl,rs,ss,getkw('thermal_energy')):
        cur = 'thermal_energy {}\n'.format(e);
        if r:
            otherfuncs += "function{}\n".format(funcnum);
            otherfuncs += s;
            # if 'energy_flags' in iq:
            #     energyflags = iq['energy_flags'];
            # else:
            #     energyflags = getkw('energy_flags');
            cur += 'random_energy_function {}\n'.format(funcnum);
            # cur += 'energy_flags {}\n'.format(
            #     joinspace([
            #         1 if i else 0
            #         for i in getkw("dens_flags")]));
            funcnum += 1;
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

grid_defs = dict(
    
);
def gengrids(**kw):
    getkw = mk_getkw(kw,grid_defs,prefer_passed = True);
    outgrids = ['','',''];
    simple_gridtmpl = '''
{dim}min             {min:e}
{dim}max             {max:e}
{dim}-cells          {cells}''';
    vargrid_tmpl = '''
{dim}min             {min:e}
{dim}max             {max:e}
{dim}-cells          {cells}
{dim}-intervals
 d{dim}-start {dxstart:e}
{intervals}
end'''
    vargrid_intv_tmpl = " length {length:e} for {N}";
    grids = []
    for dim in 'xyz':
        if getkw('{}cells'.format(dim)) == 0:
            grids.append("");
            continue;
        vgridlabel = '{}vargrid'.format(dim);
        if test(kw,vgridlabel):
            intv = '\n'.join([
                vargrid_intv_tmpl.format(length=l, N=N)
                for l,N in getkw(vgridlabel)]);
            if test(kw, 'd{}start'.format(dim)):
                ddimstart = getkw('d{}start'.format(dim));
            else:
                l = getkw(vgridlabel)[0][0];
                N = getkw(vgridlabel)[0][1];
                ddimstart = l/N;
            grid = vargrid_tmpl.format(
                dim=dim,
                min=getkw('{}min'.format(dim)),
                max=getkw('{}max'.format(dim)),
                cells=getkw('{}cells'.format(dim)),
                dxstart=ddimstart,
                intervals=intv)
        else:                    
            grid= simple_gridtmpl.format(
                dim=dim,
                min=getkw('{}min'.format(dim)),
                max=getkw('{}max'.format(dim)),
                cells=getkw('{}cells'.format(dim)));
        grids.append(grid);
    return grids;

outletdefaults = sd(
    lspdefaults,
    phase_velocity=1.0,
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
outlet_none_tmpl='''
;{label}
outlet
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
phase_velocity {phase_velocity}
drive_model NONE
''';
outlet_pot_tmpl='''
;{label}
outlet
from {xmin:e} {ymin:e} {zmin:e}
to   {xmax:e} {ymax:e} {zmax:e}
phase_velocity {phase_velocity}
drive_model POTENTIAL
potentials
 1 -1.0
 2  0.0
end
circuit {circuit}
{connection_rank}
{voltage_measurement}
temporal_function {vtfunc}
time_delay {time_delay}
''';
freespace_tmpl='''
;{label}
freespace
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
model_type {model_type}
{num_of_cells}
phase_velocity {phase_velocity}
reference_point {refp}
''';
laser10_tmpl='''
;laser
outlet
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
phase_velocity {phase_velocity}
drive_model LASER
reference_point {fp}
components {components}
phases {phases}
temporal_function {lasertfunc}
analytic_function {laserafunc}
time_delay {time_delay}
'''

manbounds_defs=sd(
    outletdefaults,
    type='none',
    circuit=0,
    vtfunc=1,
    time_delay=0.0,
);
    
def manual_genboundary(bspec,**kw):
    kwp = sd(kw,**bspec);
    getkw = mk_getkw(kwp,outletdefaults,prefer_passed = True);
    btype = getkw("type");
    lims  = getkw('lim');
    di = dict();
    for dim,lim in zip(all_lims,lims):
        di[dim] = lim;
    if btype == 'outlet':
        model = getkw('model');
        di['label']= getkw('label');
        di['phase_velocity'] = getkw('phase_velocity');
        if model == 'none':
            ret = outlet_none_tmpl.format(**di);
        elif model == 'potential':
            di = sd(manbounds_defs,**di);
            if not test(di,'connection_rank'):
                di['connection_rank'] ='';
            else:
                di['connection_rank'] = 'connection_rank {}'.format(
                    getkw('connection_rank'));
            if not test(kwp,'voltage_measurement'):
                di['voltage_measurement'] = '';
            else:
                raise NotImplementedError("haven't got to this yet...");
            di['circuit'] = di['circuit'];
            ret = outlet_pot_tmpl.format(**di);
        elif model == 'laser':
            raise NotImplementedError("need to implement the laser...");
        else:
            raise ValueError("unknown outlet model {}".format(model));
    else:
        raise NotImplementedError("yeah...");
    return ret;
        

def genboundaries(**kw):
    retboundaries = ''
    if test(kw,'manual_boundaries'):
        return '\n'.join([
            manual_genboundary(bspec,**kw)
            for bspec in kw['manual_boundaries'] ]);
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
    if not test(laserkw, 'multilaser') and not (test(laserkw,'nolaser') or test(laserkw,'nolaser_outlet')):
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
        retboundaries += laser10_tmpl.format(
            fp = joinspace(mt(lgetkw("fp"),getkw('ux'))),
            components = joinspace(lgetkw("components")),
            phase_velocity = lgetkw('phase_velocity'),
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
        if test(kw['freespace'],'frlim'):
            for dim,lim in zip(getkwfr('frlim'),all_lims):
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
        retboundaries += freespace_tmpl.format(**di);
    #outlet boundaries which and are not removed by freespace
    for side in just_outlets:
        if laserkw[side[0]+'cells'] > 0:
            retboundaries += outlet_none_tmpl.format(
                label = side_label[side],
                phase_velocity=getkw('phase_velocity'),
                **outlet_coords(side, laserkw));
    pwbtmpl='''
planewave
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
reference_point {refp}
polar_angle {polar}          
azimuthal_angle  {azimuth}
rotation_angle {rotation}
frequency {freq}
temporal_function {pwfunc}
'''
    pwbdefs = dict(
        polar=90,
        azimuth=45,
        rotation=-45,
        freq=1e3,
        pwfunc=3,
        pw_refp=[0.0,0.0,0.0],
    )
    if test(kw, 'planewave_boundary'):
        di=dict();
        pwkw = sd(kw,**kw['planewave_boundary']);
        getkwpw = mk_getkw(
            pwkw,pwbdefs,prefer_passed=True);
        if not test(pwkw, 'pwblim'):
            raise ValueError("This requires pwblim for now");
        pwlims = getkwpw('pwblim');
        for dim,lim in zip(pwlims,all_lims):
            di[lim] = dim;
        for qi in ['polar','azimuth','rotation','freq','pwfunc']:
            di[qi] = getkwpw(qi);
        di['refp'] = joinspace(getkwpw('pw_refp'));
        retboundaries+=pwbtmpl.format(**di);
    return retboundaries;

condb_objdef=sd(
    lspdefaults,
    width=10.0,
    potential=0, #should usually be zero
    medium=0,    #and this too.
    outlet=None,
    type="BLOCK",
    condon='on',
    start=0,
    sweep_direction='Z',
    label='',
    crossstart=-0.1,
);
condb_defaults = sd(
    lspdefaults,
    objects=[]);
objdef = sd(
    condb_objdef,
    height=10e-4,
    radius=5e-4,
    base=(0.,0.,0.),
);
condb_tmpl='''
object{i} {type} ;{label}
conductor {condon} medium {medium} potential {potential}
from {xmin:e}  {ymin:e} {zmin:e}
to   {xmax:e}  {ymax:e} {zmax:e}
'''
condf_tmpl='''
object{i} {type} ;{label}
conductor {condon} medium {medium} potential {potential}
from {xf:e} {yf:e} {zf:e}
'''
#shape of cd['to'] should either be list of tuples or tuple
#each tuple is a triple of coordinates.
condt_tmpl="to   {xt:e} {yt:e} {zt:e}\n"

obj_solid_tmpl = '''
object{i} SOLID ;{label}
conductor {condon} medium {medium} potential {potential}
'''
obj_cone_defs = sd(
    objdef,
    apex = (0,0,0),
    edge = (0,0,0),
);

obj_cone_tmpl='''
object{i} CONE ;{label}
conductor {condon} medium {medium} potential {potential}
base {xb:e} {yb:e} {zb:e}
apex {xap:e} {yap:e} {zap:e}
edge {xed:e} {yed:e} {zed:e}
'''
obj_cyl_defs = sd(
    objdef,
    axis_pitch=('Z', 0),
    azimuthal_axis_pitch=('X',0),
    azimuth_range = (0, 360),
)
obj_cyl_tmpl='''
object{i} CYLINDER ;{label}
conductor {condon} medium {medium} potential {potential}
base {xb:e} {yb:e} {zb:e}
polar_angle {axis} {pitch:e}
azimuthal_angle {azaxis} {azpitch:e}
height {height:e}
radius {radius:e}
start_angle {start_angle} sweep_angle {sweep_angle}
'''

obj_torus_defs = sd(
    obj_cyl_defs,
    major_radius=2,
    minor_radius=0.7,
    center=(0.,0.,0.,),
)
obj_torus_tmpl='''
object{i} TORUS ;{label}
conductor {condon} medium {medium} potential {potential}
center {xc:e} {yc:e} {zc:e}
polar_angle {axis} {pitch:e}
azimuthal_angle {azaxis} {azpitch:e}
major_radius {major_radius:e}
minor_radius {minor_radius:e}
start_angle {start_angle} sweep_angle {sweep_angle}
'''


def genobjects(**kw):
    getkw=mk_getkw(kw, condb_defaults);
    ux = getkw('ux');
    objss='';
    for I,objspec in enumerate(getkw('objects')):
        coords=dict();
        #objd = sd(condb_defaults, **kw);
        objd = sd(condb_objdef, **kw);
        objd = sd(objd, **objspec);
        objd['i'] = I + 1;
        if test(objspec,'outlet'):
            outlet = objd['outlet'];
            if outlet not in all_lims:
                raise ValueError('Unknown outlet "{}"'.format(outlet));
            coords = outlet_coords(outlet,kw);
            objd['width']*=ux;
            objd['start']*=ux;
            if outlet[-2:] == 'ax':
                sign = 1.0;
            else:
                sign =-1.0
            objd['type']= 'BLOCK';
            coords[outlet] += sign*(objd['width'] + objd['start']);
            coords[otherside(outlet)] += sign*objd['start'];
            objd['crossstart']*=ux;
            otherdims = [i for i in 'xyz' if i != outlet[:-3]];
            for dim in otherdims:
                if getkw('{}cells'.format(dim)) > 0:
                    coords['{}min'.format(dim)] += objd['crossstart'];
                    coords['{}max'.format(dim)] -= objd['crossstart'];
            objd['from'] = (coords['xmin'],coords['ymin'],coords['zmin']);
            objd['to']   = (coords['xmax'],coords['ymax'],coords['zmax']);
            #objss += condf_tmpl.format(
            #    i=I+1,
            #    condon=objd['condon'],
            #    xf=objd['from'][0],yf=objd['from'][1],zf=objd['from'][2],
            #    **objd);
        def mk_to(objd):
            '''generate the to's'''
            return ''.join([
                condt_tmpl.format(xt=xt,yt=yt,zt=zt)
                for xt,yt,zt in objd['to'] ]);
        frms = ['BLOCK', 'PARALLELPIPED', 'TRILATERAL'];
        if objd['type'] == 'SOLID':
            objss += obj_solid_tmpl.format(**objd);
        elif objd['type'] in frms:
            objss += condf_tmpl.format(
                xf=objd['from'][0],yf=objd['from'][1],zf=objd['from'][2],
                **objd);
            objd = sd(condb_objdef, **objd);
            if objd['type'] == 'BLOCK':
                if type(objd['to']) != list:
                    objd['to'] = [objd['to']];
            objss += mk_to(objd);
            if objd['type'] == 'TRILATERAL':
                objss += 'sweep_direction {sweep_direction}\n'.format(
                    **objd);
        elif objd['type'] == 'CONE':
            objd = sd(obj_cone_defs, **objd);
            coordtokeysl(objd, 'base', '{}b');
            coordtokeysl(objd, 'apex', '{}ap');
            coordtokeysl(objd, 'edge', '{}ed');
            objss += obj_cone_tmpl.format(**objd);
        elif objd['type'] == 'CYLINDER' or objd['type'] == 'TORUS':
            objd = sd(obj_cyl_defs, **objd);
            objd['axis'],objd['pitch'] = objd['axis_pitch'];
            objd['azaxis'],objd['azpitch'] = objd['azimuthal_axis_pitch'];
            objd['start_angle'],objd['sweep_angle'] = objd['azimuth_range'];
            if objd['type'] == 'CYLINDER':
                coordtokeysl(objd, 'base', '{}b');
                objss += obj_cyl_tmpl.format(**objd);
            elif objd['type'] == 'TORUS':
                objd = sd(obj_torus_defs,**objd);
                coordtokeysl(objd, 'center', '{}c');
                objss += obj_torus_tmpl.format(**objd);
            else:
                raise Exception("WTFdiosjf03y2q8qencdq");
        else:
            raise ValueError(
                "Unknown object type '{}'".format(objd['type']));
    pass #end for
    return objss;
    
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
        return [s+'x',s+'y',s+'z'];
    ux = getkw('ux');
    fmtd = {};
    fmtd['options'] = genoptions(**kw);
    fmtd['E0'] = np.sqrt(2*getkw('I')*1e4/(c*e0))*1e-5
    spatial_lims = getkw('lim',scale=ux);
    for dim,ilim in zip(all_lims,spatial_lims):
        kw[dim]  = fmtd[dim] = ilim;
        
    if not test(kw,'tlim'):
        target_lims=spatial_lims
    else:
        target_lims=getkw('tlim',scale=ux);
    for dim,ilim in zip(all_lims,target_lims):
        kw['t'+dim] = fmtd['t'+dim] = target_lims;
        kw['targ_'+dim] = fmtd['targ_'+dim] = target_lims;
    #SI
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
    fmtd['other_boundaries']=genboundaries(**kw);
    fmtd['objects']=genobjects(**kw);
    #dealing with conductors
    fmtd['cond_temp'] = getkw('cond_temp');
    fmtd['cond_fraction'] = getkw('cond_fraction');
    fmtd['cond_threshold']= getkw('cond_threshold');
    #others
    w0=fmtd['w0'] = getkw('w')*100.0;
    fmtd['pulse']  = getkw('T')*1e9;
    #generating grid
    xgrid,ygrid,zgrid=gengrids(**kw);
    fmtd['domains']=getkw('domains');
    # we have that na~l/(pi*w), and the f-number~1/2na, thus
    # f-number ~ pi*w/2l
    fmtd['fnum']=np.pi*w0/2/l;
    fmtd['totaltime']=getkw('totaltime')*1e9
    fmtd['timestep']=getkw('timestep')*1e9;
    # calculate courant
    if test(kw, 'xvargrid') or test(kw, 'yvargrid') or test(kw, 'zvargrid'):
        print("warning: check couraunt condition of vargrids");
    else:
        def f_(v,*arg):
            return kw[v.format(*arg)];
        #f_ = format
        dim_couraunts = [
            ( f_('{}max',dim) - f_('{}min',dim) ) / f_('{}cells',dim) / c_cgs * 1e9 if f_('{}cells',dim) > 0 else float('inf')
            for dim in 'xyz'];
        couraunt = min(*dim_couraunts);
        if fmtd['timestep'] > couraunt:
            print("warning: timestep exceeds couraunt limit\n");
    #target
    kw = gendens(**kw);
    kw = gentemp(**kw);
    fmtd['discrete']  = joinspace(getkw("discrete"));
    fmtd['dens_flags']= joinspace([
        1 if i else 0 for i in getkw("dens_flags")]);
    fmtd['gb_flags']= joinspace([
        1 if i else 0 for i in getkw("gb_flags")]);
    for dim,v in zip('xyz',getkw('tref')):
        if v is None: v = kw['t'+dim+'min'];
        fmtd['targref'+dim] = v;
    fmtd['targref'] = joinspace(mt([
        fmtd['targref'+dim] for dim in 'xyz'],getkw('ux')));
    fmtd['gammabeta'] = joinspace(getkw('gammabeta'));
    for species in getkw('speciesl'):
        def setspeciesv(fmt,defaultl,join=False,scale=False):
            l = fmt.format(species);
            if test(kw,l):
                v = kw[l];
                if scale: v=mt(v,getkw('ux'));
                if join:  v=joinspace(v);
            else:
                v = fmtd[defaultl];
            fmtd[l] = v;
        l = 'n_'+species;
        fmtd[l] = kw[l];
        l = '{}_thermalopts'.format(species);
        fmtd[l] = kw[l];
        setspeciesv('{}_discrete','discrete');
        setspeciesv('{}_targref','targref');
        setspeciesv('{}_gb','gammabeta',join=True);
        if test(kw, '{}_tlims'.format(species)):
            splim = getkw('{}_tlim'.format(species),scale=ux);
        else:
            splim = getkw('tlim',scale=ux);
        for dim,i in zip(all_lims,splim):
            fmtd['{}_{}'.format(species,dim)] = i;
    pass
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
    if test(kw,"newlaser"):
        fmtd['laser_polarization'] = joinspace(kw['laser_polarization']);
        fmtd['laser_direction'] = joinspace(kw['laser_direction']);
        fmtd['t0'] = getkw("laser_t0")*1e9;
        fmtd['fp'] = joinspace(mt(getkw("fp"),getkw('ux')));
        fmtd['lpmode'] = joinspace(getkw("lpmode"));
    lsptemplate=getkw("lsptemplate");
    with open(lsptemplate) as f:
        s=f.read();
    s=s.format(
        xgrid=xgrid,
        ygrid=ygrid,
        zgrid=zgrid,
        intensity=getkw('I'),
        pmovies=pmovies,
        regions=regions,
        pexts=pexts,
        description=description,
        **fmtd
    );
    return s;


