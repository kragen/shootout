#!/usr/bin/perl
# $Id: reversefile.perl,v 1.1 2004-05-19 18:12:18 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

undef($/);
print join("\n", reverse split(/\n/, <STDIN>)),"\n";
