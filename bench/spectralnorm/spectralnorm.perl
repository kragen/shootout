# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# Contributed by Markus Peter
# Modified by Daniel Green

use warnings;
use strict;

sub A {
    return 1.0 / ( ( $_[0] + $_[1] ) * ( $_[0] + $_[1] + 1 ) / 2 + $_[0] + 1 );
}

sub Av {
    my ( $u ) = @_;
    my $len = $#$u;
    my @v = ( 0 ) x ( $len+1 );
    for my $i ( 0..$len ) {
        for my $j ( 0..$len ) {
            $v[$i] += A( $i, $j ) * $u->[$j];
        }
    }
    return \@v;
}

sub Atv {
    my ( $u ) = @_;
    my $len = $#$u;
    my @v = ( 0 ) x ( $len+1 );
    for my $i ( 0..$len ) {
        for my $j ( 0..$len ) {
            $v[$i] += A( $j, $i ) * $u->[$j];
        }
    }
    return \@v;
}

sub AtAv {
    return Atv( Av( $_[0] ) );
}

my $N = @ARGV ? $ARGV[0] : 500;

my $v;
my $u = [ ( 1 ) x $N ];
for my $i ( 0..9 ) {
    $v = AtAv( $u );
    $u = AtAv( $v );
}

my ($vBv, $vv) = (0, 0);
for my $i ( 0..$N-1 ) {
    $vBv += $u->[$i] * $v->[$i];
    $vv += $v->[$i] ** 2;
}
printf( "%0.9f\n", sqrt( $vBv / $vv ) );

