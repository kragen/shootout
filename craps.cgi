#!/usr/bin/perl
# $Id: craps.cgi,v 1.1 2004-05-19 18:08:57 bfulgham Exp $

use strict;
use CGI qw(-oldstyle_urls);

our $q = new CGI;

my $MINWT = 0;
my $MAXWT = 5;

require './langs.pl';

my %WEIGHT =
    (
     'ackermann' => 1,
     'ary3' => 3,
     'echo' => 5,
     'except' => 1,
     'fibo' => 2,
     'hash' => 1,
     'hash2' => 4,
     'heapsort' => 4,
     'hello' => 1,
     'lists' => 3,
     'matrix' => 3,
     'methcall' => 5,
     'moments' => 2,
     'nestedloop' => 4,
     'objinst' => 5,
     'prodcons' => 1,
     'random' => 3,
     'regexmatch' => 4,
     'reversefile' => 4,
     'sieve' => 4,
     'spellcheck' => 4,
     'strcat' => 2,
     'sumcol' => 3,
     'wc' => 3,
     'wordfreq' => 5,
    );

sub main {
    print $q->header;
    my %weight = %WEIGHT;
    foreach my $test ($q->param) {
	my $w = $q->param($test);
	$w = $MAXWT if ($w > $MAXWT);
	$w = 1 if ($w < $MINWT);
	$weight{$test} = $w;
    }
    my %title = ();
    my %lang = ();
    my %missing = ();
    my %cpu = ();
    my %mem = ();
    my %loc = ();
    local *CT;
    open(CT, ".craps.table") or die "Error, no craps table";
    while (<CT>) {
	if (/^TITLE/) {
	    my($t, $_test, $_title) = split(/,/);
	    $title{$_test} = $_title;
	} elsif (/^LANG/) {
	    my($t, $_lang, $_impl, $_missing) = split(/,/);
	    $lang{$_impl} = $_lang;
	    $missing{$_impl} = $_missing;
	} elsif (/^SCORE/) {
	    my($t, $_test, $_impl, $_cpu, $_mem, $_loc) = split(/,/);
	    $cpu{$_impl} += $_cpu * $weight{$_test};
	    $mem{$_impl} += $_mem * $weight{$_test};
	    $loc{$_impl} += $_loc * $weight{$_test};
	} else {
	    # error
	}
    }

    my $xloc = defined($q->param('xloc')) ? $q->param('xloc') : 0;
    my $xmem = defined($q->param('xmem')) ? $q->param('xmem') : 0;
    my $xcpu = defined($q->param('xcpu')) ? $q->param('xcpu') : 1.0;

    my $scriptname = $ENV{SCRIPT_NAME};
    $scriptname =~ s/\.cgi$/.shtml/;
    print <<EOF;
<form METHOD="GET">
<table border="0">
<tr><td align="center" valign="center">
<input type="submit" value="Recalculate Scores">
<a href="$scriptname">Reset</a><br>
<br>
CPU Score Multiplier: <input type="text" name="xcpu" size="4" value="$xcpu"> &nbsp; 
Memory Score Multiplier: <input type="text" name="xmem" size="4" value="$xmem"><br>
Lines of Code Multiplier: <input type="text" name="xloc" size="4" value="$xloc"><br>
<br>
<table border="1" cellspacing="0" cellpadding="0" bgcolor="#c0e0e0" width="100%">
<tr><th bgcolor="black" colspan="4"><font color="white" size="+2">WEIGHTS</font></th></tr>
<tr><th bgcolor="black"><font color="white">Test</font></th><th bgcolor="black"><font color="white">Weight</font></th><th bgcolor="black"><font color="white">Test</font></th><th bgcolor="black"><font color="white">Weight</font></th></tr>
EOF

    my @tests = sort { $title{$a} cmp $title{$b} } keys %title;
    while (@tests) {
	print "<tr>\n";
	for (my $i=0; $i<2; $i++) {
	    if (my $test = (shift @tests)) {
		print qq{<td><a href="bench/$test/">$title{$test}</td><td align="center"><input type="text" name="$test" size="2" value="$weight{$test}"></td>\n};
	    } else {
		print qq{<td>&nbsp;</td><td>&nbsp;</td>\n};
	    }
	}
	print "</tr>\n";
    }

    print <<EOF;
</table></td><td>

<table border="1" cellspacing="0" cellpadding="0" bgcolor="#e0c0e0">
<tr><th bgcolor="black" colspan="5"><font color="white"><font size="+2">SCORES</font></font></th></tr>
<tr>
 <th bgcolor="black"><font color="white">Language</font></th>
 <th bgcolor="black"><font color="white">Implementation</font></th>
 <th bgcolor="black"><font color="white">Score</font></th>
 <th bgcolor="black"><font color="white">Missing</font></th>
</tr>
EOF

    my %score = ();
    foreach my $lang (keys %cpu) {
	$score{$lang} = ($cpu{$lang} * $xcpu) + ($mem{$lang} * $xmem) + ($loc{$lang} * $xloc);
    }
    my @ranked = ();
    foreach my $lang (keys %score) {
	push(@ranked, [$lang, $score{$lang}]);
    }
    foreach my $lref (sort {$b->[1] <=> $a->[1]} @ranked) {
	my($lang, $score) = @{$lref};
	my $lang_type = ($::LANG{$lang}->{Type} =~ /native compiled/) ?
	    qq{<b><i>$lang</i></b>} : qq{$lang};
	$score = int($score);
	print qq{<tr><td>$lang{$lang}</td><td><a href="lang/$lang/">$lang_type</a></td><td align="right">$score</td><td align="right">$missing{$lang}</td></tr>\n};
    }
    print <<EOF;
<tr><td colspan="4"><small>Languages that compile to native code are in <i><b>Bold Italics</b></i></small>.</td></tr>
</td></tr></table>
</table>
</form>
EOF
}

&main();
