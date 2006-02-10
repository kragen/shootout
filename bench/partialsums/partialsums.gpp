//   The Computer Language Shootout
//   http://shootout.alioth.debian.org/
//   contributed by Greg Buchholz
//   compile with:  -O3 -ffast-math

#include<iostream>
#include <iomanip>
#include<cmath>

int main(int argc, char* argv[])
{
    int n = atoi(argv[1]);
    double sum, a, s, s2, c, c2, k2, k3;
    std::cout << std::setprecision(9) << std::fixed;
    
#define psum(name,f) sum = 0; for(double k=1; k<=n; k++){ sum+= f;} \
                     std::cout << sum << "\t" << name << std::endl

    psum("(2/3)^k",pow(2.0/3.0, k-1));  psum("k^-0.5",1.0/sqrt(k)); 
    psum("1/k(k+1)",1.0/(k*(k+1.0))); 
    psum("Flint Hills",  (s=sin(k),1.0/(k*k*k * s*s)));
    psum("Cookson Hills",(c=cos(k),1.0/(k*k*k * c*c))); 
    psum("Harmonic",1.0/k);  psum("Riemann Zeta",1.0/(k*k)); 
    a = -1.0; psum("Alternating Harmonic",(a = -a)/k);
    a = -1.0; psum("Gregory",(a = -a)/(2.0*k -1));
}
