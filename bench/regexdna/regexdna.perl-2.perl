# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# contributed by Danny Sauer
# completely rewritten and cleaned up
# for speed and fun by Mirco Wahab

use strict;
use warnings;
use re 'eval';

my $content = do { local $/; <> };
my $l_file  = length $content;

my $pullcomments = qr/^>.*$|\n/m;
$content    =~ s/$pullcomments//g;
my $l_code  = length $content;

my @motifs = (                  'agggtaaa|tttaccct',       # the motifs from
 '[cgt]gggtaaa|tttaccc[acg]',   'a[act]ggtaaa|tttacc[agt]t',# this array will
 'ag[act]gtaaa|tttac[agt]ct',   'agg[act]taaa|ttta[agt]cct', # be translated
 'aggg[acg]aaa|ttt[cgt]ccct',   'agggt[cgt]aa|tt[acg]accct', # to a alterna-
 'agggta[cgt]a|t[acg]taccct',   'agggtaa[cgt]|[acg]ttaccct' );# ting regex,
                                                             # as shown in
my @counter = (0) x @motifs;                                # the TCL version;
my $find_em = join "\n", map                               # In Perl, this
              sprintf( "%s(?:%s)(?{ \$counter[%d]++; })",  # works too ...
              ($_?'|':''), $motifs[$_], $_), 0..$#motifs;  #
                                                           # => find & count
1 while $content =~ /$find_em/gxi;                          # occuring motifs
printf "%s %d\n", $motifs[$_], $counter[$_] for 0..$#motifs; # and print 'em

my %iub = (
 'B'=>'(c|g|t)', 'D'=>'(a|g|t)', 'H' => '(a|c|t)',
 'K'=>'(g|t)',   'M'=>'(a|c)',   'N' => '(a|c|g|t)',
 'R'=>'(a|g)',   'S'=>'(c|g)',   'V' => '(a|c|g)',
 'W'=>'(a|t)',   'Y'=>'(c|t)'  );
                                                             # replace some
$content =~ s/$_/$iub{$_}/gi for (keys %iub);                # codes by others
printf "\n%d\n%d\n%d\n", $l_file, $l_code, length($content); # and print 'em

