#!/usr/bin/pike
// -*- mode: pike -*- 
// $Id: prodcons.pike,v 1.2 2005-05-13 16:24:18 igouy-guest Exp $
// http://www.bagley.org/~doug/shootout/

inherit Thread.Condition: access;
inherit Thread.Mutex: mutex;
int data, consumed, produced, count;

void producer(int n) {
    for (int i=1; i<=n; i++) {
	object mtx = mutex::lock();
	while (count != 0) access::wait(mtx);
	data = i;
	count += 1;
	destruct(mtx);
	access::signal();
	produced += 1;
    }
}

void consumer(int n) {
    while (1) {
	object mtx = mutex::lock();
	while (count == 0) access::wait(mtx);
	int i = data;
	count -= 1;
	access::signal();
	destruct(mtx);
	consumed += 1;
	if (i == n) break;
    }
}

void main(int argc, array(string) argv) {
    int n = (int)argv[-1];
    if (n < 1) n = 1;
    data = consumed = produced = count = 0;
    thread_create(producer, n);
    consumer(n);
    write("%d %d\n", produced, consumed);
}
