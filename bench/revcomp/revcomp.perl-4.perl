# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# Contributed by Andrew Rodland

use strict;

sub print_reverse {
  while (my $chunk = substr $_[0], -60, 60, '') {
    print scalar reverse($chunk), "\n";
  }
}

my $data;

while (<STDIN>) {
  if (/^>/) {
    print_reverse $data;
    print;
  } else {
    chomp;
    tr{wsatugcyrkmbdhvnATUGCYRKMBDHVN}
      {WSTAACGRYMKVHDBNTAACGRYMKVHDBN};
    $data .= $_;
  }
}
print_reverse $data;
