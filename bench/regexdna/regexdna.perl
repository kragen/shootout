#!/usr/bin/perl
#
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# contributed by Danny Sauer
# 

# regexp matches
my @variants = map(
    ([$_, qr/$_/i]),
    ('agggtaaa|tttaccct',
     '[cgt]gggtaaa|tttaccc[acg]',
     'a[act]ggtaaa|tttacc[agt]t',
     'ag[act]gtaaa|tttac[agt]ct',
     'agg[act]taaa|ttta[agt]cct',
     'aggg[acg]aaa|ttt[cgt]ccct',
     'agggt[cgt]aa|tt[acg]accct',
     'agggta[cgt]a|t[acg]taccct',
     'agggtaa[cgt]|[acg]ttaccct',
    )
);

# IUB replacements
my %IUB = (
    'B' => '(c|g|t)',
    'D' => '(a|g|t)',
    'H' => '(a|c|t)',
    'K' => '(g|t)',
    'M' => '(a|c)',
    'N' => '(a|c|g|t)',
    'R' => '(a|g)',
    'S' => '(c|g)',
    'V' => '(a|c|g)',
    'W' => '(a|t)',
    'Y' => '(c|t)',
);

# sequence descriptions start with > and coments start with ;
#my $stuffToRemove = qr/^[>;].*$|[\r\n]/m;
my $stuffToRemove = qr/^>.*$|\n/m; # no comments, *nix-format test file...

# read in file
undef $/;
my $contents = <>;
my $initialLength = length($contents);

# remove things
$contents =~ s/$stuffToRemove//go;
my $codeLength = length($contents);

# do regexp counts
study($contents);
foreach (@variants){
    print $_->[0], ' ', scalar @{[$contents =~ m/$_->[1]/g]}, "\n";
}

# do replacements
foreach (keys(%IUB)){
    $contents =~ s/$_/$IUB{$_}/ig;
}

print "\n", 
      $initialLength, "\n", 
      $codeLength, "\n", 
      length($contents), "\n";

exit(0);
