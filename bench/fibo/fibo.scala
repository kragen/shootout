/* The Great Computer Language Shootout 
   contributed by Isaac Gouy (Scala novice)

To compile:	
   scalac fibo.scala

To run:
   scala fibo 32
*/


object fibo {
   def main(args: Array[String]) = 
      Console.println( fib( toPositiveInt(args) ));


   def fib(n: Int): Int = 
      if (n < 2) 1; else fib(n-2) + fib(n-1);


   private def toPositiveInt(s: Array[String]) = {
      val i = 
         try { Integer.parseInt(s(0)); } 
         catch { case _ => 1 }
      if (i>0) i; else 1;
   }
}



