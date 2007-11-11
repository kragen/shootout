/* The Computer Language Benchmarks Game
 http://shootout.alioth.debian.org/

 contributed by Klaus Friedel
 */

import java.util.concurrent.Exchanger;
import java.util.concurrent.atomic.AtomicInteger;

public class chameneos {
  enum Colour {
    RED, BLUE, YELLOW, FADED;

    public Colour complement(Colour other) {
      if (this == other) {
        return this;
      } else if (this == Colour.BLUE) {
        return other == Colour.RED ? Colour.YELLOW : Colour.RED;
      } else if (this == Colour.YELLOW) {
        return other == Colour.BLUE ? Colour.RED : Colour.BLUE;
      } else {
        return other == Colour.YELLOW ? Colour.BLUE : Colour.YELLOW;
      }
    }
  }

  class Creature extends Thread {
    private Colour colour;
    int count = 0;

    public Creature(Colour initialColour) {
      this.colour = initialColour;
    }

    public void run() {
      try {
        while (true) {
          Colour other = mp.meet(colour);
          colour = colour.complement(other);
          count++;
        }
      } catch (InterruptedException e) {
        colour = Colour.FADED;
      }
    }
  }

  static class MeetingPlace {
    final Exchanger<Colour> exchanger = new Exchanger<Colour>();
    final AtomicInteger meetingsLeft;

    public MeetingPlace(int meetings) {
      this.meetingsLeft = new AtomicInteger(meetings);
    }

    public Colour meet(Colour myColor) throws InterruptedException {
      if (meetingsLeft.decrementAndGet() < 0) throw new InterruptedException();
      return exchanger.exchange(myColor);
    }
  }

  final MeetingPlace mp;
  final Creature[] creatures;

  public chameneos(int meetings) {
    this.mp = new MeetingPlace(meetings);
    this.creatures = new Creature[]{
        new Creature(Colour.BLUE),
        new Creature(Colour.RED),
        new Creature(Colour.YELLOW),
        new Creature(Colour.BLUE)
    };
  }

  public void run() throws InterruptedException {
    for (Creature creature : creatures) {
      creature.start();
    }
    int meetings = 0;
    for (Creature creature : creatures) {
      creature.join();
      meetings += creature.count;
    }
    System.out.println(meetings);
  }

  public static void main(String[] args) throws Exception {
    int n = 5000000;
    if (args.length >= 1) n = Integer.parseInt(args[0]);
    chameneos cham = new chameneos(n);
    cham.run();
  }
}