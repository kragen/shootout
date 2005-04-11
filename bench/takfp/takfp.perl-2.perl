#!/usr/bin/perl -w 
# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# Perl version of floating point Tak function
# by Greg Buchholz

$n=shift;
print tak(3*$n, 2*$n, $n)."\n";

sub tak
{   
    my $x=shift; my $y=shift; my $z=shift;
    
    ($y >= $x) ? $z : tak(tak($x-1,$y,$z),tak($y-1,$z,$x),tak($z-1,$x,$y))
}
