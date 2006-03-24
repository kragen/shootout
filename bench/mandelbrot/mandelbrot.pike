// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

int main(int argc, array(string) argv)
{
  constant ITERATIONS = 50, LIMIT_SQR = 4.0;

  int N = (int)argv[1]; int bit_num = 0, byte_acc = 0;

  write("P4\n%d %d\n", N, N);

  for (int y = 0; y < N; y++)
  {
    for (int x = 0; x < N; x++)
    {
      float ZR = 0.0, ZI = 0.0, TR = 0.0, TI = 0.0;
      float CR = (2.0 * x / N) - 1.5, CI = (2.0 * y / N) - 1.0;
      int ESCAPE = 0;

      for (int i = 0; i < ITERATIONS; i++) 
      {
        TR = ZR * ZR - ZI * ZI + CR; TI = 2.0 * ZR * ZI + CI;
        ZR = TR; ZI = TI;

        if (ZR * ZR + ZI * ZI > LIMIT_SQR) { ESCAPE = 1; break; }
      }

      byte_acc = (byte_acc << 1) | (ESCAPE ? 0 : 1); bit_num++;

      if (bit_num == 8)
      {
        write("%c", byte_acc); byte_acc = bit_num = 0;
      }
      else if (x == N - 1)
      {
        byte_acc <<= (8 - bit_num); write("%c", byte_acc);
        byte_acc = bit_num = 0;
      }
    }
  }

  return 0;
}

