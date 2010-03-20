/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Michael Barker
*/


import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;


/**
 * This implementation uses the java.util.concurrent.atomic library
 * i.e. (compare and set) to avoid locking.  Real threads are used, but
 * are set up as a thread pool and meeting requests are pushed onto a
 * queue that feeds the thread pool.
 */
public final class chameneosredux {

    enum Colour {
        blue,
        red,
        yellow
    }

    private static Colour doCompliment(final Colour c1, final Colour c2) {
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

    static final class MeetingPlace {

        private final AtomicInteger meetingsLeft;
        private final AtomicReference<Creature> creatureRef = new AtomicReference<Creature>();

        public MeetingPlace(final int meetings) {
            meetingsLeft = new AtomicInteger(meetings);
        }

        public void meet(final Creature incoming) {
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

            if (first != null) {
                final int meetings = meetingsLeft.decrementAndGet();
                if (meetings >= 0) {
                    first.setColour(incoming.id, newColour);
                    incoming.setColour(first.id, newColour);
                } else {
                    first.complete();
                    incoming.complete();
                }
            }
        }
    }

    static final class Dispatcher implements Runnable {
        private final BlockingQueue<Creature> q;

        public Dispatcher(final BlockingQueue<Creature> q) {
            this.q = q;
        }

        public void run() {
            try {
                while (true) {
                    q.take().run();
                }
            } catch (final InterruptedException e) {
            }
        }
    }

    static final class Creature {

        private final int id;
        private final MeetingPlace place;
        private final BlockingQueue<Creature> q;
        private final CountDownLatch latch;
        private int count = 0;
        private int sameCount = 0;
        private Colour colour;

        public Creature(final MeetingPlace place, final Colour colour,
                        final BlockingQueue<Creature> q, final CountDownLatch latch) {
            this.id = System.identityHashCode(this);
            this.place = place;
            this.latch = latch;
            this.colour = colour;
            this.q = q;
        }

        public void complete() {
            latch.countDown();
        }

        public void setColour(final int id, final Colour newColour) {
            this.colour = newColour;
            count++;
            sameCount += 1 ^ Integer.signum(abs(this.id - id));
            q.add(this);
        }

        private int abs(final int x) {
            final int y = x >> 31;
            return (x ^ y) - y;
        }

        public void run() {
            place.meet(this);
        }

        public int getCount() {
            return count;
        }

        @Override
        public String toString() {
            return String.valueOf(count) + getNumber(sameCount);
        }
    }

    private static void run(final int n, final Colour...colours) {
        final int len = colours.length;
        final MeetingPlace place = new MeetingPlace(n);
        final Creature[] creatures = new Creature[len];
        final BlockingQueue<Creature> q = new ArrayBlockingQueue<Creature>(len);
        final CountDownLatch latch = new CountDownLatch(len - 1);

        for (int i = 0; i < len; i++) {
            System.out.print(" " + colours[i]);
            creatures[i] = new Creature(place, colours[i], q, latch);
        }

        System.out.println();
        final Thread[] ts = new Thread[len];
        for (int i = 0, h = ts.length; i < h; i++) {
            ts[i] = new Thread(new Dispatcher(q));
            ts[i].setDaemon(true);
            ts[i].start();
        }

        for (final Creature creature : creatures) {
            q.add(creature);
        }

        try {
            latch.await();
            for (final Thread t : ts) {
                t.interrupt();
            }
            for (final Thread t : ts) {
                t.join();
            }
        } catch (final InterruptedException e1) {
            System.err.println("Existing with error: " + e1);
        }

        int total = 0;
        for (final Creature creature : creatures) {
            System.out.println(creature);
            total += creature.getCount();
        }
        System.out.println(getNumber(total));
        System.out.println();
    }

    public static void main(final String[] args){
        chameneosredux.program_main(args,true);
    }

    public static void program_main(final String[] args, final boolean isWarm) {

        int n = 600;
        try {
            n = Integer.parseInt(args[0]);
        } catch (final Exception e) {
        }

        printColours();
        System.out.println();
        run(n, Colour.blue, Colour.red, Colour.yellow);
        run(n, Colour.blue, Colour.red, Colour.yellow, Colour.red, Colour.yellow,
               Colour.blue, Colour.red, Colour.yellow, Colour.red, Colour.blue);
    }

    private static final String[] NUMBERS = {
        "zero", "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine"
    };

    private static String getNumber(final int n) {
        final StringBuilder sb = new StringBuilder();
        final String nStr = String.valueOf(n);
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

    private static void printColours(final Colour c1, final Colour c2) {
        System.out.println(c1 + " + " + c2 + " -> " + doCompliment(c1, c2));
    }


}
