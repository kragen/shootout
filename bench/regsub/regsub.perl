#!/usr/bin/perl
# $Id: regsub.perl,v 1.1 2004-05-19 18:11:33 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# copy text to tmp
# regsub doubled words with markup?

use strict;

sub main {
    my $n = ($ARGV[0] > 0) ? $ARGV[0] : 1;
    my $i = $n;
    while ($i--) {
	$text =~ s///g;
    }
}
