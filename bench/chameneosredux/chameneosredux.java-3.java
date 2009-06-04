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
        printColours();
        System.out.println();

        int n = 6000000;
        if (args.length > 0)
            n = Integer.parseInt(args[0]);

        try {
            run(n, Colour.blue, Colour.red, Colour.yellow);
            run(n, Colour.blue, Colour.red, Colour.yellow, Colour.red,
                    Colour.yellow, Colour.blue, Colour.red, Colour.yellow,
                    Colour.red, Colour.blue);
        } catch (InterruptedException ie) {
        }
    }

    static void run(int n, Colour... colours) throws InterruptedException {
        meetings.set(n * 2);  // we multiply by two, because we count down twice for each meeting
        done = new Semaphore(-colours.length + 2);
        List<Creature> creatures = new ArrayList<Creature>();
        for (Colour c : colours) {
            System.out.format(" %s", c);
            Creature creature = new Creature(c);
            creature.start();
            creatures.add(creature);
        }
        System.out.println();
        done.acquire();
        while (done.availablePermits() <= 0)
            try {
                meetingPlace.exchange(Colour.blue, 1, TimeUnit.MILLISECONDS);
            } catch (TimeoutException e) {
            }
        int total = 0;
        for (Creature c : creatures) {
            System.out.println(c);
            total += c.count;
        }
        System.out.println(getNumber(total));
        System.out.println();       
    }

    static Exchanger<Colour> meetingPlace = new Exchanger<Colour>();
    static AtomicInteger meetings = new AtomicInteger();
    static Semaphore done;

    static class Creature extends Thread {
        private Colour colour;
        private int count;

        Creature(Colour colour) {
            this.colour = colour;
        }

        public String toString() {
            return String.format("%d%s", count, getNumber(0));
        }

        public void run() {
            try {
                while (meetings.getAndAdd(-BLOCK) >= 0)
                    block();
            } catch (InterruptedException ie) {
            } finally {
                done.release();
            }
        }

        private void block() throws InterruptedException {
            for (int i = 0; i < BLOCK; i++) {
                colour = doCompliment(colour, meetingPlace.exchange(colour));
            }
            count += BLOCK;
        }
    }

    enum Colour { blue, red, yellow; }

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

    private static void printColours() {
        for (Colour a : Colour.values())
            for (Colour b : Colour.values())
                System.out.format("%s + %s -> %s\n", a, b, doCompliment(a, b));
    }

    private static final String[] NUMBERS = { "zero", "one", "two", "three",
            "four", "five", "six", "seven", "eight", "nine" };

    private static String getNumber(int n) {
        String ret = " " + n;
        for (char i = '0'; i <= '9'; i++)
            ret = ret.replaceAll(""+i, NUMBERS[i-'0']+' ');
        return ret;
    }

}
