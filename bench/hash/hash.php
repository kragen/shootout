#!/usr/bin/php4 -f
<?php
/*
 $Id: hash.php,v 1.1 2004-05-28 06:49:27 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$n = ($argc == 2) ? $argv[1] : 1;
for ($i = 1; $i <= $n; $i++) {
    $X[dechex($i)] = $i;
}
for ($i = $n; $i > 0; $i--) {
    if ($X[$i]) { $c++; }
}
print "$c\n";
?>
