#!/usr/bin/env python3
from genlsp import genlsp;
from genpbs import genpbs;
import re;
import os;
from pys import sd,test;
import shutil as sh;
def mkdir(dir):
    os.makedirs(dir, exist_ok=True);
    return;
    try: 
        os.makedirs(dir)
    except OSError:
        if not os.path.isdir(dir):
            raise
def output(lsp,pbs,pbsbase,
           dats=["sine700points.dat","watercolumn.dat"],
           dir=None):
    if dir:
        mkdir(dir);
        pbsbase = dir+"/"+pbsbase;
        for dat in dats:
            sh.copy(dat, dir);
    with open(pbsbase+".lsp","w") as f:
        f.write(lsp);
    with open(pbsbase+".pbs","w") as f:
        f.write(pbs);
lsp_d=dict(
    l=780e-7, w=2.17e-4,I=3e18,
    lim=(-40, 10, -20, 20),
    tlim=(-27.5, 0, -15, 15),
    res=(2000, 1600),
    description="two colors",
    targetdat="watercolumn.dat",
    domains=48);

def mksim(pbsbase,**d):
    print("making {}".format(pbsbase));
    myd = sd(lsp_d, **d);
    lsp=genlsp(**myd);
    #two color hack
    if test(myd, 'relative_phase'):
        relative_phases="phase {}".format(myd['relative_phase'])
    else:
        relative_phases=''
    lasers = '''
laser
wavelength 780e-7
spotsize   2.17e-4

laser
amplitude  0.36
wavelength 390e-7
{phase}
end
'''.format(phase=relative_phases);
    if test(myd, 'two_colors'):
        lsp = re.sub(r'type *19.*','type 85',lsp);
        lsp = re.sub(r' *; *\\lambda *spotsize','',lsp);
        lsp = re.sub('.*coefficients 7.80*e-03.*$', lasers,lsp,flags=re.MULTILINE);
    pbs=genpbs(pbsbase=pbsbase,domains=myd['domains']);
    pbs = re.sub("../scripts/autozipper","../../scripts/autozipper",pbs);
    output(lsp,pbs,pbsbase,
           dats=["sine700points.dat", myd['targetdat']],
           dir=pbsbase);

mksim("hotwater2d_baseline");
mksim("hotwater2d_2w",two_colors=True);

mksim("hotwater2d_2w_superlong",
      two_colors=True,
      targetdat="superlong.dat",
      lim=(-85,10,-20,20),
      tlim=(-75,0,-9,9),
      res=(3800,1600),
      domains=96,
      totaltime=350e-15,
      description="huuger two colors",
      fp=(-50,0,0));
mksim("hotwater2d_superlong_baseline",
      two_colors=False,
      targetdat="superlong.dat",
      lim=(-85,10,-20,20),
      tlim=(-75,0,-9,9),
      res=(3800,1600),
      domains=96,
      totaltime=350e-15,
      description="huuger two colors",
      fp=(-50,0,0));


