#!/usr/bin/env perl
# $$Id: random.perl-2.perl,v 1.1 2006-01-18 16:26:48 igouy-guest Exp $
#  The Computer Language Shootout
#  http://shootout.alioth.debian.org/
#  contributed by Karl FORNER

my ($IM,$IA,$IC,$LAST) = (139968,3877,29573,42);

sub gen_random { 
  my ($n,$max) = @_;
  $LAST = ($LAST * $IA + $IC) % $IM while ($n-- );
  return $max * $LAST / $IM;
}

printf "%.9f\n", gen_random($ARGV[0] || 1, 100.0);
