<?php

function benchlist($level)
{
	$testlist = array("ackermann" => "Ackermann's Function",
		"ary" => "Array Access",
		"echo" => "Simple TCP/IP Server",
		"except" => "Exception Handling",
		"fibo" => "Fibonacci Numbers",
		"hash" => "Hash (Associative Array) Access",
		"hash2" => "Hashes, Part II",
		"heapsort" => "Heapsort",
		"hello" => "Hello World",
		"lists" => "List Processing",
		"lists1" => "Lists (Singly Linked)",
		"lists2" => "Lists (Doubly Linked)",
		"matrix" => "Matrix Multiplication",
		"methcall" => "Method Calls",
		"moments" => "Statistical Moments",
		"nestedloop" => "Nested Loops",
		"objinst" => "Object Instantiation",
		"plugin" => "Plugin Test",
		"prodcons" => "Producer/Consumer Threads",
		"random" => "Random Number Generator",
		"regexmatch" => "Regular Expression Matching",
		"regsub" => "Regular Expression Substitution",
		"reversefile" => "Reverse A File",
		"ringmsg" => "Ring of Messages",
		"sieve" => "Sieve of Eratosthenes",
		"spellcheck" => "Spell Checker",
		"strcat" => "String Concatenation",
		"sumcol" => "Sum a Column of Integers",
		"wc" => "Count Lines/Words/Chars",
		"wordfreq" => "Word Frequency");

	echo "    <td id=\"leftcol\" width=\"20%\">\n";
	echo "      <div id=\"navcolumn\">\n";
	echo "        <div id=\"projecttools\" class=\"toolgroup\">\n";
	echo "          <div class=\"label\"><strong>The Benchmark Tests</strong></div>\n";
	echo "          <div class=\"body\">\n";
		
	foreach ($testlist as $key => $value) {
		echo "            <div><a href=\"$level/bench/$key\">$value</a></div>\n";
	}

	echo "          </div>\n";
	echo "        </div>\n";
}

function nav_list_end()
{
	echo "        <div class=\"strut\">&nbsp;</div>\n";
	echo "      </td>\n";
}
?>
