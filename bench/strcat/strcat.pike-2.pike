#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: strcat.pike-2.pike,v 1.1 2004-11-10 06:44:59 bfulgham Exp $
// http://shootout.alioth.debian.org/

void main(int argc, array(string) argv)
{
    int n = (int)argv[-1];
    if (n < 1) n = 1;
      
    string str = "";
    for (int i=0; i<n; i++) {
	str += "hello\n";
    }
    write("%d\n", strlen(str));
}
