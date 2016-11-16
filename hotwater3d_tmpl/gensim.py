#!/usr/bin/env python3
from genlsp import genlsp,lspdefaults
from genpbs import genpbs,gen_mov,pbsdefaults,mov_defaults;
from gendat import gentargetdat,genonescale,datdefaults;
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
def_cycles=40e-15/(780e-9/c);
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
def scaletuple(t,scale=1e-4):
    return tuple([it*scale for it in t]);
defaults = sd(datdefaults,**pbsdefaults);
defaults = sd(defaults,**lspdefaults);
defaults.update(dict(
    pbsbase="hotwater3d",
    autozipper=None,
    movne=False,
    movni=False,
    movdq=False,
    movrho=False,
    angular=False,
    pbses=None,
    dir=None,
));

def get_roundfpx(d):
    dx = -np.log(nc(d['l'])/d['n_s'])*d['expf'];
    return d['tlim'][1]-d['solid_len']-dx;

def gensim(**kw):
    getkw =  mk_getkw(kw,defaults);
    pbsbase=getkw("pbsbase");
    files = ["sine700points.dat"];
    pbses = getkw("pbses");
    if test(kw, "autozipper"):
        files.append('zipper');
    files.append('loopscript');
    # for singlescale
    if test(kw,'singlescale'):
        if type(getkw('fp')) != tuple:
            fpx = get_roundfpx(kw);
            if getkw('fp') != 'nc':
                fpx += getkw('fp');
            kw['fp'] = (fpx,0.0,0.0);
        tlim = getkw('tlim')
        kw['xlen'] = tlim[1]-tlim[0];
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
            kw['res'][0]  = xlen * kw['long_res']
        elif test(kw, 'long_resd'):
            kw['res'][0]  = int(np.ceil(xlen / (getkw('l')*1e6 / kw['long_resd'])));
        kw['timestep'] = getkw('timestep');
        if xlen*1e-6/kw['res'][0] < c*kw['timestep']:
            print("adapting timestep...");
            kw['timestep'] = xlen*1e-6/kw['res'][0];
        dens = genonescale(xlen=kw['tlim'][1]-kw['tlim'][0], **kw);
        kw['dens_dat'] = "{:0.2f}um.dat".format(getkw('expf'));
        files.append((kw['dens_dat'], dens));
        print("from scale_with_min, generated dimensions:");
        print(take(kw,['expf','res','tlim','lim','timestep']))
    #elif test(kw,'shelf'):
    #    if type(getkw('fp')) != tuple:
            # tlim = getkw('tlim');
            # kw['xlen'] = tlim[1]-tlim[0];
            # if test(kw, 'slen'):
            # if getkw('fp') != 'nc':
            #     fpx += getkw('fp');
            # kw['fp'] = (fpx,0.0,0.0);
    elif test(kw,'externalf_1D'):
        tlim = getkw('tlim');
        kwp = sd(kw, tlim=(0, tlim[1]-tlim[0], 0,0, 0,0))
        dens = gentargetdat(**kwp);
        if not test(kw, 'dens_dat'):
            kw['dens_dat'] = "watercolumn.dat";
        files.append((kw['dens_dat'], dens));
    #movies
    movs = takef(kw,['movne','movni','movdq','movrho']);
    #yes really.
    tyf = lambda s: re.search(r"mov(\w+)",s).group(1);
    movs = { tyf(k) : movs[k]
             for k in movs
             if movs[k]};
    for movtype in movs:
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
    lsp=genlsp(**kw);
    files.append((pbsbase+".lsp", lsp));
    if pbses is None:
        files.append((pbsbase+".pbs",genpbs(**kw)))
    else:
        for pbs in pbses:
            files.append(
                (pbs['pbsname']+".pbs", genpbs(**sd(kw,**pbs)))
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
