#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: regexmatch.pike,v 1.1 2004-05-19 18:11:27 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Fredrik Noring

constant area = "([0-9][0-9][0-9]|\\([0-9][0-9][0-9]\\))";
constant exch = "([0-9][0-9][0-9])";
constant last = "([0-9][0-9][0-9][0-9])";

void main(int argc, array(string) argv)
{
    Regexp r = Regexp("^[^0-9\\(]*"+area+" "+exch+"[ -]"+last+"[^0-9]*$");
    array(string) phones = Stdio.stdin->read()/"\n";
    int n = (int)argv[-1];
    int count = 0;
      
    while(n--)
	foreach(phones, string phone)
	    if(array(string) parts = r->split(phone))
		if(n == 0)
		    if(parts[0][0] == '(')
			write("%d: %s %s-%s\n", ++count, @parts);
		    else
			write("%d: (%s) %s-%s\n", ++count, @parts);
}
