/* The Great Computer Language Shootout 
   contributed by Isaac Gouy (Scala novice)

To compile:	
   scalac random.scala

To run:
   scala random 900000
*/


object random {
   def main(args: Array[String]) = {
      var n = toPositiveInt(args);
      var result: Double = _;

      while (n>0) { result=generate(100.0); n=n-1; }

      Console.println( result );
   }


   private val IM = 139968;
   private val IA = 3877;
   private val IC = 29573;
   private var seed = 42;

   def generate(max: Double) = {
      seed = (seed * IA + IC) % IM;
      max * seed / IM;
   }


   private def toPositiveInt(s: Array[String]) = {
      val i = 
         try { Integer.parseInt(s(0)); } 
         catch { case _ => 1 }
      if (i>0) i; else 1;
   }
}



