import java.util.Deque;
import java.util.concurrent.BlockingDeque;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Michael Barker
*/

/**
 * This implementation uses the java.util.concurrent.atomic library
 * i.e. (compare and set) to avoid locking.  Real threads are used, but
 * are set up as a thread pool and meeting requests are pushed onto a
 * queue that feeds the thread pool.
 */
public class chameneosredux {

    enum Colour {
        blue,
        red,
        yellow
    }

    private static Colour doCompliment(Colour c1, Colour c2) {
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
        case yellow:
            switch (c2) {
            case blue:
                return Colour.red;
            case red:
                return Colour.blue;
            case yellow:
                return Colour.yellow;
            }
        }

        throw new RuntimeException("Error");
    }

    static class MeetingPlace {

        private final AtomicInteger meetingsLeft;
        private final AtomicReference<Creature> creatureRef = new AtomicReference<Creature>();

        public MeetingPlace(int meetings) {
            meetingsLeft = new AtomicInteger(meetings);
        }

        public boolean meet(Creature incoming) {
            Colour newColour = null;
            Creature first = null;
            Creature next = null;
            do {
                first = creatureRef.get();
                next = incoming;
                if (first != null) {
                    newColour = doCompliment(incoming.colour, first.colour);
                    next = null;
                }
            } while (!creatureRef.compareAndSet(first, next));
            
            boolean isComplete = false;
            if (first != null) {
                int meetings = meetingsLeft.getAndDecrement();
                if (meetings == 1) {
                    first.setColour(incoming.id, newColour, true);
                    incoming.setColour(first.id, newColour, true);
                } else if (meetings > 1) {
                    first.setColour(incoming.id, newColour, false);
                    incoming.setColour(first.id, newColour, false);
                } else {
                    first.complete();
                    incoming.complete();
                }
            }
            return isComplete;
        }
    }
    
    static class Dispatcher implements Runnable {
        private final BlockingDeque<Creature> q;

        public Dispatcher(BlockingDeque<Creature> q) {
            this.q = q;
        }

        public void run() {
            try {
                while (true) {
                    q.take().run();
                }
            } catch (InterruptedException e) {
            }
        }
    }

    static class Creature implements Runnable {

        private final int id;
        private final MeetingPlace place;
        private final Deque<Creature> q;
        private final CountDownLatch latch;
        private int count = 0;
        private int sameCount = 0;
        private Colour colour;

        public Creature(MeetingPlace place, Colour colour, Deque<Creature> q, CountDownLatch latch) {
            this.id = System.identityHashCode(this);
            this.place = place;
            this.latch = latch;
            this.colour = colour;
            this.q = q;
        }

        public void complete() {
            latch.countDown();
        }

        public void setColour(int id, Colour newColour, boolean isComplete) {
            this.colour = newColour;
            count++;
            if (this.id == id) {
                sameCount++;                
            }
            if (!isComplete) {
                q.push(this);
            } else {
                complete();
            }
        }

        public void run() {
            place.meet(this);
        }

        public int getCount() {
            return count;
        }

        public String toString() {
            return String.valueOf(count) + getNumber(sameCount);
        }
    }

    private static void run(int n, Colour...colours) {
        int len = colours.length;
        MeetingPlace place = new MeetingPlace(n);
        Creature[] creatures = new Creature[len];
        BlockingDeque<Creature> q = new LinkedBlockingDeque<Creature>();
        CountDownLatch latch = new CountDownLatch(len - 1);
        
        for (int i = 0; i < len; i++) {
            System.out.print(" " + colours[i]);
            creatures[i] = new Creature(place, colours[i], q, latch);
        }
        
        System.out.println();
        Thread[] ts = new Thread[len];
        for (int i = 0; i < len; i++) {
            ts[i] = new Thread(new Dispatcher(q));
            ts[i].start();
        }
        
        for (Creature creature : creatures) {
            q.push(creature);
        }
        
        try {
            latch.await();
        } catch (InterruptedException e1) {
            System.err.println("Existing with error: " + e1);
        }

        for (Thread t : ts) {
            t.interrupt();
        }

        int total = 0;
        for (Creature creature : creatures) {
            System.out.println(creature);
            total += creature.getCount();
        }
        System.out.println(getNumber(total));
        System.out.println();
    }

    public static void main(String[] args){
        chameneosredux.program_main(args,true);
    }

    public static void program_main(String[] args, boolean isWarm) {

        int n = 600;
        try {
            n = Integer.parseInt(args[0]);
        } catch (Exception e) {
        }

        printColours();
        System.out.println();
        run(n, Colour.blue, Colour.red, Colour.yellow);
        run(n, Colour.blue, Colour.red, Colour.yellow, Colour.red, Colour.yellow,
               Colour.blue, Colour.red, Colour.yellow, Colour.red, Colour.blue);
    }

    public static class Pair {
        public final boolean sameId;
        public final Colour colour;

        public Pair(boolean sameId, Colour c) {
            this.sameId = sameId;
            this.colour = c;
        }
    }

    private static final String[] NUMBERS = {
        "zero", "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine"
    };

    private static String getNumber(int n) {
        StringBuilder sb = new StringBuilder();
        String nStr = String.valueOf(n);
        for (int i = 0; i < nStr.length(); i++) {
            sb.append(" ");
            sb.append(NUMBERS[Character.getNumericValue(nStr.charAt(i))]);
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
        System.out.println(c1 + " + " + c2 + " -> " + doCompliment(c1, c2));
    }


}
