// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Based on D language implementation by Dave Fladebo
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

int main(int argc, array(string) argv)
{
  int N = (int)argv[1]; float alt = 1.0;

  array(float) sum = ({0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0});

  for(float d = 1.0; d <= N; d++, alt = -alt)
  {
    float d2 = d * d, d3 = d2 * d, ds = sin(d), dc = cos(d);

    sum[0] += pow(2 / 3.0,d - 1);
    sum[1] += 1 / sqrt(d);
    sum[2] += 1 / (d * (d + 1));
    sum[3] += 1 / (d3 * ds * ds);
    sum[4] += 1 / (d3 * dc * dc);
    sum[5] += 1 / d;
    sum[6] += 1 / (d2);
    sum[7] += alt / d;
    sum[8] += alt / (2 * d - 1);
  }

  write("%.9f\t(2/3)^k\n", sum[0]);
  write("%.9f\tk^-0.5\n", sum[1]);
  write("%.9f\t1/k(k+1)\n", sum[2]);
  write("%.9f\tFlint Hills\n", sum[3]);
  write("%.9f\tCookson Hills\n", sum[4]);
  write("%.9f\tHarmonic\n", sum[5]);
  write("%.9f\tRiemann Zeta\n", sum[6]);
  write("%.9f\tAlternating Harmonic\n", sum[7]);
  write("%.9f\tGregory\n", sum[8]);

  return 0;
}

