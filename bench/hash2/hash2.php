#!/usr/bin/php -f
<?php
/*
 $Id: hash2.php,v 1.3 2004-10-11 04:47:31 bfulgham Exp $
 http://shootout.alioth.debian.org/
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
