
#inclusive means material volume contains edges
def gencyl0(R, length, floor=0,
            R_inclusive = True,
            z_max_inclusive = True,
            z_min_inclusive = True):
    '''cylinder with no exponential scales'''
    def fret(x,y,z):
        zmin, zmax = -length/2, length/2
        r = np.sqrt(x**2 + y**2);
        v = np.ones_like(r)*floor;
        v[r<=R] = 1.0;
        v[z>zmax] = floor;
        v[z<zmin] = floor;

        if not R_inclusive:
            v[r == R] = floor;
        if not z_max_inclusive:
            v[z == zmax] = floor;
        if not z_min_inclusive:
            v[z == zmin] = floor;
        return v;
    return fret;



def gencyl1(r_s, L, r_max, length, floor=0,
            r_max_inclusive = True,
            z_max_inclusive = True,
            z_min_inclusive = True):
    '''cylinder with exponential scale off the radius'''
    def fret(x,y,z):
        r = np.sqrt(x**2 + y**2);
        v = np.ones_like(r)*floor;
        v[r<r_s] = 1.0;
        exp = np.exp(-(r-r_s)/L);
        v[r>=r_s]   = exp[r>=r_s];
        v[r>r_max]     = floor;
        v[z> length/2] = floor;
        v[z<-length/2] = floor;

        if not r_max_inclusive:
            v[r ==  r_max] = floor;
        if not z_max_inclusive:
            v[z ==  length/2] = floor;
        if not z_min_inclusive:
            v[z == -length/2] = floor;
        return v;
    return fret;
        
def gencyl2(R,Lf,Lb,
            f_min, b_max,
            length,floor=0,
            R_inclusive = True,
            f_max_inclusive = True,
            b_max_inclusive = True):
    '''cylinder with exponential scale off front and back'''
    def fret(x,y,z):
        r = np.sqrt(x**2 + y**2);
        v = np.ones_like(r)*floor;
        zmin, zmax = -length/2, length/2
        v[r <= R] = 1.0;
        
        fexp = np.exp( (z-zmin)/L);
        bexp = np.exp(-(z-zmax)/L);

        v[z >= zmax] = bexp[z >= zmax];
        v[z <= zmin] = fexp[z <= zmin];

        v[z < f_min] = floor;
        v[z > b_max] = floor;
        
        if not R_inclusive:
            v[r == R] = floor;
        if not b_max_inclusive:
            v[z == b_max] = floor;
        if not f_min_inclusive:
            v[z == f_min] = floor;
        return v;
    return fret;
