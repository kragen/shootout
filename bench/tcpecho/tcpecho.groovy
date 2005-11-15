/*
	The Computer Language Shootout
	http://shootout.alioth.debian.org/

	contributed by Jochen Hinrichsen
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

