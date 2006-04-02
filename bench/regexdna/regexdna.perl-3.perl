# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# contributed by Danny Sauer
# debugged by Josh Goldfoot
# modified by Thomas Nordlander

# regexp matches
my @variants = ('agggtaaa|tttaccct',
         '[cgt]gggtaaa|tttaccc[acg]',
         'a[act]ggtaaa|tttacc[agt]t',
         'ag[act]gtaaa|tttac[agt]ct',
         'agg[act]taaa|ttta[agt]cct',
         'aggg[acg]aaa|ttt[cgt]ccct',
         'agggt[cgt]aa|tt[acg]accct',
         'agggta[cgt]a|t[acg]taccct',
         'agggtaa[cgt]|[acg]ttaccct',
        );

# build regexp searchstring from list above
my $varstr = "(";
$varstr .= $_."|" foreach @variants;
$varstr = substr ($varstr, 0, -1).")";


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
# regexp searchstring derived from list above
my $iubstr = "(b|d|h|k|m|n|r|s|v|w|y)";


# sequence descriptions start with > and coments start with ;
#my $stuffToRemove = qr/^[>;].*$|[\r\n]/m;
my $stuffToRemove = qr/^>.*$|\n/m; # no comments, *nix-format test file...

# read in file
undef $/;
my $contents = <STDIN>;
my $initialLength = length $contents;

# remove things
$contents =~ s/$stuffToRemove//og;
my $codeLength = length $contents;

# Get regexp counts
my @counts = ($contents =~ /$varstr/g);
# Group matches according to @variants
foreach my $match (@counts) {
    foreach my $var (@variants) {
        $results{$var}++ if $match =~ $var;
    }
}

# print counts
print $_." ".int ($results{$_})."\n" foreach @variants;

# perform replacements
$contents =~ s/$iubstr/$IUB{$1}/ig;

# print stats
print "\n",
      $initialLength, "\n",
      $codeLength, "\n",
      length($contents), "\n";

exit(0);
