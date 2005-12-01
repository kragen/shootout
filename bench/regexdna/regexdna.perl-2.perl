#!/usr/bin/perl
#
# The Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Anon


my @var    =qw/   agggtaaa|tttaccct
                  [cgt]gggtaaa|tttaccc[acg]
                  a[act]ggtaaa|tttacc[agt]t
                  ag[act]gtaaa|tttac[agt]ct
                  agg[act]taaa|ttta[agt]cct
                  aggg[acg]aaa|ttt[cgt]ccct
                  agggt[cgt]aa|tt[acg]accct
                  agggta[cgt]a|t[acg]taccct
                  agggtaa[cgt]|[acg]ttaccct /;
my %subst  =qw/   B (c|g|t)  D (a|g|t)  H (a|c|t)  K (g|t)  M (a|c)  N (a|c|g|t)
                  R (a|g)    S (c|g)    V (a|c|g)  W (a|t)  Y (c|t)  /;
undef             $/;
my $seq    =      <STDIN>;
my $ilen   =      length $seq;
$seq       =~     s,(?:>.*)?\n,,g , study $seq;
my $clen   =      length $seq;
my $vars   =      join "|", @var;
my $seq2   =      join "|", $seq=~/(.{8}(?:$vars))/gi;
my $re     =      join "",  keys%subst;
$seq       =~     s,([$re]),$subst{$1},gi;
print             "$_ ".(@d=$seq2=~/($_)/gi)."\n" for @var;
print             "\n$ilen\n$clen\n".length($seq)."\n";
