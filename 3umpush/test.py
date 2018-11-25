#!/usr/bin/env python

d=[];
def add(a,b):
    a['h'] = b;
    d.append(a);

b=dict(h=3);
add(b,'hi');
print(d);
print(b);
