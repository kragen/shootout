#!/usr/bin/perl
# $Id: fibo.perl-2.perl,v 1.1 2005-04-04 14:56:35 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

use strict;
use integer;

# Comments by Ernesto Hernandez-Novich
# If memoization were allowed, we could gain some benefit by
# using:
use Memoize;
memoize("fib");

# from Leif Stensson
sub fib {
    return $_[0] < 2 ? $_[0] : fib($_[0]-2) + fib($_[0]-1);
}

my $N = ($ARGV[0] < 1) ? 1 : $ARGV[0];
my $fib = fib($N);
print "$fib\n";
