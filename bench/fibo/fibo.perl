#!/usr/bin/perl
# $Id: fibo.perl,v 1.4 2005-04-04 14:56:35 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

use strict;
use integer;

# from Leif Stensson
sub fib {
    return $_[0] < 2 ? $_[0] : fib($_[0]-2) + fib($_[0]-1);
}

my $N = ($ARGV[0] < 1) ? 1 : $ARGV[0];
my $fib = fib($N);
print "$fib\n";
