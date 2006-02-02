/*
 * The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * contributed by Andrei Formiga
 */

object partialsums
{
  val twodiv3 = 2.0 / 3.0;
  var n: double = _;

  def calculate(s1:double, s2:double, s3:double, s4:double, s5:double, s6:double,
		s7:double, s8:double, s9:double, sign: double, kd: double): unit = {
    if (kd > n) {
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
      val k2 = kd * kd;
      val k3 = k2 * kd;
      val sin = Math.sin(kd);
      val cos = Math.cos(kd);
      calculate(s1 + Math.pow(twodiv3, kd - 1.0), s2 + Math.pow(kd, -0.5),
		s3 + 1.0 / (kd * (kd + 1.0)), s4 + 1.0 / (k3 * sin*sin),
		s5 + 1.0 / (k3 * cos*cos), s6 + 1.0 / kd, s7 + 1.0 / k2,
		s8 + sign / kd, s9 + sign / (2.0 * kd - 1.0), -sign, kd + 1.0);
    }
  }

  def main(args: Array[String]) = {
    n = Integer.parseInt(args(0)).toDouble;
    calculate(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 1.0);
  }
}
