#!/usr/bin/env python2
'''
Generate an lsp file.

Usage:
  ./genlsp.py [options]

Options:
   --domains=D -d D   Set the number of domains. [default: 48]
   --pbsbase=P -p P   Set the basename of the pbs 
                      script. [default: hotwater2d_templ]
'''
from docopt import docopt;
import re;
import numpy as np;
opts=docopt(__doc__,help=True);
domains=int(opts['--domains']);
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
pbsbase=opts['--pbsbase']
with open("hotwater2d_tmpl.pbs") as f:
    s=f.read();

print(s.format(
    nodes=nodes,
    mpirun_opts=mpirun_opts,
    pre=pre,
    pbsbase=pbsbase
));
