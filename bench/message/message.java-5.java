/* 
 The Computer Language Shootout
 http://shootout.alioth.debian.org/

 contributed by tt@kyon.de
 modified by tt@kyon.de
 */
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public final class message extends Thread {

	private static final int THREADS = 500;
	private static int msgCount;
	private final message nextThread;
	private int[] messages = new int[msgCount];
	private final ReentrantLock lock = new ReentrantLock();
	private final Condition notEmpty = lock.newCondition();
	private int todo;

	public static void main(String args[]) {
		msgCount = Integer.parseInt(args[0]);
		message thread = null;
		for (int i = THREADS; --i >= 0;) {
			(thread = new message(thread)).start();
		}
		try {
			for (int i = msgCount; --i >= 0;) {
				thread.send(0);
			}
		} catch (InterruptedException e) {
			// will not be thrown under any normal circumstances
			e.printStackTrace();
		}
	}
	private message(message next) {
		nextThread = next;
	}
	public void run() {
		try {
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
		int done = 0;
		lock.lock();
		try {
			for (;;) {
				while (done == todo) {
					notEmpty.await();
				}
				do {
					nextThread.send(messages[done++] + 1);
				} while (done < todo);
			}
		} finally {
			lock.unlock();
		}
	}
	private void add() throws InterruptedException {
		int sum = 0;
		int done = 0;
		lock.lock();
		try {
			for (;;) {
				while (done == todo) {
					notEmpty.await();
				}
				do {
					sum += messages[done++] + 1;
				} while (done < todo);
				if (done == msgCount) {
					System.out.println(sum);
					System.exit(0);
				}
			}
		} finally {
			lock.unlock();
		}
	}
	private void send(int message) throws InterruptedException {
		lock.lock();
		try {
			int i = todo;
			messages[i] = message;
			todo = i + 1;
			notEmpty.signal();
		} finally {
			lock.unlock();
		}
	}
}
