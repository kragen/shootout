<?php

#!/usr/bin/perl
# $Id: cmp_test.php,v 1.1 2004-06-01 02:04:31 bfulgham Exp $
#
#use strict;
#use CGI qw(-oldstyle_urls);
#
#our $q = new CGI;
#
#

function read_dat($test, $which) {
    $filedat = file("data/$which.mbtab");
    $langs = split("[ 	]", $filedat[0]);
    $count = count($filedat);
    
    for ($i = 1; $i < count($filedat); $i++)
    {
        $values = split("[ 	]", $filedat[$i]);
	$ord = $values[0];
	for ($j = 1; $j < count($values); $j++)
	{
	    if (is_array($dat) && isset($dat[$langs[$j]]))
	    {
	        $subdat = $dat[$langs[$j]];
	    }
	    $subdat[$ord] = $values[$j];
	    $dat[$langs[$j]] = $subdat;
	}
    }
    $mtime = filemtime("data/$which.mbtab");

    return array($dat, $mtime);
}

function listfiles($dir)
{
    if (is_dir($dir))
    {
        if ($dh = opendir($dir))
	{
	    $i = 0;
	    while (false !== ($file = readdir($dh)))
	    {
	        if ($file != "." && $file != "..")
		{
		    $filelist[$i] = $file;
		    $i++;
		}
	    }
	    closedir($dh);
	}
    }
    return($filelist);
}

function map_name_to_prog($test, $prognames)
{
    $filelist = listfiles(".");
    foreach ($filelist as $file)
    {
        $temp = split("\.", $file);
	$name = $temp[1];
	$pmmap[$name] = $file;
    }
    foreach ($prognames as $name)
    {
	if (! array_key_exists($name, $pmmap))
	{
	    #echo "Error!  no match for name: $name\n";
	}
    }
    return $pmmap;
}

function lang_tab($test, $selected, $langs)
{
    #echo "<form method=\"GET\>";
    echo "<div class=\"axial\">\n";
    echo "  <div class=\"h3\"><h3>Compare languages</h3></div>\n";
    echo "  <table border=\"0\" cellspacing=\"2\" cellpadding=\"3\">\n";
    $ncols = 10;
    $self = "detail.php";
    
    echo "    <tr><th colspan=\"$ncols\">Choose which languages to compare: <input type=\"submit\" value=\"Plot!\"> &nbsp; <a href=\"$self\">Reset</a></th></tr>\n";
    for ($j = 0; $j < count($langs); $j = $j)
    {
	echo "    <tr>\n";
	for ($i=0; $i < $ncols; $i++) {
	    if (isset($langs[$j])) {
	        $name = $langs[$j];
	        $pad_name = str_pad($name,10);
		$checked = ($selected[$name]) ? " checked": "";
		echo "      <td><input type=\"checkbox\" name=\"$name\"$checked> $pad_name</td>\n";
	    }else {
		echo "      <td>&nbsp;</td>\n";
	    }
	    $j++;
	}
        echo "</tr>\n";
    }
    echo "  </table>\n";
    echo "</form>\n";
}

function plot_tab($dat_time, $langs, $dat, $test, $which, $title)
{
    $TMPDIR = '/var/tmp/.shootout';
    $PLOTCMD = 'bin/plot --scale 1 --dsnames --width 600 --height 480 --type Lines --x_label "N" --ticklabels --graph_border 0 --gif_border 0 --brush_size 4 --title %T --imagefile %I';

    $all = array_keys($dat);
    sort($all);

    sort($langs);
    $dir = "$TMPDIR/$test";
    if (! is_dir($dir)) {
	if( ! mkdir($dir) ) {
		echo "cmp_test.cgi: mkdir($dir) -> $!\n";
	}
    }
    
    $imagename = ($langs == $all) ? "ALL" : join('-', $langs);
    $imagefile = "$dir/$imagename-$which.png";
    if ($dat_time > filemtime($imagefile)) {
	#warn "DBG: running $PLOTCMD\n";
	$cmd = preg_replace("/%I/", $imagefile, $PLOTCMD);
	$cmd = preg_replace("/%T/", $title, $cmd);
	$descriptorspec = array(
		 0 => array("pipe", "r"),
		 1 => array("pipe", "w"),
		 2 => array("file", "/tmp/error-output.txt", "a"));

	$range = keys %{$dat->{$$langs[0]}};
	$range = sort { $a <=> $b } keys %{$dat->{$$langs[0]}};
#	my $last = $range[-1];
#	my @names = sort { $dat->{$b}->{$last} <=> $dat->{$a}->{$last} } @$langs;

	$process = proc_open("$cmd", $descriptorspec, $pipes);
	if (is_resource($process))
	{
	    fwrite($pipes[0], "# @names\n");
#	    print P "# @names\n";
#	    foreach (my $num (@range) {
#		print P $num;
#		foreach my $name (@names) {
#		    print P " ", $dat->{$name}->{$num};
#		}
#		print P "\n";
#	    }
	    fclose($pipes[0]);
	    fclose($pipes[1]);
	} else {
	    echo "cmp_test.php: Error opening $cmd for output\n";
	}
    }
#    $imagefile =~ s!^.*/!/tmp/shootout/$test/!;
    return($imagefile);
}

function cmp_test($test, $query_string)
{
    list($cpu, $cpu_date) = read_dat($test, 'cpu');
    list($mem, $mem_date) = read_dat($test, 'mem');

    $keys = array_keys($cpu);
    sort($keys);

    if ($query_string !== "")
    {
        $langs = sort($query_string);
    } else {
        $langs = $keys;
    }
    
    if (count($langs) < count($keys))
    {
	foreach ($langs as $lng) {
	    $selected[$lng] = true;
	}
    } else {
        foreach (array_keys($cpu) as $key) {
	    $selected[$key] = true;
	}
    }

    # Set up Form
    lang_tab($test, $selected, $keys);
    $pmref = map_name_to_prog($test, $langs);
    $cpu_img = plot_tab($cpu_date, $langs, $cpu, $test, 'cpu', 'CPU');
    $mem_img = plot_tab($mem_date, $langs, $mem, $test, 'mem', 'Memory');
    echo "<table><tr><td><img src=\"$cpu_img\"></td><td>\n";
#    print_tab(\@langs, $cpu, $pmref, 'CPU');
    echo "</td></tr><tr><td><img src=\"$mem_img\"></td><td>\n";
#    print_tab(\@langs, $mem, $pmref, 'Memory');
    echo "</td></tr></table>\n";
}



#sub print_tab {
#    my($langs, $dat, $pmref, $which) = @_;
#    my @range = sort { $a <=> $b } keys %{$dat->{$$langs[0]}};
#    html_table_header("Measurement of $which as N varies", @range);
#    my $last = $range[-1];
 #   my @names = sort {
#	$dat->{$a}->{$last} <=> $dat->{$b}->{$last}
#    } (@$langs);
#    foreach my $name (@names) {
#	print qq{<tr><td><a href="$pmref->{$name}">$name</a></td>};
#	foreach my $num (@range) {
#	    print qq{<td align="right">$dat->{$name}->{$num}</td>};
#	}
#	print qq{</tr>\n};
#    }
#    print qq{</table>\n};
#}




#sub html_table_header ($@) {
#    my($title, @headings) = @_;
#    my $ncols = scalar(@headings) + 1;
#    print qq{<p><table border="0" cellspacing="1" cellpadding="2" bgcolor="#e0e0c0">\n};
#    print qq{<tr><th colspan="$ncols" bgcolor="black"><font color="white">$title</font></th>\n};
#    print qq{<tr><th bgcolor="black">&nbsp;</th><th colspan="@{[$ncols-1]}" bgcolor="black"><font color="white">N</font></th>\n};
#    print qq{<tr><th bgcolor="black"><font color="white">Test Source</font></th>\n};
#    foreach my $num (@headings) {
#	print qq{<th bgcolor="black"><font color="white">$num</font></th>\n};
#    }
#}


?>
