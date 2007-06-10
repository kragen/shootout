/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
   contributed by Brian Schlining
*/

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ArrayBlockingQueue;

def NUMBER_OF_THREADS = 500
def QUEUE_BUFFER_RATIO = Integer.getInteger("bufferPct", 100) / 100.0

int messagesCount = Integer.parseInt(args[0])
int queueSize = messagesCount * QUEUE_BUFFER_RATIO

MyMessage first = new MyMessage(null, queueSize);
MyMessage last = first;
for (i in 0..<(NUMBER_OF_THREADS - 1)) {
    last = new MyMessage(last, queueSize)
    Thread thread = new Thread(last, "Worker-" + i)
    thread.setDaemon(true)
    thread.start()
}

for (j in 0..<messagesCount) {
    last.queue.put(1);
}

int sum = 0
while (sum < NUMBER_OF_THREADS * messagesCount) {
    sum += first.queue.take();
}

println(sum);

class MyMessage implements Runnable {
    

    final BlockingQueue queue
    final def next

    MyMessage(MyMessage next, int queueSize) {
        this.queue = new ArrayBlockingQueue(queueSize)
        this.next = next
    }

    void run() {
        if (next==null) { return }
        while (true) { next.queue.put(this.queue.take() + 1) }
    }

}
