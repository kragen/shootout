#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: spellcheck.pike,v 1.1 2004-05-19 18:13:26 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

void main() {
    array(string) a = Stdio.read_file("Usr.Dict.Words")/"\n";
    mapping dictionary = mkmapping(a, allocate(sizeof(a), 1));
    while (string word = Stdio.stdin.gets()) {
	if (!dictionary[word]) write("%s\n", word);
    }
}
