#!/usr/bin/perl 
# $Id: ackermann.perl-2.perl,v 1.1 2004-11-10 06:09:46 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

use strict;
use integer;

# cheat by saving intermediate values (memoizing)
# Warning!  This won't work for anything more than
# small values of M, N :-)
my @ACK = ();

sub Ack {
    my($M, $N) = @_;
    return( $ACK[$M][$N] ) if ($ACK[$M][$N]);
    return( $ACK[$M][$N] = $N + 1 ) if ($M == 0);
    return( $ACK[$M][$N] = Ack($M - 1, 1) ) if ($N == 0);
    return( $ACK[$M][$N] = Ack($M - 1, Ack($M, $N - 1)) );
}

my $NUM = $ARGV[0];
$NUM = 1 if ($NUM < 1);
my $ack = Ack(3, $NUM);
print "Ack(3,$NUM): $ack\n";
