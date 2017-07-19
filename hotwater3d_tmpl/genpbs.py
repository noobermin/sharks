#!/usr/bin/env python3
'''
Generate a pbs file.

Usage:
  ./genpbs.py [options]

Options:
   --domains=D -d D   Set the number of domains. [default: 48]
   --ppn=N     -n N   Set the number of processors
                      per node. [default: 48]
   --pbsbase=P -p P   Set the basename of the pbs 
                      script. [default: hotwater3d_test]
'''
import re;
import numpy as np;
from docopt import docopt;
from pys import mk_getkw, sd, test;

inf = float('inf');
def stringify_stuple(s):
    if type(s) is not tuple:
        raise ValueError("Only for tuple!");
    return "({})".format(",".join(s));
pbsdefaults = dict(
    pbsbase="hotwater3d_test",
    domains=48,
    cluster="ramses",
    ppn=48,
    walltime=inf,
    lspexec='lsp-10-3d',
    concurrents=None,
    label=None,
    mkrundir=False,
)
cluster =  dict(
    ppn=48,max_walltime=9999,mpi='mpirun -np {}',max_ppn=48,condafile="~/conda"
)
clusters= {
    'ramses':sd(
        cluster,
        mpi = 'mpirun -np {} -hostfile $PBS_NODEFILE',),
    'oakley':sd(
        cluster,
        max_ppn=12,
        max_walltime=96,
        mpi='mpiexec -n {}'),
    'garnet_standard_lw':sd(
        cluster,
        max_ppn=32,
        max_walltime=168,
        mpi='aprun -n {}'),
    'garnet_standard_sm':sd(
        cluster,
        max_ppn=32,
        max_walltime=24,
        mpi='aprun -n {}'),
    'garnet_debug':sd(
        cluster,
        max_ppn=32,
        max_walltime=1,
        mpi='aprun -n {}'),
    'armstrong_standard':sd(
        cluster,
        max_ppn=24,
        max_walltime=168,
        mpi='aprun -n {}'),
    'armstrong_debug':sd(
        cluster,
        max_ppn=24,
        max_walltime=0.5,
        mpi='aprun -n {}'),
};

normal_portion_tmpl="nodes={nodes}:ppn={ppn}"
garnet_portion_tmpl="select={nodes}:ncpus={ppn}:mpiprocs={mpiprocs}"

intflr = lambda f: int(np.floor(f));
def hours_to_walltime(walltime):
    hr = intflr(walltime);
    return '{}:{}:00'.format(
        hr,intflr((walltime-hr)*60));

def dodcluster(cluster):
    return cluster == "garnet" or cluster == "armstrong" or cluster == "shepard";
mov_defaults = sd(
    pbsdefaults,
    I=3e18,
    clim=(1e17,1.5e23),
    n_c=1e21,
    sclrq_path=None,
    linthresh=1e15,
    averaging=(0,0),
    cmap='viridis',
    contour_lines = 1e19,
    contour_quantities = 'RhoN10',#this should be a tuple to distinguish from strings.
    dq_cmap='PRGn',
    ne_species='RhoN10',
    rho_species="Rho",
    ni_species=[
        ("RhoN9",8.0),
        ("RhoN8",7.0),
        ("RhoN7",6.0),
        ("RhoN6",5.0),
        ("RhoN5",4.0),
        ("RhoN4",3.0),
        ("RhoN3",2.0),
        ("RhoN2",1.0),
        ("RhoN11",1.0),],
)
mov_defaults['dq_species'] = (
    mov_defaults['ni_species'] + [ ("RhoN10", -1.0) ]);

def gen_mov(**kw):
    getkw = mk_getkw(kw,mov_defaults);
    spec = dict();
    if test(kw,'sclrq_path'):
        spec['sclrq_path'] = 'export PATH="{}:$PATH"\n'.format(
            sclrq_path);
    else:
        spec['sclrq_path'] ='';
    if getkw('cluster') == 'ramses':
        spec['sclrq_path']+='source ~/.bashrc\n';
    if not test(kw,'plotI'):
        spec['plotI']=getkw('I')/10;
    if test(kw,'condafile'):
        spec['conda'] = kw['condafile'];
    else:
        spec['conda'] = clusters[getkw('cluster')]['condafile']
    spec.update(dict(
        pbsbase=getkw('pbsbase'),
        lims=kw['clim'],
        n_c=getkw('n_c')));
    EMqs = ['B','E','S','B_energy', 'E_energy'];
    if getkw('type')=='ni' or getkw('type')=='dq':
        Q,q = zip(*getkw(getkw('type')+'_species'));
        Q = ",".join(str(i) for i in Q);
        Q = "("+Q+")";
        spec.update(dict(
            linthresh=getkw("linthresh"),
            quantity=Q,
            weights=str(q),
            averaging=getkw("averaging"),
            cmap=( getkw("cmap") if getkw('type') == 'ni'
                   else getkw("dq_cmap")),
            type=getkw('type'),
            title="Ion Density" if getkw('type') == 'ni' else 'Charge Density',
        ));
        kw['movtmpl'] = 'movni_tmpl'
    elif getkw('type') == 'ne':
        spec['quantity'] = getkw('ne_species');
    elif getkw('type') == 'rho':
        spec['quantity'] = getkw('rho_species');
        spec['cmap']  = getkw('dq_cmap');
        spec['linthresh'] = getkw('linthresh');
    elif getkw('type') in EMqs:
        if getkw('type') == 'B':
            spec['quantity'] = 'B_norm';
        elif getkw('type') == 'E':
            spec['quantity'] = 'E_norm';
        else:
            spec['quantity'] = getkw('type');
        spec['contour_lines']=getkw('contour_lines')
        spec['contour_quantities']=getkw('contour_quantities');
        #since default highlight is usually shit
        if type(spec['contour_quantities']) is tuple:
            spec['contour_quantities'] = stringify_stuple(spec['contour_quantities']);
        kw['movtmpl'] = 'movEM_tmpl';
    if test(kw, 'movtmpl'):
        fname = kw['movtmpl'];
    else:
        fname = 'mov{}_tmpl'.format(getkw('type'));
    with open(fname) as f:
        s=f.read();
    return s.format(**spec);

def genpbs(**kw):
    getkw = mk_getkw(kw,pbsdefaults);
    domains=getkw('domains');
    lspexec=getkw('lspexec');
    pbsbase=getkw('pbsbase');
    label = getkw('label');
    if not label:
        label = pbsbase;
    cluster = getkw("cluster");
    clusterq = cluster;
    concurrents = getkw('concurrents');
    if not concurrents: concurrents=[];
    if 'autozipper' not in kw or kw['autozipper']:
        concurrents = [
            ('zipper','./zipper -a >$PBS_O_WORKDIR')
        ]+concurrents
    movne=False;
    if test(kw,"queue"):
        clusterq += "_"+kw['queue'];
    mycluster = clusters[clusterq];
    if test(kw,'ppn'):
        ppn = kw['ppn'];
    else:
        ppn = mycluster['max_ppn'];
    nodes=int(domains/ppn);
    if domains%ppn > 0: nodes+=1;
    mpiformat = mycluster['mpi']
    extra_headers='';
    pre = '''
cd "$PBS_O_WORKDIR"
''';
    portions = normal_portion_tmpl.format(
        nodes=nodes,ppn=ppn);
    walltime = getkw("walltime");
    if walltime is inf:
        walltime = mycluster['max_walltime']
    elif walltime > mycluster['max_walltime']:
        import sys
        sys.stderr.write("walltime exceedes allowed for {}".format(
            clusterq));
    walltime = hours_to_walltime(walltime);
    post=''
    #
    # server quirks
    #
    if cluster == "ramses":
        if nodes == 1:
            pre += '''
D=/tmp/ngirmang.1-`mkdate`-$PBSBASE
mkdir -p $D
cd "$PBS_O_WORKDIR"
cp {lspexec} {pbsbase}.lsp *.dat $D/
'''.format(lspexec=lspexec,pbsbase=pbsbase);
            for concurrent in concurrents:
                pre+='cp {} $D/\n'.format(concurrent[0]);
            if len(concurrents) > 0:
                pre+='cp loopscript $D/\n';
            pre+='cd $D\n'
        pre = "module load openmpi-1.4.3-gnu-rpm\n\n"+pre;
    
    if dodcluster(cluster):
        if test(kw,'mpiprocs') and kw['mpiprocs'] != ppn:
            mpiformat = 'aprun -n {{}} -N {}'.format(
                kw['mpiprocs'])
            nodes=int(domains/kw['mpiprocs']);
            if domains%kw['mpiprocs'] > 0: nodes+=1;
        else:
            kw['mpiprocs'] = ppn;
        portions = garnet_portion_tmpl.format(
            nodes=nodes,
            ppn=ppn,
            mpiprocs=kw['mpiprocs']);
        extra_headers="#PBS -A __projectid__\n#PBS -q {}\n".format(
            kw['queue']);
        if test(kw, "mkrundir"):
            pre += (
                'export RUNDIR="${{PBS_JOBNAME}}_${{PBS_JOBID}}"\n'
                'mkdir -p $RUNDIR'
                'rcp {lspexec} {pbsbase}.lsp *.dat $RUNDIR'
                'cd $RUNDIR'
            );
    if cluster == "garnet":
        #truncate name because life sucks
        label = label[:14];
        if not test(kw,'queue'):
            kw['queue']="standard_lw";
    #handling conncurrent scripts
    if not dodcluster(cluster):
        for concurrent in concurrents:
            script = concurrent[0]
            pre+='''#{script}
./loopscript {script} &> $PBS_O_WORKDIR/{script}.log&
{script}_PID=$!
'''.format(script=script);
            post+="kill ${script}_PID\n".format(script=script);
            if len(concurrent)>1:
                post+="{}\n".format(concurrent[1]);
    mpirun = mpiformat.format(domains);
    #finally outputting
    with open("hotwater3d_tmpl.pbs") as f:
        s=f.read();
    return s.format(
        label=label,
        nodes=nodes,
        mpirun_opts=mpirun,
        pre=pre,
        post=post,
        ppn=ppn,
        portions=portions,
        pbsbase=getkw('pbsbase'),
        walltime=walltime,
        mpirun=mpirun,
        extra_headers=extra_headers,
        lspexec=lspexec,);

def mk_hpcmp_pbses(pbsbase='hotwater3d_tmpl',**kw):
    hpcmp_defpbs = sd(kw,
        pbsbase = pbsbase,
        pbsname = pbsbase+'_oakley',
        cluster = 'oakley',
        concurrents=None,
        queue = None,
        ppn = None,);
    return [
        dict(
            pbsname=pbsbase),
        dict(
            pbsname = pbsbase+'_oakley_autos',
            cluster = 'oakley',),
        hpcmp_defpbs,
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet",
            cluster='garnet',
            queue='standard_lw'),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_sm",
            cluster='garnet',
            queue='standard_sm',
            walltime=24),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_48",
            cluster="garnet",
            queue="standard_lw",
            walltime=48),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_garnet_debug",
            cluster='garnet',
            queue='debug',),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong",
            cluster='armstrong',
            queue='standard'),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_debug",
            cluster='armstrong',
            queue='debug'),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_48",
            cluster='armstrong',
            queue='standard',
            walltime=48),
        sd(
            hpcmp_defpbs,
            pbsname=pbsbase+"_armstrong_14",
            cluster='armstrong',
            queue='standard',
            walltime=14),
        ];



if __name__=="__main__":
    opts=docopt(__doc__,help=True);
    print("not implemented!");
