/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Meiko Rachimow
*/

object spectralnorm {

   def main(args: Array[String]) = {
      val n = {if (args.length > 0) Integer.parseInt(args(0)) else 100}
      val formatter = new java.text.DecimalFormat("#.000000000");
      println(formatter.format(new SpectralNorm() approximate(n)))
   }
}

class SpectralNorm(){

   type Vector = Array[double]

   def approximate(n: int)= {
      val u = new Vector(n)
      var i = 0;
      while (i < n){ u(i) = 1.0; i = i+1 }

      val v = new Vector(n)

      i = 0
      while (i < 10){
         multiplyAtAv(n,u,v)
         multiplyAtAv(n,v,u)
         i = i+1
      }

      var vbv = 0.0; var vv = 0.0
      i = 0
      while (i < n){
         vbv = vbv + u(i)*v(i)
         vv = vv + v(i)*v(i)
         i = i+1
      }

      Math sqrt(vbv/vv)
   }


   def a(i: int, j: int) = 1.0/((i+j)*(i+j+1)/2 +i+1)

   def multiplyAv(n: int, v: Vector, av: Vector) = {
      var i = 0
      while (i < n){
         av(i) = 0.0
         var j = 0
         while (j < n){ av(i) = av(i) + a(i,j) * v(j); j = j+1 }
         i = i+1
      }
   }

   def multiplyAtv(n: int, v: Vector, atv: Vector) = {
      var i = 0
      while (i < n){
         atv(i) = 0.0
         var j = 0
         while (j < n){ atv(i) = atv(i) + a(j,i) * v(j); j = j+1 }
         i = i+1
      }
   }

   def multiplyAtAv(n: int, v: Vector, atav: Vector) = {
      val u = new Vector(n)
      multiplyAv(n,v,u)
      multiplyAtv(n,u,atav)
   }

}
