import numpy as np;

h=6.626070040e-34
e=1.602176208e-19
c=299792458
m_e=9.10938356e-31
#0.5**2/1-0.5  = 0.5
#0.5*n == (2*np.pi*m_e*kT/h**2)**1.5 *np.exp(-13.6/kT)
#0.5*n*h**3 / (2*np.pi*m_e)**1.5 == e**1.5*kT_eV**1.5*np.exp(-13.6/kT)
#0.5*n*h**3 / (2*np.pi*m_e*e)**1.5 == kT_eV**1.5*np.exp(-13.6/kT)
n = 0.5;
X = n**2/(1-n);
D = X*1e28*h**3 / (2*np.pi*m_e*e)**1.5;
def f(kT): return kT**1.5*np.exp(-13.6/kT);
mykt = 6.1358;
E=f(mykt) - D
print(E);
print(mykt);
