#!/usr/bin/php4 -f
<?php
/*
 $Id: ary.php,v 1.1 2004-05-28 06:39:25 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$n = ($argc == 2) ? $argv[1] : 1;
for ($i=0; $i<$n; $i++) {
    $X[$i] = $i + 1;
}
for ($k=0; $k<1000; $k++) {
    for ($i=$n-1; $i>=0; $i--) {
	$Y[$i] += $X[$i];
    }
}
$last = $n-1;
print "$Y[0] $Y[$last]\n";
?>
