#!/usr/bin/php -f
<?php
/*
 $Id: spellcheck.php,v 1.2 2004-06-12 16:19:44 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$dict = array();
$fd = fopen("Usr.Dict.Words", "r");
while (!feof ($fd)) { $dict[chop(fgets($fd, 1024))] = 1; }
fclose($fd);

$fd = fopen("php://stdin", "r");
while (!feof ($fd)) {
    $word = chop(fgets($fd, 1024));
    if (! $dict[$word]) {
	print "$word\n";
    }
}
fclose($fd);
?>
