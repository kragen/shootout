#!/usr/bin/perl
# $Id: spellcheck.perl,v 1.1 2004-05-19 18:13:26 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

use strict;

# read dictionary
my %dict = ();
open(DICT, "<Usr.Dict.Words") or
    die "Error, unable to open Usr.Dict.Words\n";
while (<DICT>) {
    chomp;
    $dict{$_} = 1;
}
close(DICT);

while (<STDIN>) {
    chomp;
    print "$_\n" if (!$dict{$_});
}
