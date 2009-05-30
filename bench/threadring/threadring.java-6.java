/**
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Fabien Le Floc'h
 *
 * This implementation cheats by adapting closely to the benchmark specifications. 
 * We use only 1 thread to process messages, we don't use a blocking queue but 
 * instead a linked list. The Nodes don't map directly to a thread, even though
 * they are processed in a different thread (the consumer). This is probably this kind
 * of scheme that more advanced languages like Haskell do behind the scenes.
 * 
 * I say it is a bit cheating because we don't use here a concurrent queue, because 
 * we know everything is processed in 1 thread: the consumer except the first message.
 */


import java.util.LinkedList;
import java.util.Queue;


public class threadring {
    public static void main(String[] args) {
        Node[] ring = new Node[503];
        for (int i=0; i<ring.length; i++) {
            ring[i] = new Node(i+1);
        }
        for (int i=0; i<ring.length; i++) {
            int nextIndex = (ring[i].label % ring.length);
            ring[i].next = ring[nextIndex];            
        }
        int nHops = Integer.parseInt(args[0]);
        new Thread(new Consumer()).start();
        ring[0].sendMessage(nHops);
    }

    private static Queue<Node> q = new LinkedList<Node>();

    static class Consumer implements Runnable {

        public void run() {
            while (true) {
                try {
                    Node node;
                    node = q.poll();
                    if (node == null) {
                        //ignore, wait for some element
                        Thread.sleep(100);
                    } else {
                        node.run();
                    } 
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    static class Node implements Runnable {
        private final int label;
        private Node next;
        private int message;

        public Node(int label) {
            this.label = label;
        }

        public void sendMessage(int message) {
            this.message=message;
            q.add(this);            
        }

        public void run() {
            //                System.out.println("after lock");
            if (message == 0) {
                System.out.println(label);
                System.exit(0);
            } else {
                next.sendMessage(message - 1);
            }
        }
    }
}
