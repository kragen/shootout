#!/usr/local/bin/php -f
<?php
/*
 $Id: strcat.php,v 1.1 2004-05-29 00:00:44 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$n = ($argc == 2) ? $argv[1] : 1;
$str = "";
while ($n-- > 0) {
    $str .= "hello\n";
}
$len = strlen($str);
print "$len\n";
?>
