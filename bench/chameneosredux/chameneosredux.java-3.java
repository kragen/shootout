/** The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Ross Judson
 */

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Exchanger;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicInteger;


public class chameneosredux {

   static final int BLOCK = 100;

   /**
    * @param args
    */
   public static void main(String[] args) {
      int n = 6000000;
      if (args.length > 0)
         n = Integer.parseInt(args[0]);

      try {
         long now = System.currentTimeMillis();
         run(n, Colour.blue, Colour.red, Colour.yellow);
         run(n, Colour.blue, Colour.red, Colour.yellow, Colour.red,
               Colour.yellow, Colour.blue, Colour.red, Colour.yellow,
               Colour.red, Colour.blue);
   
         long after = System.currentTimeMillis();
         System.out.format("Run time: %,dms\n", after - now);
      } catch (InterruptedException ie) {
         // ignore.
      }
   }

   static void run(int n, Colour... colours) throws InterruptedException {
      System.out.format("Run for %,d meetings\n", n);
      meetings.set(n);
      done = new Semaphore(-colours.length+2);
      List<Creature> creatures = new ArrayList<Creature>();
      int id = 1;
      for (Colour c: colours) {
         Creature creature = new Creature(id++, c);
         creature.start();
         creatures.add(creature);
      }
      done.acquire();
      while (done.availablePermits() <= 0)
         try {
            meetingPlace.exchange(Colour.blue, 1, TimeUnit.MILLISECONDS);
         } catch (TimeoutException e) {
            // ignore.
         }
      for (Creature c: creatures)
         System.out.println(c);
   }

   static Exchanger<Colour> meetingPlace = new Exchanger<Colour>();
   static AtomicInteger meetings = new AtomicInteger();
   static Semaphore done;
   
   static class Creature extends Thread {
      private Colour colour;
      private int count;
      final private int id;
      
      Creature(int id, Colour colour) {
         this.colour = colour;
         this.id = id;
      }

      public String toString() {
         return String.format("Creature %,d is %s, and performed %,d exchanges", id, colour, count);
      }
      
      public void run() {
         try {
            while (meetings.getAndAdd(-BLOCK) >= 0) 
               block();
         } catch (InterruptedException ie) {
            // ignore, exit.
         } finally {
            done.release();
         }
      }

      private void block() throws InterruptedException {
         for (int i = 0; i < BLOCK; i++)
            colour = doCompliment(colour, meetingPlace.exchange(colour));
         count += BLOCK;
      }

   }

   enum Colour {
      blue, red, yellow
   }

   static Colour doCompliment(Colour c1, Colour c2) {
      switch (c1) {
      case blue:
         switch (c2) {
         case blue:
            return Colour.blue;
         case red:
            return Colour.yellow;
         case yellow:
            return Colour.red;
         }
      case red:
         switch (c2) {
         case blue:
            return Colour.yellow;
         case red:
            return Colour.red;
         case yellow:
            return Colour.blue;
         }
      default:
         switch (c2) {
         case blue:
            return Colour.red;
         case red:
            return Colour.blue;
         default:
            return Colour.yellow;
         }
      }
   }
}
