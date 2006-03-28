/* 
 The Computer Language Shootout
 http://shootout.alioth.debian.org/

 contributed by tt@kyon.de
 modified by tt@kyon.de
 */
public final class CheapConcurrency_Wait extends Thread {

	private static final int THREADS = 500;
	private static int msgCount;
	private final CheapConcurrency_Wait nextThread;
	private int[] messages = new int[msgCount];
	private int todo;
	private boolean waiting;

	public static void main(String args[]) {
		msgCount = Integer.parseInt(args[0]);
		CheapConcurrency_Wait thread = null;
		for (int i = THREADS; --i >= 0;) {
			(thread = new CheapConcurrency_Wait(thread)).start();
		}
		for (int i = msgCount; --i >= 0;) {
			thread.send(0);
		}
	}
	private CheapConcurrency_Wait(CheapConcurrency_Wait next) {
		nextThread = next;
	}
	public synchronized void run() {
		try {
			if (todo == 0) {
				waiting = true;
				wait();
				waiting = false;
			}
			if (nextThread != null) {
				pass();
			} else {
				add();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private synchronized void pass() throws Exception {
		int done = 0;
		for (;;) {
			do {
				nextThread.send(messages[done++] + 1);
			} while (done < todo);
			while (done == todo) {
				// no unsynchronized todos left
				waiting = true;
				wait();
				waiting = false;
			}
		}
	}
	private synchronized void add() throws Exception {
		int sum = 0;
		int done = 0;
		for (;;) {
			do {
				sum += messages[done++] + 1;
			} while (done < todo);
			while (done == todo) {
				// no unsynchronized todos left
				if (done == msgCount) {
					System.out.println(sum);
					System.exit(0);
				}
				waiting = true;
				wait();
				waiting = false;
			}
		}
	}
	private synchronized void send(int message) {
		messages[todo++] = message;
		if (waiting) {
			notify();
		}
	}
}
