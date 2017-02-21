#!/usr/bin/env python3

import numpy as np;

x = np.linspace(0.0, 1e-1, 1002);
solidtemp = 100e3
@np.vectorize
def f(x):
    if x <= 0.485e-1 or x >= 0.515e-1:
        return 1;
    else:
        return solidtemp;

T=f(x);
np.savetxt('temp.dat',np.array([[x,T]]).T);
