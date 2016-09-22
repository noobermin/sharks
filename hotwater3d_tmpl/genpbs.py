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
pbsdefaults = dict(
    pbsbase="hotwater3d_test",
    domains=48,
    cluster="ramses",
    ppn=48,
    walltime=inf,
    lspexec='lsp-10-3d',
    autozipper=True,
    concurrents=None,
    label=None,
)
cluster =  dict(
    ppn=48,max_walltime=9999,mpi='mpirun -np {}',max_ppn=48,condafile="~/conda"
)
clusters= {
    'ramses':cluster,
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
garnet_portion_tmpl="select={nodes}:ncpus={max_ppn}:mpiprocs={ppn}"

intflr = lambda f: int(np.floor(f));
def hours_to_walltime(walltime):
    hr = intflr(walltime);
    return '{}:{}:00'.format(
        hr,intflr((walltime-hr)*60));
movne_defaults = sd(
    pbsdefaults,
    I=3e18,
    lims=(1e17,1.5e23),
    n_c=1e21,
    sclrq_path=None);

def gen_movne(**kw):
    getkw = mk_getkw(kw,movne_defaults);
    if test(kw,'sclrq_path'):
        sclrq_path = 'export PATH="{}:$PATH"\n'.format(sclrq_path);
    else:
        sclrq_path ='';
    if getkw('cluster') == 'ramses':
        sclrq_path+='source ~/.bashrc\n';
    if not test(kw,'plotI'):
        plotI=getkw('I')/10;
    if test(kw,'condafile'):
        conda = kw['condafile'];
    else:
        conda = clusters[getkw('cluster')]['condafile']
    with open("movne_tmpl") as f:
        s=f.read();
    return s.format(
        conda=conda,
        pbsbase=getkw('pbsbase'),
        sclrq_path=sclrq_path,
        plotI = plotI,
        lims=str(getkw('clim')),
        n_c=getkw('n_c'));

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

    extra_headers='';
    mpirun= mycluster['mpi'].format(domains);
    pre = '''
cd $PBS_O_WORKDIR
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
    if cluster == "ramses":
        if nodes == 1:
            pre += '''
D=/tmp/ngirmang.1-`mkdate`-$PBSBASE
mkdir -p $D
cd $PBS_O_WORKDIR
cp {lspexec} {pbsbase}.lsp *.dat $D/
'''.format(lspexec=lspexec,pbsbase=pbsbase);
            for concurrent in concurrents:
                pre+='cp {} $D/\n'.format(concurrent[0]);
            if len(concurrents) > 0:
                pre+='cp loopscript $D/\n';
            pre+='cd $D\n'
        else:
            mpirun+="-hostfile $PBS_NODEFILE";
        pre = "module load openmpi-1.4.3-gnu-rpm\n\n"+pre;
    elif cluster == "garnet" or cluster == "armstrong":
        if not test(kw,'queue'):
            kw['queue']="standard_lw";
        if not test(kw,'mpiprocs'):
            kw['mpiprocs']=ppn;    
        portions = garnet_portion_tmpl.format(
            nodes=nodes,
            max_ppn=mycluster['max_ppn'],
            ppn=ppn);
        extra_headers='''
#PBS -A __projectid__
#PBS -q {}
'''.format(kw['queue']);
    if cluster == "garnet":
        #truncate name because life sucks
        label = label[:14];
    #handling conncurrent scripts
    for concurrent in concurrents:
        script = concurrent[0]
        pre+='''#{script}
./loopscript {script} &> $PBS_O_WORKDIR/{script}.log&
{script}_PID=$!
'''.format(script=script);
        post+="kill ${script}_PID\n".format(script=script);
        if len(concurrent)>1:
            post+="{}\n".format(concurrent[1]);
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
if __name__=="__main__":
    opts=docopt(__doc__,help=True);
    print("not implemented!");
