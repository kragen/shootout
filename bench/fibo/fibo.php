#!/usr/bin/php4 -f
<?php
/*
 $Id: fibo.php,v 1.1 2004-05-28 20:25:42 bfulgham Exp $
 http://www.bagley.org/~doug/shootout/
*/
function fibo($n){
    return(($n < 2) ? 1 : fibo($n - 2) + fibo($n - 1));
}
$n = ($argc == 2) ? $argv[1] : 1;
$r = fibo($n);
print "$r\n";
?>
