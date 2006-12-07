/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by James McIlree
   modified by Dimitar Dimitrov
*/

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ArrayBlockingQueue;


public class message implements Runnable {
    private static final int NUMBER_OF_THREADS = 500;
    private static final double QUEUE_BUFFER_RATIO = Integer.getInteger("bufferPct", 100) / 100.0;

    private final BlockingQueue<Integer> queue;
    private final message next;

    message(message next, int queueSize) {
        this.queue = new ArrayBlockingQueue<Integer>(queueSize);
        this.next = next;
    }

    public void run() {
        if (next==null)  return;
        try {
            while (true) {
                next.queue.put(this.queue.take() + 1);
            }
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String args[]) throws InterruptedException {
        int messagesCount = Integer.parseInt(args[0]);
        int queueSize = (int) (messagesCount * QUEUE_BUFFER_RATIO);

        message first = new message(null, queueSize);
        message last = first;
        for (int i = 0; i < NUMBER_OF_THREADS-1; i++) {
            last = new message(last, queueSize);
            Thread thread = new Thread(last, "Worker-" + i);
            thread.setDaemon(true);
            thread.start();
        }

        for (int j = 0; j < messagesCount; j++) {
            last.queue.put(1);
        }

        int sum = 0;
        while (sum < NUMBER_OF_THREADS * messagesCount) {
            sum += first.queue.take();
        }

        System.out.println(sum);
    }
}
