#!/usr/bin/perl
# $Id: fibo.perl,v 1.2 2004-06-30 07:28:57 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

use strict;
use integer;

# Comments by Ernesto Hernandez-Novich
# If memoization were allowed, we could gain some benefit by
# using:
# use Memoization;
# memoize("fib");

# from Leif Stensson
sub fib {
    return $_[0] < 2 ? 1 : fib($_[0]-2) + fib($_[0]-1);
}

my $N = ($ARGV[0] < 1) ? 1 : $ARGV[0];
my $fib = fib($N);
print "$fib\n";
