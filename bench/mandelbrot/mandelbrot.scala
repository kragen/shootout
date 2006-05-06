// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

object mandelbrot
{
  def main(args: Array[String]): unit =
  {
    val ITERATIONS: int = 50; val LIMIT_SQR:double = 4.0;

    var bit_num: int = 0; var byte_acc: int = 0x00;

    var N = Integer.parseInt(args(0));

    System.out.println("P4\n" + N + " " + N);

    var y: int = 0;

    while (y < N)
    {
      var x: int = 0;

      while (x < N)
      {
        var ZR: double = 0.0; var ZI: double = 0.0;
        var TR: double = 0.0; var TI: double = 0.0;
        var CR: double = (2.0 * x / N) - 1.5;
        var CI: double = (2.0 * y / N) - 1.0;
        var ESCAPE: boolean = false;

        var i: int = 0;

        while (i < ITERATIONS && !ESCAPE)
        {
          TR = ZR * ZR - ZI * ZI + CR; TI = 2.0 * ZR * ZI + CI;
          ZR = TR; ZI = TI;

          if (ZR * ZR + ZI * ZI > LIMIT_SQR) ESCAPE = true;
          i = i + 1;
        }

        byte_acc = (byte_acc << 1) | (if (ESCAPE) 0; else 1);

        bit_num = bit_num + 1;

        if (bit_num == 8 || x == N - 1)
        {
          byte_acc = (byte_acc << (8 - bit_num));
          System.out.write(byte_acc);
          byte_acc = 0x00; bit_num = 0;
        }

        x = x + 1;
      }

      y = y + 1;
    }

    System.out.flush();
  }
}

