#!/usr/bin/env perl
# $$Id: knucleotide.perl-3.perl,v 1.1 2006-02-21 17:43:25 igouy-guest Exp $
#  The Computer Language Shootout
#  http://shootout.alioth.debian.org/
#  contributed by Karl FORNER
# (borrowed fasta loading routine from Kjetil Skotheim, 2005-11-29)

my @nuc = ([qw{A C G T}],[qw(AA AC AG AT CA CC CG CT GA GC GG GT TA TC TG TT)]);
my ($sequence);
$/ = ">";
/^THREE/i and $sequence = uc(join "", grep !/^(?:;|THREE)/, split /\n+/) while <STDIN>;

my ($l,%h,@all,$key,$value,$sum) = (length $sequence);
keys %h = $l;
foreach my $frame (1,2) {
  update_hash_for_frame($frame);
  $sum = $l - $frame + 1;
  @all = sort { $b->[1] <=> $a->[1] || $a->[0] <=> $b->[0] } 
    map { [$_,sprintf("%.3f",($h{$_}||0)*100/$sum)] } @{$nuc[$frame-1]};
  print join("\n",map { join(' ',@$_) } @all),"\n\n";
}

foreach my $s (qw(GGT GGTA GGTATT GGTATTTTAATT GGTATTTTAATTTATAGT)) {
  update_hash_for_frame(length($s));
  print join("\t",($h{$s}||0),$s),"\n";
}

sub update_hash_for_frame {
  my $frame = $_[0];
  $h{substr($sequence,$_,$frame)}++ foreach (0..($l - $frame));
}






