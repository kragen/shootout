/*
 * The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * contributed by Andrei Formiga
 */

object partialsums
{
  val twodiv3 = 2.0 / 3.0;

  def calculate(s1:double, s2:double, s3:double, s4:double, s5:double, s6:double,
		s7:double, s8:double, s9:double, sign: double, k: int): unit = {
    if (k == 0) {
      Console.printf("{0,number,0.000000000}\t(2/3)^k\n")(s1);
      Console.printf("{0,number,0.000000000}\tk^-0.5\n")(s2);
      Console.printf("{0,number,0.000000000}\t1/k(k+1)\n")(s3);
      Console.printf("{0,number,0.000000000}\tFlint Hills\n")(s4);
      Console.printf("{0,number,0.000000000}\tCookson Hills\n")(s5);
      Console.printf("{0,number,0.000000000}\tHarmonic\n")(s6);
      Console.printf("{0,number,0.000000000}\tRiemann Zeta\n")(s7);
      Console.printf("{0,number,0.000000000}\tAlternating Harmonic\n")(s8);
      Console.printf("{0,number,0.000000000}\tGregory\n")(s9);
    }
    else {
      val k2 = k * k.toDouble;
      val k3 = k2 * k;
      val sin = Math.sin(k);
      val cos = Math.cos(k);
      calculate(s1 + Math.pow(twodiv3, k - 1.0), s2 + Math.pow(k, -0.5),
		s3 + 1.0 / (k * (k + 1.0)), s4 + 1.0 / (k3 * sin*sin),
		s5 + 1.0 / (k3 * cos*cos), s6 + 1.0 / k, s7 + 1.0 / k2,
		s8 + sign / k, s9 + sign / (2 * k - 1), -sign, k - 1);
    }
  }

  def main(args: Array[String]) = {
    val n = Integer.parseInt(args(0));
    calculate(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, n);
  }
}
