#!/usr/bin/env python2
'''
Generate a pbs file.

Usage:
  ./genpbs.py [options]

Options:
   --domains=D -d D   Set the number of domains. [default: 48]
   --pbsbase=P -p P   Set the basename of the pbs 
                      script. [default: hotwater2d_templ]
'''
import re;
import numpy as np;
from docopt import docopt;

def genpbs(pbsbase="hotwater2d_templ",domains=48):
    nodes=domains/48
    if domains%48 > 0: nodes+=1;
    
    if nodes == 1:
        pre = '''
D=/tmp/ngirmang.1-$PBSBASE-`mkdate`
mkdir -p $D
cd $PBS_O_WORKDIR
cp ../scripts/autozipper $D/
cp lsp-10-xy *.lsp *.dat $D/
cd $D
'''
        mpirun_opts="-np {}".format(domains);
    else:
        pre = '''
cd $PBS_O_WORKDIR
cp ../scripts/autozipper ./
''';
        mpirun_opts="-np {} -hostfile $PBS_NODEFILE".format(domains);
    with open("hotwater2d_tmpl.pbs") as f:
        s=f.read();
    return s.format(
        nodes=nodes,
        mpirun_opts=mpirun_opts,
        pre=pre,
        pbsbase=pbsbase);
if __name__=="__main__":
    opts=docopt(__doc__,help=True);
    domains,pbsbase = int(opts['--domains']),opts['--pbsbase'];
    print(genpbs(pbsbase=pbsbase,domains=domains));

    
