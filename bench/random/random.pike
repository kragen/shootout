#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: random.pike,v 1.1 2004-05-19 18:11:16 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

int IM = 139968;
int IA = 3877;
int IC = 29573;

int last = 42;

float
gen_random(float max) { return(max * (last = (last * IA + IC) % IM) / IM); }

int
main(int argc, array(string) argv) {
    int N = ((int)argv[-1] || 1) - 1;
    while (N--) {
	gen_random(100.0);
    }
    write("%.9f\n", gen_random(100.0));
    return(0);
}

