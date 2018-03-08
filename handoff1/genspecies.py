#!/usr/bin/env python

import numpy as np;
from pys import sd;

species_fmt='''
;;{label}
cluster
from {xmin:e} {ymin:e} {zmin:e}
to   {xmax:e} {ymax:e} {zmax:e}
ion_species {ion_species}
electron_species {electron_species}
number_of_clusters {number_of_clusters}
particle_data_file {fname}'''

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
            out+=species_fmt.format(**i);
        else:
            xmin,xmax,ymin,ymax,zmin,zmax = clims;
            out+=species_fmt.format(
                label=l,
                ion_species=i,
                electron_species=0,
                number_of_clusters=num,
                fname=fname_fmt.format(l),
                xmin=xmin,xmax=xmax,
                ymin=ymin,ymax=ymax,
                zmin=zmin,zmax=zmax);
            
    if type(electron_species) == dict:
        out+=species_fmt.format(**electron_species);
    else:
        xmin,xmax,ymin,ymax,zmin,zmax = clims;
        out+=species_fmt.format(
            label="e-",
            ion_species=0,
            electron_species=electron_species,
            number_of_clusters=num,
            fname=fname_fmt.format("e-"),
            xmin=xmin,xmax=xmax,
            ymin=ymin,ymax=ymax,
            zmin=zmin,zmax=zmax);
    return out;
