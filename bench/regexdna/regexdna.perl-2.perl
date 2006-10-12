# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# contributed by Danny Sauer
# completely rewritten and
# cleaned up for speed and fun by
# Mirco Wahab (wahab@chemie.uni-halle.de)

use re 'eval';
$content =  do { local $/; <STDIN> };
$l_file  =  length $content;
$dispose =  qr/^>.*$|\n/m;
$content =~ s/$dispose//g;
$l_code  =  length $content;

@seq = qw( agggtaaa|tttaccct
       [cgt]gggtaaa|tttaccc[acg]
       a[act]ggtaaa|tttacc[agt]t
       ag[act]gtaaa|tttac[agt]ct
       agg[act]taaa|ttta[agt]cct
       aggg[acg]aaa|ttt[cgt]ccct
       agggt[cgt]aa|tt[acg]accct
       agggta[cgt]a|t[acg]taccct
       agggtaa[cgt]|[acg]ttaccct );

@cnt = (0) x @seq;
$reg = join '', map "(?:($seq[$_])(?{++\$cnt[$_]}))|", 0..$#seq;
chop $reg;

1 while $content =~ /$reg/ogi;
printf "$seq[$_] $cnt[$_]\n" for 0..$#seq;

%iub = (            B => '(c|g|t)',  D => '(a|g|t)',
  H => '(a|c|t)',   K => '(g|t)',    M => '(a|c)',
  N => '(a|c|g|t)', R => '(a|g)',    S => '(c|g)',
  V => '(a|c|g)',   W => '(a|t)',    Y => '(c|t)' );
  
my $findiub = '(['.(join '', keys %iub).'])';

1 while $content =~ s/$findiub/$iub{$1}/og;
printf "\n%d\n%d\n%d\n", $l_file, $l_code, length $content;
