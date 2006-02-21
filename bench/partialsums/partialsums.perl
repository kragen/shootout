#!/usr/bin/perl

# Copyright (C) 2006  Joshua Hoblitt
#
# $Id: partialsums.perl,v 1.1 2006-02-21 17:43:25 igouy-guest Exp $

# This is a direct Perl translation of the C implimentation of partial-sums
# contributed by Mike Pall.  It's likely that in Perl this would perform better
# if implimented in just two loops.  One where k = 0..n and one where k = 1..n.

use strict;
use warnings;

# $VERSION = 1.0;

my ($sum, $k);
my $n = shift || 2_500_000;

$sum = 0;
for ($k = 0; $k <= $n; $k++) {
    $sum += (2 / 3)**($k);
}
printf("%.9f\t(2/3)^k\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n; $k++) {
    $sum += 1 / sqrt($k);
}
printf("%.9f\tk^-0.5\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n; $k++) {
    $sum += 1 / ($k * ($k + 1));
}
printf("%.9f\t1/k(k+1)\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n; $k++) {
    my $sink = sin($k);
    $sum += 1 / ($k * $k *$k * $sink * $sink);
}
printf("%.9f\tFlint Hills\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n; $k++) {
    my $cosk = cos($k);
    $sum += 1 / (($k * $k) * $k * $cosk * $cosk);
}
printf("%.9f\tCookson Hills\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n; $k++) {
    $sum += 1 / $k;
}
printf("%.9f\tHarmonic\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n; $k++) {
    $sum += 1.0 / ($k * $k);
}
printf("%.9f\tRiemann Zeta\n", $sum);

$sum = 0;
for ($k = 1; $k <= $n -1; $k += 2) {
    $sum += 1 / $k;
}
for ($k = 2; $k <= $n; $k += 2) {
    $sum -= 1.0/$k;
}
printf("%.9f\tAlternating Harmonic\n", $sum);

$sum = 0.0;
for ($k = 1; $k <= 2 * $n -1; $k += 4) {
    $sum += 1 / $k;
}
for ($k = 3; $k <= 2 * $n; $k += 4) {
    $sum -= 1 / $k;
}
printf("%.9f\tGregory\n", $sum);
