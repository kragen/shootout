#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: hash2.pike,v 1.1 2004-05-19 18:10:02 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

void main(int argc, array(string) argv) {
    int n = (int)argv[-1];
    if (n < 1) n = 1;
      
    mapping(string:int) hash1 = ([]);
    mapping(string:int) hash2 = ([]);
    for (int i=0; i<10000; i++)
	hash1["foo_" + i] = i;
    for (int i=0; i<n; i++) {
	foreach (indices(hash1), string k) {
	    hash2[k] += hash1[k];
	}
    }
    write("%d %d %d %d\n", hash1["foo_1"], hash1["foo_9999"],
	  hash2["foo_1"], hash2["foo_9999"]);
}
