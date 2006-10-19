/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

object spectralnorm
{
  def main(args: Array[String]): unit =
  {
    val N = Integer.parseInt(args(0))
    Console.printf("{0,number,0.000000000}\n")(approximate(N))
  }

  def approximate(n: int): double =
  {
    val u: Array[double] = new Array[double](n) ; val v: Array[double] = new Array[double](n)
    var vBv: double = 0.0 ; var vV: double = 0.0 ; var i: int = 0

    i = 0 ; while (i < n) { u(i) = 1.0 ; i = i + 1 }
    i = 0 ; while (i < 10) { mulAtAv(n, u, v) ; mulAtAv(n, v, u) ; i = i + 1 }
    i = 0 ; while (i < n) { vBv = vBv + u(i) * v(i) ; vV = vV + v(i) * v(i) ; i = i + 1 }

    return Math.sqrt(vBv / vV)
  }

  def A(i: int, j: int): double =
  {
    return 1.0 / ((i + j) * ( i + j + 1.0) / 2.0 + i + 1.0)
  }

  def mulAv(n: int, v: Array[double], av: Array[double]): unit =
  {
    var i: int = 0

    while (i < n)
    {
      var j: int = 0 ; av(i) = 0.0 

      while (j < n)
      {
        av(i) = av(i) + A(i, j) * v(j) ; j = j + 1
      }

      i = i + 1
    }
  }

  def mulAtV(n: int, v: Array[double], atv: Array[double]): unit =
  {
    var i: int = 0

    while (i < n)
    {
      var j: int = 0 ; atv(i) = 0.0 

      while (j < n)
      {
        atv(i) = atv(i) + A(j, i) * v(j) ; j = j + 1
      }

      i = i + 1
    }
  }

  def mulAtAv(n: int, v: Array[double], atav: Array[double]): unit =
  {
    val u: Array[double] = new Array[double](n)
    mulAv(n, v, u) ; mulAtV(n, u, atav)
  }
}

