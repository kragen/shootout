#!/usr/bin/perl
# $Id: cmp_test.pl,v 1.2 2004-05-31 08:06:42 bfulgham Exp $

use strict;
use CGI qw(-oldstyle_urls);

our $q = new CGI;

our $TMPDIR = '/var/tmp/.shootout';

our $PLOTCMD = '/home/doug/sh/plot --scale 1 --dsnames --width 600 --height 480 --type Lines --x_label "N" --ticklabels --graph_border 0 --gif_border 0 --brush_size 4 --title %T --imagefile %I';


sub main {
    print $q->header;
    my $test = $ENV{'TEST'};
    my($cpu, $cpu_date) = read_dat($test, 'cpu');
    my($mem, $mem_date) = read_dat($test, 'mem');
    my @langs = sort $q->param;
    @langs = sort keys %$cpu unless(@langs);
    my %selected = ();
    if ((scalar @langs) < (scalar keys %$cpu)) {
	for (@langs) { $selected{$_}++ }
    }
    lang_tab($test, \%selected, sort keys %$cpu);
    my $pmref = map_name_to_prog($test, @langs);
    my $cpu_img = plot_tab($cpu_date, \@langs, $cpu, $test, 'cpu', 'CPU');
    my $mem_img = plot_tab($mem_date, \@langs, $mem, $test, 'mem', 'Memory');
    print qq{<table><tr><td><img src="$cpu_img"></td><td>\n};
    print_tab(\@langs, $cpu, $pmref, 'CPU');
    print qq{</td></tr><tr><td><img src="$mem_img"></td><td>\n};
    print_tab(\@langs, $mem, $pmref, 'Memory');
    print qq{</td></tr></table>\n};
}

sub lang_tab {
    my($test, $selected, @langs) = @_;
    print qq{<form method="GET">};
    print qq{<p><table border="0" cellspacing="1" cellpadding="2" bgcolor="#e0e0c0">\n};
    my $ncols = 12;
    my $self = "detail.php";
    print qq{<tr><th colspan="$ncols" bgcolor="black"><font color="white">Choose which languages to compare: <input type="submit" value="Plot!"> &nbsp; <a href="$self">Reset</a></font></th></tr>\n};
    while (@langs) {
	print qq{<tr>};
	for (my $i=0; $i<$ncols; $i++) {
	    if (my $name = shift(@langs)) {
		my $checked = ($selected->{$name}) ? " checked": "";
		print qq{<td><input type="checkbox" name="$name"$checked> $name</td>\n};
	    }else {
		print qq{<td>&nbsp;</td>\n};
	    }
	}
	print qq{</tr>\n};
    }
    print qq{</table>\n};
    print qq{</form>\n};
}

sub plot_tab {
    my($dat_time, $langs, $dat, $test, $which, $title) = @_;
    my @all = sort keys %$dat;
    my @langs = sort @$langs;
    my $dir = "$TMPDIR/$test";
    if (not -d $dir) {
	mkdir($dir) or warn "cmp_test.cgi: mkdir($dir) -> $!\n";
    }
    my $imagename = ("@langs" eq "@all") ? "ALL" : join('-', @langs);
    my $imagefile = "$dir/$imagename-$which.png";
    if ($dat_time > (stat($imagefile))[9]) {
	#warn "DBG: running $PLOTCMD\n";
	my $cmd = $PLOTCMD;
	$cmd =~ s/%I/$imagefile/g;
	$cmd =~ s/%T/$title/g;
	my @range = sort { $a <=> $b } keys %{$dat->{$$langs[0]}};
	my $last = $range[-1];
	my @names = sort { $dat->{$b}->{$last} <=> $dat->{$a}->{$last} } @$langs;
	local(*P);
	if (open(P, "|$cmd")) {
	    print P "# @names\n";
	    foreach my $num (@range) {
		print P $num;
		foreach my $name (@names) {
		    print P " ", $dat->{$name}->{$num};
		}
		print P "\n";
	    }
	    close(P);
	} else {
	    warn "cmp_test.cgi: Error opening $cmd for output\n";
	}
    }
    $imagefile =~ s!^.*/!/tmp/shootout/$test/!;
    return($imagefile);
}

sub print_tab {
    my($langs, $dat, $pmref, $which) = @_;
    my @range = sort { $a <=> $b } keys %{$dat->{$$langs[0]}};
    html_table_header("Measurement of $which as N varies", @range);
    my $last = $range[-1];
    my @names = sort {
	$dat->{$a}->{$last} <=> $dat->{$b}->{$last}
    } (@$langs);
    foreach my $name (@names) {
	print qq{<tr><td><a href="$pmref->{$name}">$name</a></td>};
	foreach my $num (@range) {
	    print qq{<td align="right">$dat->{$name}->{$num}</td>};
	}
	print qq{</tr>\n};
    }
    print qq{</table>\n};
}


sub map_name_to_prog {
    my($test, @prognames) = @_;
    my %pmmap = ();
    foreach my $file (listfiles("../bench/$test")) {
	my $name = (split(/\./, $file))[1];
	$pmmap{$name} = $file;
    }
    foreach my $name (@prognames) {
	unless ($pmmap{$name}) {
	    warn "Error!  no match for name: $name\n";
	}
    }
    return(\%pmmap);
}

sub listfiles {
    my($dir) = @_;
    my(@files) = ();
    if (opendir(DIR, $dir)) {
	@files = sort(grep(!/^\.+$/, readdir(DIR))); # ignore . and ..
	closedir(DIR);
    }
    return(@files);
}

sub html_table_header ($@) {
    my($title, @headings) = @_;
    my $ncols = scalar(@headings) + 1;
    print qq{<p><table border="0" cellspacing="1" cellpadding="2" bgcolor="#e0e0c0">\n};
    print qq{<tr><th colspan="$ncols" bgcolor="black"><font color="white">$title</font></th>\n};
    print qq{<tr><th bgcolor="black">&nbsp;</th><th colspan="@{[$ncols-1]}" bgcolor="black"><font color="white">N</font></th>\n};
    print qq{<tr><th bgcolor="black"><font color="white">Test Source</font></th>\n};
    foreach my $num (@headings) {
	print qq{<th bgcolor="black"><font color="white">$num</font></th>\n};
    }
}

sub read_dat {
    my($test, $which) = @_;
    my %dat = ();
    local(*F);
    my $mtime = 0;
    if (open(F, "<../bench/$test/data/$which.mbtab")) {
	my @langs = split(/\s+/, scalar(<F>));
	shift(@langs);
	while (<F>) {
	    my @values = split();
	    my $N = shift(@values);
	    foreach (my $i=0; $i<scalar(@values); $i++) {
		$dat{$langs[$i]}->{$N} = $values[$i];
	    }
	}
	$mtime = (stat(F))[9];
	close(F);
    }
    return(\%dat, $mtime);
}

&main();
