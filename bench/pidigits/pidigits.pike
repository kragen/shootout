// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// contributed by Marcus Comstedt

int k = 0;
array(int) z = ({ 1, 0, 0, 1 });

array(int) compose(array(int) a, array(int) b)
{
  return ({ a[0]*b[0], a[0]*b[1]+a[1]*b[3],
	    a[2]*b[0]+a[3]*b[2], a[2]*b[1]+a[3]*b[3] });
}

int extract(array(int) a, int j)
{
  return (a[0]*j+a[1]) / (a[2]*j+a[3]);
}

array(int) pi_digits(int c)
{
  array(int) r = allocate(c);
  for(int i=0; i<c; i++) {
    int y;
    while((y = extract(z, 3)) != extract(z, 4)) {
      ++k;
      z = compose(z, ({k, 4*k+2, 0, 2*k+1}));
    }
    z = compose(({10, -10*y, 0, 1}), z);
    r[i] = y;
  }
  return r;
}

int main(int argc, array(string) argv)
{
  int i, n = (int)argv[1];
  for(i=10; i <= n; i+=10)
    write("%@d\t:%d\n", pi_digits(10), i);
  if((i-=10) < n)
    write("%-10{%d%}\t:%d\n", pi_digits(n-i)/1, n);
  return 0;
}
