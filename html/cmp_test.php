<?php
# $Id: cmp_test.php,v 1.4 2004-06-03 03:38:47 bfulgham Exp $
#
require('chart.php');

function read_dat($test, $which) {
    $filedat = file("data/$which.mbtab");
    $langs = split("[ 	]", rtrim($filedat[0]));
    $count = count($filedat);
    
    for ($i = 1; $i < count($filedat); $i++)
    {
        $values = split("[ 	]", rtrim($filedat[$i]));
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
    echo "<div class=\"axial\">\n";
    echo "  <div class=\"h4\"><h4>Compare languages</h4>\n";
    echo "    <form method=\"get\" action=\"detail.php\">\n";
    echo "      <div class=\"axial\">\n";
    echo "        <table border=\"0\" cellspacing=\"2\" cellpadding=\"3\">\n";
    $ncols = 10;
    $self = "detail.php";

    echo "         <tr><th colspan=\"$ncols\">Choose which languages to compare: <input type=\"submit\" value=\"Plot!\"> &nbsp; <a href=\"$self\">Reset</a></th></tr>\n";
    for ($j = 0; $j < count($langs); $j = $j)
    {
	echo "          <tr>\n";
	for ($i=0; $i < $ncols; $i++) {
	    if (isset($langs[$j])) {
	        $name = $langs[$j];
	        $pad_name = str_pad($name,10);
		$checked = ($selected[$name]) ? " checked": "";
		echo "          <td><input type=\"checkbox\" name=\"$name\"$checked> $pad_name</td>\n";
	    }else {
		echo "          <td>&nbsp;</td>\n";
	    }
	    $j++;
	}
        echo "          </tr>\n";
    }
    echo "      </table>\n";
    echo "    </form>\n";
    echo "  </div>\n";
}

function plot_tab($dat_time, $langs, $dat, $test, $which, $title)
{
    $colors = array('red', 'green', 'blue', 'purple', 'peach', 'orange',
        'mauve', 'olive', 'pink', 'light purple', 'light blue', 'plum',
	'yellow', 'turquoise', 'light green', 'brown', 'red', 'green',
	'blue', 'purple', 'peach', 'orange', 'mauve', 'olive', 'pink',
	'light purple', 'light blue', 'plum', 'yellow', 'turquoise',
	'light green', 'brown');
	
    $TMPDIR = getcwd() . '/../../tmp/.shootout';

    $all = array_keys($dat);
    sort($all);
    sort($langs);

    $dir = "$TMPDIR/$test";
    if (! is_dir($dir)) {
	if( ! mkdir($dir, 0775) ) {
		echo "cmp_test.php: mkdir($dir) -> $!\n";
	}
    }
    
    $imagename = ($langs == $all) ? "ALL" : join('-', $langs);
    $imagefile = "$dir/$imagename-$which.png";
    if (file_exists($imagefile))
    {
    	$test_time = filemtime($imagefile);
    }
    else
    {
    	$test_time = 0;
    }

    if ($dat_time > $test_time) {
	# Just want the list of ordinals
	$temp = array_shift($dat);
	$range = array_keys($temp);
	array_unshift($dat, $temp);
	
	sort($range);
	$last = $range[count($range) - 1];
	$min = $range[0];

	# Generate the chart
	$chart = new chart(550, 600, $imagefile);
	$chart->set_title($title);
	$chart->set_labels('N', $which);
	$chart->set_background_color('grey');
	$chart->set_border(false, 0);
	$chart->set_frame(true);
	$chart->set_margins(50, 10, 20, 50);
	$chart->set_font(3, 'internal', false);

	# Legend?
	$chart->set_x_ticks($range, "text");
	$count = 0;
	foreach ($langs as $name) {
	    $row = $dat[$name];

	    if (! is_null($row))
	    {
	        # Massage row for Plot's use
		$pc=0;
		foreach ($row as $k => $v) {
		    $plotdata[$pc] = $v;
		    $pc ++;
		}
		$chart->plot($plotdata ,false, $colors[$count]);
		$chart->add_legend(rtrim($name), $colors[$count]);
		$count++;
	    }
	}
#	$chart->set_extrema(0,$last);
	$chart->stroke();
    }
    $imagefile_parts = Explode('/', $imagefile);
    return($imagefile_parts[count($imagefile_parts) - 1]);
}

function html_table_header($title, $headings)
{
    $ncols = count($headings) + 1;
    $ncols_m1 = $ncols - 1;
    echo "    <p><table border=\"1\" cellspacing=\"2\" cellpadding=\"3\">\n";
    echo "      <tr><th colspan=\"$ncols\">$title</th>\n";
    echo "      <tr><th>&nbsp;</th><th colspan=\"$ncols_m1\">N</th>\n";
    echo "      <tr><th>Test Source</th>\n";
    foreach ($headings as $num) {
	echo "        <th>$num</th>\n";
    }
    echo "      </tr>\n";
}

function print_tab($langs, $dat, $pmref, $which)
{
    $temp = array_shift($dat);
    $range = array_keys($temp);
    array_unshift($dat, $temp);
    html_table_header("Measurement of $which as N varies", $range);
    $last = $range[count($range) - 1];
    $names = $langs;
    sort($names);
    $count = 0;
    foreach ($names as $name) {
        $ab = ($count % 2) ? "a" : "b";
	echo "      <tr class=\"$ab\"><td><a href=\"$pmref[$name]\">$name</a></td>";
	$subrow = $dat[$name];
	foreach($range as $num) {
	    print "<td align=\"right\">$subrow[$num]</td>";
	}
	echo "          </tr>\n";
	$count++;
    }
    echo "</table>\n";
}

function cmp_test($test, $query_string)
{
    list($cpu, $cpu_date) = read_dat($test, 'cpu');
    list($mem, $mem_date) = read_dat($test, 'mem');

    $keys = array_keys($cpu);
    sort($keys);

    if ($query_string !== "")
    {
	# Get rid of the "=on" part
	$temp_query = preg_replace("/=on/", "", $query_string);
        $langs = Explode('&', $temp_query);
        sort($langs);
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
    echo "<div class=\"h4\"><h4>CPU Comparison</h4></div>\n";
    echo "<table><tr><td><img src=\"/tmp/.shootout/$test/$cpu_img\"></td><td>\n";
    print_tab($langs, $cpu, $pmref, 'CPU');
    echo "</td></tr></table>\n";
    echo "<div class=\"h4\"><h4>Memory Use Comparison</h4></div>\n";
    echo "<table><tr><td><img src=\"/tmp/.shootout/$test/$mem_img\"></td><td>\n";
    print_tab($langs, $mem, $pmref, 'Memory');
    echo "</td></tr></table>\n";
}

?>
