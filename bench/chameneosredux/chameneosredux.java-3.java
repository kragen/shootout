/* The Computer Language Benchmarks Game
http://shootout.alioth.debian.org/

contributed by Sassa
complete rework of a contribution by Matthieu Bentot - reduce memory footprint, use atomics, reduce number of threads
*/

import java.util.concurrent.atomic.*;

/**
* This implementation uses standard Java threading (native threads).
*
* This implementation changes the one contributed by Michael Barker (itself based on the original
* implementation by Luzius Meisser from old chameneos) to
* - operate in constant memory: everything is allocated during initialisation;
* - change the Thread.yield() into a plain spinlock.
*/

public class chameneosredux {

   enum Colour {
      blue,
      red,
      yellow
   }

   static Colour complement(Colour c1, Colour c2) {
      if (c1==c2) return c1;

      if (c1==Colour.blue) return c2==Colour.red ? Colour.yellow : Colour.red;
      if (c1==Colour.red)  return c2==Colour.blue ? Colour.yellow: Colour.blue;
      //if (c1==yellow)
      return c2==Colour.blue ? Colour.red : Colour.blue;
   }

   private final static AtomicInteger meetingsLeft = new AtomicInteger(0);

   private final static AtomicReference<Creature>[] firstValue=(AtomicReference<Creature>[])new AtomicReference[]{ new AtomicReference<Creature>(), new AtomicReference<Creature>() };

   public static boolean meet(Creature creature) throws Exception {
     int m;
     while( (m = meetingsLeft.get()) != 0 && !meetingsLeft.compareAndSet( m, m-1 ) );
     if ( m == 0 ) return false;
     AtomicReference<Creature> fv = firstValue[m&1];

     Creature c;
     Colour c_colour;

     creature.met=null;
     for(;;)
     {
       c=fv.get();
       if( c==null )
       {
         if (fv.compareAndSet(c,creature)) break;
       }
       else
       {
         if (fv.compareAndSet(c,null)) break;
       }
     }

     if ( c==null ) // if so, then we were first to get there, wait until someone meets
     {
       while(creature.met==null);
       c_colour=creature.met;
     }
     else
     {
       c_colour = c.value;
       c.met=creature.value;
     }

     // Update creature
     creature.value=complement(creature.value, c_colour);
     creature.count++;
     if (creature==c) creature.sameCount++;
     return true;
   }

   static final class Creature extends Thread {
      volatile Colour value;
      volatile Colour met;
      volatile boolean parked;

      private int count=0, sameCount=0;

      public Creature(Colour colour) {
         this.value = colour;
      }

      public void run() {
         try {
            while(meet(this));
         } catch (Exception e) {
         }
      }

      public int getCount() {
         return count;
      }

      public String toString() {
         return String.valueOf(count) + getNumber(sameCount);
      }
   }

   private static void run(int n, Colour...colours) {
      // Initialise
      meetingsLeft.set( 2*n );

      Creature creatures[] = new Creature[colours.length];
      StringBuilder sb = new StringBuilder(80);
      for (int i = 0; i < creatures.length; i++) {
         sb.append(" ").append(colours[i]);
         creatures[i] = new Creature(colours[i]);
         if (i>0) creatures[i].start();
      }

      System.out.println(sb);

      creatures[0].run();

      // Wait...
      int total = creatures[0].getCount();
      System.out.println(creatures[0]);

      for (int i = 1; i < creatures.length; i++) {
         Creature creature=creatures[i];
         try {
            creature.join();
         } catch (InterruptedException e) {
         }
         System.out.println(creature);
         total += creature.getCount();
      }

      // Print result
      System.out.println(getNumber(total));
      System.out.println();
   }

   public static void main(String[] args) {
      int n = 600;
      if( args.length == 1)
      {
        try {
         n = Integer.parseInt(args[0]);
        } catch (Exception e) {}
      }
      n&=~1;

      printColours();

      System.out.println();

      run(n, Colour.blue, Colour.red, Colour.yellow);
      run(n, Colour.blue, Colour.red, Colour.yellow, Colour.red, Colour.yellow, Colour.blue, Colour.red, Colour.yellow, Colour.red, Colour.blue);
   }

   private static final String NUMBERS[] = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

   private static String getNumber(int n) {
      StringBuilder sb = new StringBuilder(80);
      String nStr = String.valueOf(n);
      for (int i = 0; i < nStr.length(); i++) {
         sb.append(' ').append(NUMBERS[Character.getNumericValue(nStr.charAt(i))]);
      }

      return sb.toString();
   }

   private static void printColours() {
      printColours(Colour.blue, Colour.blue);
      printColours(Colour.blue, Colour.red);
      printColours(Colour.blue, Colour.yellow);
      printColours(Colour.red, Colour.blue);
      printColours(Colour.red, Colour.red);
      printColours(Colour.red, Colour.yellow);
      printColours(Colour.yellow, Colour.blue);
      printColours(Colour.yellow, Colour.red);
      printColours(Colour.yellow, Colour.yellow);
   }

   private static void printColours(Colour c1, Colour c2) {
      System.out.println(c1 + " + " + c2 + " -> " + complement(c1, c2));
   }
}
