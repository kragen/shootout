/* 
 The Computer Language Shootout
 http://shootout.alioth.debian.org/
 #303302
 contributed by tt@kyon.de
 */
public final class message extends Thread {

	private static final int THREADS = 500;
	private static int msgCount;
	private static int max;
	private final message nextThread;
	private int[] messages = new int[1024]; // reasonably sized buffer
	private int todo;
	boolean waiting;

	public static void main(String args[]) {
		msgCount = Integer.parseInt(args[0]);
		max = msgCount * THREADS;
		message thread = null;
		for (int i = THREADS; --i >= 0;) {
			(thread = new message(thread)).start();
		}
		for (int i = msgCount; --i >= 0;) {
			thread.send(0);
		}
	}
	private message(message next) {
		nextThread = next;
	}
	public synchronized void run() {
		try {
			if (todo == 0) {
				waiting = true;
				wait();
			}
			if (nextThread != null) {
				pass();
			} else {
				add();
			}
		} catch (InterruptedException e) {
			// will not be thrown under any normal circumstances
			e.printStackTrace();
		}
	}
	private void pass() throws InterruptedException {
		for (;;) {
			int done = todo;
			int[] m = messages;
			do {
				nextThread.send(m[--done] + 1);
			} while (done != 0);
			todo = 0;
			do {
				// no unsynchronized todos left
				waiting = true;
				wait();
			} while (todo == 0);
		}
	}
	private void add() throws InterruptedException {
		int sum = 0;
		for (;;) {
			int done = todo;
			int[] m = messages;
			do {
				sum += m[--done] + 1;
			} while (done != 0);
			todo = 0;
			do {
				// no unsynchronized todos left
				if (sum == max) {
					System.out.println(sum);
					System.exit(0);
				}
				waiting = true;
				wait();
			} while (todo == 0);
		}
	}
	private synchronized void send(int message) {
		int[] m = messages;
		int l = m.length;
		if (todo == l) {
			int[] n = new int[l << 2];
			System.arraycopy(m, 0, n, 0, l);
			messages = m = n;
		}
		m[todo++] = message;
		if (waiting) {
			// otherwise already notified
			waiting = false;
			notify();
		}
	}
}
