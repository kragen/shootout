# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# Contributed by Paul Liebert

use integer;
use 5.010;

$/ = "\n";
$_ = <>;
$/ = "\n>";
print;

my( $i, $len );
while(<>) {

    s/ > \z //x;
    tr/\n//d;

    $_ = reverse $_;
    tr{wsatugcyrkmbdhvnATUGCYRKMBDHVN}
      {WSTAACGRYMKVHDBNTAACGRYMKVHDBN};

    $len = length;

    for( my $i=0;   $i<$len;   $i+=60 ) { say substr $_, $i, 60; }

    $/ = "\n";
    $_ = <>;
    $/ = "\n>";
    last if not defined;

    print '>', $_;
}

