/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Keenan Tims */

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class chameneos {

	private MeetingPlace mp;

	public static final Colour[] COLOURS = Colour.values();

	private Creature[] creatures = new Creature[COLOURS.length];

	public enum Colour {
		RED, BLUE, YELLOW, FADED
	}

	public class Creature extends Thread {

		private MeetingPlace mp;

		private Colour colour;

		private int met = 0;

		public Creature(Colour c, MeetingPlace mp) {
			this.colour = c;
			this.mp = mp;
		}

		public void run() {
			while (colour != Colour.FADED)
				try {
					meet();
				} catch (Exception e) {
					System.exit(-1);
				}
		}

		public synchronized void meet() {
			Colour other;
			try {
				other = mp.meet(colour);
			} catch (Exception e) {
				e.printStackTrace();
				System.exit(-1);
				return;
			}
			if (other == Colour.FADED)
				colour = Colour.FADED;
			else {
				met++;
				colour = complement(other);
			}
		}

		private Colour complement(Colour other) {
			if (colour == other)
				return colour;
			switch (colour) {
			case BLUE:
				return other == Colour.RED ? Colour.YELLOW : Colour.RED;
			case RED:
				return other == Colour.BLUE ? Colour.YELLOW : Colour.BLUE;
			case YELLOW:
				return other == Colour.BLUE ? Colour.RED : Colour.BLUE;
			default:
				return colour;
			}
		}

		public int getCreaturesMet() {
			return met;
		}

		public Colour getColour() {
			return colour;
		}
	}

	public class MeetingPlace {
		Colour first, second;

		boolean firstCall = true, mustWait = false;

		int n;

		public MeetingPlace(int n) {
			this.n = n;
		}

		public Colour meet(Colour me) throws Exception {
			Colour other;

			while (mustWait) {
				Thread.yield();
			}

			if (firstCall) {
				if (n-- > 0) {
					first = me;
					firstCall = false;

					while (!firstCall) {
						Thread.yield();
					}
					mustWait = false;
					other = second;
				} else
					other = Colour.FADED;
			} else {
				second = me;
				other = first;
				firstCall = true;
				mustWait = true;
			}

			return other;
		}
	}

	public chameneos(int n) throws InterruptedException {
		int meetings = 0;
		mp = new MeetingPlace(n);

		for (int i = 0; i < COLOURS.length; i++) {
			creatures[i] = new Creature(COLOURS[i], mp);
			creatures[i].start();
		}

		// wait for all threads to complete
		for (int i = 0; i < COLOURS.length; i++)
			creatures[i].join();

		// sum all the meetings
		for (int i = 0; i < COLOURS.length; i++)
			meetings += creatures[i].getCreaturesMet();

		System.out.println(meetings);
	}

	public static void main(String[] args) throws Exception {
		if (args.length < 1)
			throw new IllegalArgumentException();
		new chameneos(Integer.parseInt(args[0]));
	}
}
//
