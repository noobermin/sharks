#!/usr/bin/env python



kg_per_amu = 1.66054e-27
e_mass = 9.10938356e-31
p_mass = 1.6726219e-27

#first, we have that the hydrogen mass is reported as

H_amu = 1.00794 # +/- 0.00001

#This is the (hypothetical) hydrogen atom, which includes electrons. To see this,
print((e_mass + p_mass - H_amu * kg_per_amu)/(H_amu*kg_per_amu));
print(H_amu*kg_per_amu / e_mass);
#so reported values include electrons.
O_amu = 15.999

r= p_mass / e_mass # should be ~1836
print(r);

O_emassu = O_amu * kg_per_amu / e_mass;
print(O_emassu);



