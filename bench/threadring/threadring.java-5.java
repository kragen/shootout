/**
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Birju Prajapati
 */

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class threadring {

    private static final int TOTAL_NODES = 503;
    private static final ExecutorService EXECUTOR = Executors.newFixedThreadPool(TOTAL_NODES);
    
    private static Node firstNode;
    private static Node lastNode;

    public static void main(String[] args) {
        firstNode = new Node(1);
        lastNode.next = firstNode;
        firstNode.push(Integer.parseInt(args[0]));
    }

    private static class Node implements Runnable {

        private final int id;
        private Node next;
        private int token;

        public Node(int id) {
            this.id = id;
            if (id++ == TOTAL_NODES) {
                lastNode = this;
            } else {
                next = new Node(id);
            }
        }

        private void push(int token) {
            this.token = token;
            EXECUTOR.execute(this);
        }

        public void run() {
            if (token-- != 0) {
                next.push(token);
            } else {
                System.out.println(id);
                System.exit(0);
            }
            
        }
    }
}


