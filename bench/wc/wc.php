#!/usr/bin/php -f
<?php
/*
 $Id: wc.php,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
 
 TBD - this program should not assume lines are less than 10000 characters long
*/

$fd = fopen("php://stdin", "r");
$nl = $nw = $nc = 0;
while (!feof ($fd)) {
    if ($line = fgets($fd, 10000)) {
	++$nl;
	$nc += strlen($line);
	$nw += count(preg_split("/\s+/", $line, -1, PREG_SPLIT_NO_EMPTY));
    }
}
fclose($fd);
print "$nl $nw $nc\n";
?>
