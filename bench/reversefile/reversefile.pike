#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: reversefile.pike,v 1.1 2004-05-19 18:12:18 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Fredrik Noring

void main() { write((reverse(Stdio.stdin.read()/"\n")*"\n")[1..]+"\n"); }
