#!/usr/bin/env perl
# $$Id: random.perl-3.perl,v 1.1 2006-01-18 16:26:48 igouy-guest Exp $
#  The Computer Language Shootout
#    http://shootout.alioth.debian.org/
# BENCHMARK: random
#   contributed by Karl FORNER
use Inline 'C';
printf "%.9f\n", gen_random($ARGV[0] || 1,100.0);
__END__
__C__
#define IM 139968
#define IA 3877
#define IC 29573
double gen_random(int n,double max) {
    static long last = 42;
    while (n--) 
      last = (last * IA + IC) % IM;
    return( max * last / IM );
}

