# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Dr.Ruud

use strict;
use warnings;

my $content; { local $/; $content = <STDIN> };
my $l_file  =  length $content;
   $content =~ s/^>.*$|\n//mg;
my $l_code  =  length $content;

my @seq = ( 'agggtaaa|tttaccct',
        '[cgt]gggtaaa|tttaccc[acg]',
        'a[act]ggtaaa|tttacc[agt]t',
        'ag[act]gtaaa|tttac[agt]ct',
        'agg[act]taaa|ttta[agt]cct',
        'aggg[acg]aaa|ttt[cgt]ccct',
        'agggt[cgt]aa|tt[acg]accct',
        'agggta[cgt]a|t[acg]taccct',
        'agggtaa[cgt]|[acg]ttaccct' );

print($_, ' ', scalar($content =~ /$_/g), "\n") for @seq;

my %iub = (       B => 'c|g|t',  D => 'a|g|t',
  H => 'a|c|t',   K => 'g|t',    M => 'a|c',
  N => 'a|c|g|t', R => 'a|g',    S => 'c|g',
  V => 'a|c|g',   W => 'a|t',    Y => 'c|t' );

my $findiub = '([' . (join '', keys %iub) . '])';
   $findiub = qr/$findiub/;

$content =~ s/$findiub/($iub{$1})/g;

printf "\n%d\n%d\n%d\n", $l_file, $l_code, length $content;
