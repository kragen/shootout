#!/usr/bin/perl
# $Id: showsrc.cgi,v 1.1 2004-05-19 18:15:15 bfulgham Exp $

use strict;
use CGI qw(-oldstyle_urls);
use HTML::Entities ();

our $q = new CGI;
our $srcfile = "../bench/" . $q->param('src');

print $q->header;
if (open(F, "<$srcfile")) {
    print HTML::Entities::encode(join('', <F>));
    close(F);
} else {
    my $pwd = `pwd`;
    print "$srcfile not found. ($pwd)\n";
}
