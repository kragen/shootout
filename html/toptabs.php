<?php

function toptabs($current)
{
	$tablist = array(
		"/index.php" => "Introduction",
		"/langs.php" => "Languages",
		"/docs.php" => "Documentation",
		"/news.php" => "News",
		"/lang/bash" => "Implementations",
		"/craps.php" => "Scorecard",
		"/recent.php" => "Recent Changes",
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

