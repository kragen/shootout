#!/usr/bin/php4 -f
<?php
/*
 $Id: nestedloop.php,v 1.1 2004-05-28 20:48:22 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
$n = ($argc == 2) ? $argv[1] : 1;
$x = 0;
for ($a=0; $a<$n; $a++)
    for ($b=0; $b<$n; $b++)
	for ($c=0; $c<$n; $c++)
	    for ($d=0; $d<$n; $d++)
		for ($e=0; $e<$n; $e++)
		    for ($f=0; $f<$n; $f++)
			$x++;
print "$x\n";
?>
