#!/usr/bin/env python

import numpy as np;
from pys import sd;

cluster_fmt='''
;;{label}
cluster
from {xmin:e} {ymin:e} {zmin:e}
to   {xmax:e} {ymax:e} {zmax:e}
ion_species {ion_species}
electron_species {electron_species}
number_of_clusters {number_of_clusters}
particle_data_file {fname}'''

mt  = lambda t,m=1e-4: tuple([i*m for i in t]);
def genclusters(
        electron_species=None,
        ion_species=None,
        ion_labels=None,
        fname_fmt='{}part.p4',
        clims=None,
        num=1):
    out="";
    if ion_labels is None:
        ion_labels = [
            None if type(i)==dict else "species {}".format(i)
            for i in ion_species ];
    for i,l in zip(ion_species,ion_labels):
        if type(i) == dict:
            out+=cluster_fmt.format(**i);
        else:
            xmin,xmax,ymin,ymax,zmin,zmax = mt(clims);
            out+=cluster_fmt.format(
                label=l,
                ion_species=i,
                electron_species=0,
                number_of_clusters=num,
                fname=fname_fmt.format(l),
                xmin=xmin,xmax=xmax,
                ymin=ymin,ymax=ymax,
                zmin=zmin,zmax=zmax);
            
    if type(electron_species) == dict:
        out+=cluster_fmt.format(**electron_species);
    else:
        xmin,xmax,ymin,ymax,zmin,zmax = mt(clims);
        out+=cluster_fmt.format(
            label="e-",
            ion_species=0,
            electron_species=electron_species,
            number_of_clusters=num,
            fname=fname_fmt.format("e-"),
            xmin=xmin,xmax=xmax,
            ymin=ymin,ymax=ymax,
            zmin=zmin,zmax=zmax);
    return out;






fileread_fmt = '''
fileread
from {xmin} {ymin} {zmin}
to   {xmax} {ymax} {zmax}
normal {normal}
interval {interval}
species {species}
temporal_function {tfunc}
particle_data_file {fname}
recycle_time {recycle}
time_advance {advance}

'''

def genfileread(
        lims=None,
        normal='X',
        interval=1,
        species=17,
        fname=None,
        tfunc=6,
        time_advance=0,
        recycle_time=0):
    xmin,xmax = lims[:2]
    ymin,ymax = lims[2:4]
    zmin,zmax = lims[4:6];
    return fileread_fmt.format(
        xmin=xmin,
        xmax=xmax,
        ymin=ymin,
        ymax=ymax,
        zmin=zmin,
        zmax=zmax,
        normal=normal,
        interval=interval,
        species=species,
        tfunc=tfunc,
        fname=fname,
        recycle=recycle_time,
        advance=time_advance);

