// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Code based on / inspired by existing, relevant Shootout submissions
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

int ack(int x, int y)
{
  if (x == 0) return y + 1;
  if (y == 0) return ack(x - 1, 1);
  return ack(x - 1, ack(x, y - 1));
}

// --------------

int fib(int n)
{
  if (n < 2) return 1;
  return fib(n - 2) + fib(n - 1);
}

float fibflt(float n)
{
  if (n < 2.0) return 1.0;
  return fibflt(n - 2.0) + fibflt(n - 1.0);
}

// --------------

int tak(int x, int y, int z)
{
  if (y < x) return tak(tak(x - 1, y, z), tak(y - 1, z, x), tak(z - 1, x, y));
  return z;
}

float takflt(float x, float y, float z)
{
  if (y < x) return takflt(takflt(x - 1.0, y, z), takflt(y - 1.0, z, x), takflt(z - 1.0, x, y));
  return z;
}

// --------------------------------

int main(int argc, array(string) argv)
{
  int N = (int)argv[1];

  write("Ack(3,%d): %d\n", N, ack(3, N));
  write("Fib(%.1f): %.1f\n", 27.0 + N, fibflt(27.0 + N));

  N -= 1;
  write("Tak(%d,%d,%d): %d\n", N * 3, N * 2, N, tak(N * 3, N * 2, N));

  write("Fib(3): %d\n", fib(3));
  write("Tak(3.0,2.0,1.0): %.1f\n", takflt(3.0, 2.0, 1.0));

  return 0;
}

