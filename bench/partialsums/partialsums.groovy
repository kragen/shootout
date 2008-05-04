/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
*/

def n = Integer.parseInt(args[0])

def twothirds = 2.0/3.0
def a1 = a2 = a3 = a4 = a5 = a6 = a7 = a8 = a9 = 0.0D
def alt = -1.0D
def k = 1.0D

while (k <= n) {
   def k2 = k * k
   def k3 = k2 * k 
   def sk = Math.sin(k)
   def ck = Math.cos(k)
   alt = -alt 

   a1 += twothirds**(k-1.0)
   a2 += 1.0/Math.sqrt(k)
   a3 += 1.0/(k*(k+1.0))
   a4 += 1.0/(k3*sk*sk)
   a5 += 1.0/(k3*ck*ck)
   a6 += 1.0/k
   a7 += 1.0/k2
   a8 += alt/k
   a9 += alt/(2.0*k - 1.0)

   k += 1.0 
}

printf("%.9f\t(2/3)^k\n", a1);
printf("%.9f\tk^-0.5\n", a2);
printf("%.9f\t1/k(k+1)\n", a3);
printf("%.9f\tFlint Hills\n", a4);
printf("%.9f\tCookson Hills\n", a5);
printf("%.9f\tHarmonic\n", a6);
printf("%.9f\tRiemann Zeta\n", a7);
printf("%.9f\tAlternating Harmonic\n", a8);
printf("%.9f\tGregory\n", a9);


