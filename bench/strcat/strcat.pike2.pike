#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: strcat.pike2.pike,v 1.1 2004-05-19 18:13:35 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

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
