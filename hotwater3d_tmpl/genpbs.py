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
defaults = dict(
    pbsbase="hotwater3d_test",
    domains=48,
    cluster="ramses",
    ppn=48,
    walltime=inf,
    lspexec='lsp-10-3d',
    autozipper=True,
)
cluster =  dict(
    ppn=48,max_walltime=9999,mpi='mpirun -np {}',max_ppn=48,
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
    'garnet_debug':sd(
        cluster,
        max_ppn=32,
        max_walltime=1,
        mpi='aprun -n {}'),
};

normal_portion_tmpl="nodes={nodes}:ppn={ppn}"
garnet_portion_tmpl="select={nodes}:ncpus={max_ppn}:mpiprocs={ppn}"

intflr = lambda f: int(np.floor(f));
def hours_to_walltime(walltime):
    hr = intflr(walltime);
    return '{}:{}:00'.format(
        hr,intflr((walltime-hr)*60));

def genpbs(**kw):
    getkw = mk_getkw(kw,defaults);
    domains=getkw('domains');
    lspexec=getkw('lspexec');
    pbsbase=getkw('pbsbase');
    cluster = getkw("cluster");
    clusterq = cluster;
    if test(kw,"queue"):
        clusterq += "_"+kw['queue'];
    mycluster = clusters[clusterq]
    
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
    
    if cluster == "ramses":
        pre = "module load openmpi-1.4.3-gnu-rpm\n\n"+pre;
        if nodes == 1:
            pre = '''
D=/tmp/ngirmang.1-`mkdate`-$PBSBASE
mkdir -p $D
cd $PBS_O_WORKDIR
cp autozipper {lspexec} {pbsbase}.lsp *.dat $D/
cd $D
'''.format(lspexec=lspexec,pbsbase=pbsbase);
            pass;
        else:
            mpirun+="-hostfile $PBS_NODEFILE";
    elif cluster == "garnet":
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
    if test(kw, 'autozipper'):
        pre+='''#autozipper
./autozipper > $PBS_O_WORKDIR/autozipper.log&
'''
    with open("hotwater3d_tmpl.pbs") as f:
        s=f.read();
    return s.format(
        nodes=nodes,
        mpirun_opts=mpirun,
        pre=pre,
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
