#!/usr/bin/php -f
<?php
/*
 $Id: hash2.php,v 1.2 2004-06-15 05:45:40 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$n = ($argc == 2) ? $argv[1] : 1;
for ($i = 0; $i < 10000; $i++) {
    $hash1["foo_$i"] = $i;
}
for ($i = $n; $i > 0; $i--) {
    foreach($hash1 as $key => $value) $hash2[$key] += $value;
}
print "$hash1[foo_1] $hash1[foo_9999] $hash2[foo_1] $hash2[foo_9999]\n";
?>
