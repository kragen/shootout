#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: sumcol.pike-2.pike,v 1.1 2004-11-10 07:07:16 bfulgham Exp $
// http://shootout.alioth.debian.org/
// from: Henrik Grubbström

void main()
{
    int sum = 0;
    string data = "";

    while((data += Stdio.stdin.read(4096)) != "")
    {
        array(string) values = data/"\n";
        sum = `+(sum, @((array(int))values[..sizeof(values)-2]));
        data = values[-1];
    }

    write("%0d\n", sum);
}
