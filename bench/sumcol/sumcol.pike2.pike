#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: sumcol.pike2.pike,v 1.1 2004-05-19 18:13:44 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
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
