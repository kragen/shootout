/* 
 The Computer Language Shootout
 http://shootout.alioth.debian.org/

 contributed by tt@kyon.de
 modified by tt@kyon.de
 */
public final class message extends Thread {

	private static final int THREADS = 500;
	private static int msgCount;
	private final message nextThread;
	private int[] messages = new int[msgCount];
	private int todo;
	private boolean waiting;

	public static void main(String args[]) {
		msgCount = Integer.parseInt(args[0]);
		message thread = null;
		for (int i = THREADS; --i >= 0;) {
			(thread = new message(thread)).start();
		}
		synchronized (thread) {
			for (int i = msgCount; --i >= 0;) {
				thread.send(0);
			}
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
				waiting = false;
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
	private synchronized void pass() throws InterruptedException {
		int done = 0;
		for (;;) {
			synchronized (nextThread) {
				do {
					nextThread.send(messages[done++] + 1);
				} while (done < todo);
			}
			while (done == todo) {
				// no unsynchronized todos left
				waiting = true;
				wait();
				waiting = false;
			}
		}
	}
	private synchronized void add() throws InterruptedException {
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
	private void send(int message) {
		messages[todo++] = message;
		if (waiting) {
			notify();
		}
	}
}
