<?php

function toptabs($current)
{
	global $base;

	$tablist = array(
		"$base/index.php" => "Introduction",
		"$base/langs.php" => "Languages",
		"$base/docs.php" => "Documentation",
		"$base/news.php" => "News",
		"$base/lang/bash" => "Implementations",
		"$base/craps.php" => "Scorecard",
		"$base/recent.php" => "Recent Changes",
		"http://lists.alioth.debian.org/mailman/listinfo/shootout-list" => "Mailing List",
		"http://shootout.alioth.debian.org/wiki" => "Wiki",
		"http://alioth.debian.org/projects/shootout" => "Alioth");

	echo "<div class=\"tabs\" id=\"toptabs\">\n";
	echo "  <table border=\"0\" cellspacing=\"0\" cellpadding=\"4\" id=\"main\">\n";
	echo "    <tr>\n";

	foreach ($tablist as $key => $value) {
		$element = "td";
		if ( ($key == $current) || ($key == '/' . $current))
		{
			$element = "th";
		}
		echo "     <$element><a href=\"$key\">$value</a></$element>\n";
	}

	echo "    </tr>\n";
	echo "  </table>\n";
	echo "</div>\n";
} ?>

