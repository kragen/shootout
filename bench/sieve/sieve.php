#!/usr/local/bin/php -f
<?php
/*
 $Id: sieve.php,v 1.1 2004-05-29 00:00:44 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$n = ($argc == 2) ? $argv[1] : 1;
$count = 0;
while ($n-- > 0) {
    $count = 0;
    $flags = range (0,8192);
    for ($i=2; $i<8193; $i++) {
	if ($flags[$i] > 0) {
	    for ($k=$i+$i; $k <= 8192; $k+=$i) {
		$flags[$k] = 0;
	    }
	    $count++;
	}
    }
}
print "Count: $count\n";
?>
