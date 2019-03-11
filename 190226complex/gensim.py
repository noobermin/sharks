#!/usr/bin/env python
from genlsp import genlsp,lspdefaults,scaletuple;
from genpbs import genpbs,gen_mov,pbsdefaults,mov_defaults,mk_hpcmp_pbses;
from gendat import gendats,gendat,genonescale,datdefaults,mkdecay, mktwoscales;
import re;
import os,stat;
from pys import sd,test,mk_getkw,take,takef
import shutil as sh;
import numpy as np;

c=299792458
e=1.602176208e-19
e0  = 8.8541878176e-12
m_e=9.10938356e-31
r_e = e**2/m_e/c**2/(4*np.pi*e0)
def_cycles=80e-15/(780e-9/c);
nc = lambda l,gm=1,m=m_e,q=e: e0*m*(2*np.pi*c/l)**2/q**2/gm*1e-6

def mkdir(dir):
    os.makedirs(dir, exist_ok=True);

def output(dir='.',files=["sine700points.dat","watercolumn.dat","autozipper"]):
    if dir:
        mkdir(dir);
    else:
        dir='.';
    for file in files:
        if type(file) == str:
            if dir != '.': sh.copy(file,dir);
        else:
            fname=dir+'/'+file[0]
            outstr=file[1];
            with open(fname,'wb') as f:
                if type(outstr) == str:
                    outstr=outstr.encode('ascii');
                f.write(outstr);
            if len(file)>2:
                os.chmod(fname, file[2]);
    pass;
defaults = sd(datdefaults,**pbsdefaults);
defaults = sd(defaults,**lspdefaults);
defaults.update(dict(
    pbsbase="hotwater3d",
    subdivs=[],
    autozipper=None,
    movne=None,
    movni=None,
    movdq=None,
    movrho=None,
    movB=None,
    movE=None,
    movS=None,
    angular=None,
    pbses=None,
    dir=None,
    ux=1e-4,
));

def get_roundfpx(d):
    dx = -np.log(nc(d['l'])/d['n_s'])*d['expf'];
    return d['tlim'][1]-d['solid_len']-dx;

def gensim(**kw):
    getkw =  mk_getkw(kw,defaults);
    ux = getkw('ux');
    pbsbase=getkw("pbsbase");
    files = ["sine700points.dat"];
    if test(kw, "autozipper"):
        files.append('zipper');
    files.append('loopscript');
    #
    # target creation
    #
    if test(kw,'singlescale'):
        if type(getkw('fp')) != tuple:
            fpx = get_roundfpx(kw);
            if getkw('fp') != 'nc':
                fpx += getkw('fp');
            kw['fp'] = (fpx,0.0,0.0);
        expf,n_s,n_min,slen=getkw('expf','n_s','n_min','solid_len');
        tlim = getkw('tlim')
        kw['xlen'] = tlim[1]-tlim[0];
        if test(kw,'dens_dat') and kw['dens_dat'] is not None:
            kw['dens_dat'] = "{:0.2f}um.dat".format(getkw('expf'));
            files.append((kw['dens_dat'], dens));
        else:
            kw['target_density'] = mkdecay(n_s, [0.0, slen], kw['tlim'][:2], expf);
        dens = genonescale(**kw);
        kw['dens_dat'] = "{}um.dat".format(getkw('expf'));
        files.append((kw['dens_dat'], dens));
    elif test(kw, 'scale_with_min'):
        #this involves a single scale where we
        #pick the min. We figure out the longitudinal
        #dimensions ourselves
        if not test(kw,'long_res') and not test(kw,'long_resd'):
            raise ValueError(
                "you must supply a longitudinal resolution for scale_with_min");
        long_margin = getkw('long_margin');
        expf,n_s,n_min,slen=getkw('expf','n_s','n_min','solid_len');
        expf*=ux;
        slen*=ux;
        pp_len = expf*np.log(n_s/n_min);
        if test(kw,'roundup_pp'):
            pp_len = np.ceil(pp_len);
        elif test(kw,'roundup_ten_pp'):
            pp_len = np.ceil(pp_len/10) * 10;
        if type(getkw('fp')) != tuple:
            fpx = get_roundfpx(kw);
            if getkw('fp') != 'nc':
                fpx += getkw('fp');
            kw['fp'] = (fpx,0.0,0.0);
        kw['lim'] = list(getkw('lim'));
        kw['tlim'] = list(getkw('tlim'));
        kw['res']  = list(getkw('res'));
        kw['tlim'][0] = -pp_len;
        kw['tlim'][1] = slen;
        kw['lim'][0] = kw['tlim'][0] - long_margin[0];
        kw['lim'][1] = kw['tlim'][1] + long_margin[1];
        xlen = kw['lim'][1] - kw['lim'][0];
        if test(kw, 'long_res'):
            kw['res'][0]  = int(np.round(xlen * kw['long_res']));
        elif test(kw, 'long_resd'):
            kw['res'][0]  = int(np.round(xlen / (getkw('l')*1e6 / kw['long_resd'])));
        kw['timestep'] = getkw('timestep');
        #if xlen*1e-6/kw['res'][0] < c*kw['timestep']:
        #    print("adapting timestep...");
        #    kw['timestep'] = xlen*1e-6/kw['res'][0];
        #dens = genonescale(xlen=kw['tlim'][1]-kw['tlim'][0], **kw);
        if test(kw,'dens_dat') and kw['dens_dat'] is not None:
            kw['dens_dat'] = "{:0.2f}um.dat".format(getkw('expf'));
            files.append((kw['dens_dat'], dens));
        else:
            kw['target_density'] = mkdecay(n_s, [0.0, slen], kw['tlim'][:2], expf);
        print("from scale_with_min, generated dimensions:");
        print(take(kw,['expf','res','tlim','lim','timestep']))
    elif test(kw, 'two_scales'):
        #this involves a single scale where we
        #pick the min. We figure out the longitudinal
        #dimensions ourselves
        if not test(kw,'long_res') and not test(kw,'long_resd'):
            raise ValueError(
                "you must supply a longitudinal resolution for scale_with_min");
        long_margin = getkw('long_margin');
        Lf,Lb,n_s,n_bmin,n_fmin,slen=getkw('Lf','Lb','n_s','n_bmin','n_fmin','solid_len');
        Lf*=ux;
        Lb*=ux;
        slen*=ux;
        ppf_len = Lf*np.log(n_s/n_fmin);
        ppb_len = Lb*np.log(n_s/n_bmin);
        if test(kw,'roundup_pp'):
            ppf_len = np.ceil(ppf_len);
            ppb_len = np.ceil(ppb_len);
        elif test(kw,'roundup_ten_pp'):
            ppf_len = np.ceil(ppf_len/10) * 10;
            ppb_len = np.ceil(ppb_len/10) * 10;
        if type(getkw('fp')) != tuple:
            fpx = get_roundfpx(kw);
            if getkw('fp') != 'nc':
                fpx += getkw('fp');
            kw['fp'] = (fpx,0.0,0.0);
        kw['lim'] = list(getkw('lim'));
        kw['tlim'] = list(getkw('tlim'));
        kw['res']  = list(getkw('res'));
        kw['tlim'][0] = -ppf_len;
        kw['tlim'][1] = slen+ppb_len;
        kw['lim'][0] = kw['tlim'][0] - long_margin[0];
        kw['lim'][1] = kw['tlim'][1] + long_margin[1];
        xlen = kw['lim'][1] - kw['lim'][0];
        if test(kw, 'long_res'):
            kw['res'][0]  = int(np.round(xlen * kw['long_res']));
        elif test(kw, 'long_resd'):
            kw['res'][0]  = int(np.round(xlen / (getkw('l')*1e6 / kw['long_resd'])));
        kw['timestep'] = getkw('timestep');
        #if xlen*1e-6/kw['res'][0] < c*kw['timestep']:
        #    print("adapting timestep...");
        #    kw['timestep'] = xlen*1e-6/kw['res'][0];
        #dens = genonescale(xlen=kw['tlim'][1]-kw['tlim'][0], **kw);
        if test(kw,'dens_dat') and kw['dens_dat'] is not None:
            kw['dens_dat'] = "{:0.2f}um.dat".format(getkw('expf'));
            files.append((kw['dens_dat'], dens));
        else:
            mytlim = kw['tlim'][:2];
            kw['target_density'] = mktwoscales(n_s, [0.0, slen], mytlim, Lf, Lb, mytlim, n_fmin, n_bmin);
        print("two scales, generated dimensions:");
        print(take(kw,['Lf','Lb','res','tlim','lim','timestep']));

    #elif test(kw,'shelf'):
    #    if type(getkw('fp')) != tuple:
            # tlim = getkw('tlim');
            # kw['xlen'] = tlim[1]-tlim[0];
            # if test(kw, 'slen'):
            # if getkw('fp') != 'nc':
            #     fpx += getkw('fp');
            # kw['fp'] = (fpx,0.0,0.0);
    elif (test(kw,'externalf_1D') and test(kw, 'f_1D')) or (test(kw,'externalf_2D') and test(kw, 'f_2D')):
        if not test(kw, 'dats'): kw['dats']=[];
        tlim = getkw('tlim');
        if not test(kw, 'new_externalf'):
            kwp = sd(kw,
                     tlim=(0, tlim[1]-tlim[0],
                           0, tlim[3]-tlim[2],
                           0, 0),
                     unit=1e-4);
        else:
            kwp = sd(kw, unit=1e-4);
        if not test(kw, 'dens_dat'):
            kw['dens_dat'] = "watercolumn.dat";
        kw['dats'] += [(kw['dens_dat'], kwp)];
    if test(kw, 'dats'):
        files.extend([
            (fname, gendat(**sd(kw,**dat)))
            for fname,dat in kw['dats']
        ]);
    #
    # movies
    #
    movs = takef(kw,['movne','movni','movdq','movrho','movE','movB','movS']);
    #yes really.
    tyf = lambda s: re.search(r"mov(\w+)",s).group(1);
    movs = { tyf(k) : movs[k]
             for k in movs
             if movs[k]};
    for movtype in sorted(movs.keys()):
        sname ='mov'+movtype;
        movd={};
        if type(kw[sname]) == dict:
            movd = sd(kw,**kw[sname]);
        if not test(movd,'n_c'):
            movd['n_c'] = nc(kw['l']);
        movd['type'] = movtype;
        movstr=gen_mov(**movd);
        #adding it to pbs
        if not test(kw, "concurrents") or kw['concurrents'] is None:
            kw['concurrents'] = [(sname,'./'+sname)];
        else:
            kw['concurrents'] += [(sname,'./'+sname)];
        files.append((sname,movstr,0o755) );
    if test(kw,'angular'):
        #adding it to pbs
        if test(kw, "concurrents") and kw['concurrents'] is not None:
            kw['concurrents'] += [('genangular','./genangular')];
        else:
            kw['concurrents'] = [('genangular','./genangular')];
        files.append('genangular');

    #
    #special subdivisions
    #
    if test(kw, "splittime"):
        totaltime = getkw("totaltime");
        # Structure of splittime 
        # [ (totaltime, dict) ]
        # Each tuple represents a slice of the restarts
        # totaltime is supposed to be the end of that time slice.
        # The dict is what enters subdiv.
        # 
        # This does very little, it just overloads totaltime and
        # sets each `lspexec` of the restarts to r. It also adds a `pre`
        # that copies the restart files, facilitated by the "setrestart"
        # script.
        #
        # We read the last totaltime over the passed keyword.
        st = getkw("splittime");
        kw['subdivs'] = [];
        for i,(itime, id) in enumerate(st):
            if id is None: id = {};
            igetkw = mk_getkw(
                sd(kw,**id),
                defaults
            );
            if i == 0:
                si = '';
            else:
                si =  '_{}'.format(i);
            kw['subdivs'].append(
                sd(id,
                   totaltime=itime,
                   lspexec  =igetkw("lspexec")+" -r ",
                   dump_restart_flag=True,
                   pbsbase=pbsbase+si,));
    subdivs = getkw("subdivs");
    if len(subdivs) == 0:
        subdivs = [kw];
    for subdiv in subdivs:
        if not subdiv: subdiv=dict();
        ikw = sd(kw,**subdiv);
        igetkw = mk_getkw(ikw, defaults);
        pbses = igetkw('pbses');
        ipbsbase = igetkw('pbsbase');
        lsp=genlsp(**ikw);
        files.append((ipbsbase+".lsp", lsp));
        if pbses is None:
            files.append((ipbsbase+".pbs",genpbs(**ikw)))
        else:
            if pbses == "defaults":
                pbses = mk_hpcmp_pbses(
                    **ikw);
            for pbs in pbses:
                files.append(
                    (pbs['pbsname']+".pbs",
                     genpbs(**sd(ikw,**pbs)))
                );
    if test(kw,'extra_files'):
        files.extend(kw['extra_files']);
    dir=getkw('dir');
    if dir == True: dir = pbsbase;
    output(dir=dir,files=files);

def fromenergy(En,cycles=def_cycles,l=10e-6,l2w=2.75):
    w=l*l2w;
    T=cycles*l/c;
    I=En/(w**2*np.pi/2.0*T/2.0)*1e-4;
    return sd(defaults,w=w,T=T,I=I,l=l)
