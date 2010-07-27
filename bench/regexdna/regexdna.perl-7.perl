# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# contributed by Danny Sauer
# completely rewritten and cleaned up for speed and fun by Mirco Wahab
# improved STDIN read, regex clean up by Jake Berner
# more speed and multithreading by Andrew Rodland
# moved alternation out of the regexes into the program logic for speed by Daniel Green

use strict;
use warnings;

my $l_file  = -s STDIN;
my $content; read STDIN, $content, $l_file;
# this is significantly faster than using <> in this case

$content =~ s/^>.*//mg;
$content =~ tr/\n//d;
my $l_code  =  length $content;

my @seq = ( ['agggtaaa', 'tttaccct'],
        ['[cgt]gggtaaa', 'tttaccc[acg]'],
        ['a[act]ggtaaa', 'tttacc[agt]t'],
        ['ag[act]gtaaa', 'tttac[agt]ct'],
        ['agg[act]taaa', 'ttta[agt]cct'],
        ['aggg[acg]aaa', 'ttt[cgt]ccct'],
        ['agggt[cgt]aa', 'tt[acg]accct'],
        ['agggta[cgt]a', 't[acg]taccct'],
        ['agggtaa[cgt]', '[acg]ttaccct'] );

my @procs;
for my $s (@seq) {
  my ($pat_l, $pat_r) = (qr/$s->[0]/, qr/$s->[1]/);
  my $pid = open my $fh, '-|';
  defined $pid or die "Error creating process";
  unless ($pid) {
    my $cnt = 0;
    ++$cnt while $content =~ /$pat_l/gi;
    ++$cnt while $content =~ /$pat_r/gi;
    print "$s->[0]|$s->[1] $cnt\n";
    exit 0;
  }
  push @procs, $fh;
}

for my $proc (@procs) {
  print <$proc>;
  close $proc;
}

my %iub = (         B => '(c|g|t)',  D => '(a|g|t)',
  H => '(a|c|t)',   K => '(g|t)',    M => '(a|c)',
  N => '(a|c|g|t)', R => '(a|g)',    S => '(c|g)',
  V => '(a|c|g)',   W => '(a|t)',    Y => '(c|t)' );

# We could cheat here by using $& in the subst and doing it inside a string
# eval to "hide" the fact that we're using $& from the rest of the code... but
# it's only worth 0.4 seconds on my machine.
my $findiub = '(['.(join '', keys %iub).'])';

$content =~ s/$findiub/$iub{$1}/g;

printf "\n%d\n%d\n%d\n", $l_file, $l_code, length $content;
