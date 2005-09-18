#!/bin/env groovy
/*
	$Id: tcpecho.groovy,v 1.1 2005-09-18 05:01:25 igouy-guest Exp $

	The Great Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
	modified by 

	Note: we're thinking about a better way to start client & server within our measurement framework.

	Each program (M = 6400, REPLY_SIZE = 64) should

    * open a TCP/IP socket
    * fork a client process that connects back to the socket
          o M*N times the client process should
                + write a request to the socket
                + read a reply from the socket
                + count the replies, and sum the bytes in the replies
          o close the socket
          o print the count and sum
    * the server process should
          o read a request from the socket
          o write a reply to the socket

	Each program should leave the sockets available for immediate reuse.

	Correct output N = 10 is:

	replies: 64000  bytes: 4096000


	The only difference between the tcp-echo, tcp-request-reply, and tcp-stream programs, should be the values for M and REPLY_SIZE.
*/

class Server implements Runnable {

	public port, reply

	public void run() {
		def replyBuffer = java.nio.ByteBuffer.wrap(reply.getBytes())
		def serverBuffer = java.nio.ByteBuffer.allocateDirect(reply.size())

		def ssc = java.nio.channels.ServerSocketChannel.open()
		ssc.socket().bind(new InetSocketAddress(InetAddress.getLocalHost(), port))
		def socketChannel = ssc.accept()

		while (true) {
   	     	serverBuffer.clear();
        	if (socketChannel.read(serverBuffer) == -1)  break

			socketChannel.write(replyBuffer)
			replyBuffer.rewind()
        }
		socketChannel.close()
	}
}

class Client implements Runnable {

	public N, M, port, request

	public void run() {
		def requestBuffer = java.nio.ByteBuffer.wrap(request.getBytes())
		def replyBuffer = java.nio.ByteBuffer.allocateDirect(64)

		def channel = java.nio.channels.SocketChannel.open()
		channel.connect(new InetSocketAddress(InetAddress.getLocalHost(), port))

        def replies = bytes = 0
        (1..N*M).each() {
			requestBuffer.rewind()
            channel.write(requestBuffer)
			replyBuffer.clear()
            bytes += channel.read(replyBuffer)
            replies++
        }
        channel.close()
        println "replies: ${replies}\tbytes: ${bytes}"
	}
}


def N = (args.length == 0 ? 10 : args[0])
def server = new Server(port:11000, reply: 'x'*64)
new Thread(server).start()

def client = new Client(N:N, M:6400, port:11000, request: 'x'*64)
new Thread(client).start()

// EOF

