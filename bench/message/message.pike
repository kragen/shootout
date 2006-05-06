// The Computer Language Shootout
// http://shootout.alioth.debian.org/
// contributed by Adam Montague

void main(int argc, array(string) argv)
{
	int sum;
	Thread.Fifo fifo = Thread.Fifo();
	Thread.Fifo in = fifo;
	Thread.Fifo out = Thread.Fifo();
	for (int i = 0; i < 500; i++) {
		Thread.Thread(work, i, in, out);
		in = out;
		out = Thread.Fifo();
	}
	for (int i = 0; i < (int)argv[1]; i++) {
		fifo->write(0);
		sum += in->read();
	}
	write("%d\n", sum);
}

void work(int thread, Thread.Fifo in, Thread.Fifo out)
{
	for (;;) {
		out->write(in->read() + 1);
	}
}
