<? /* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy 

   php -q discovery.php < input.txt
*/ 


$variants = array (
       'agggtaaa|tttaccct'
      ,'[cgt]gggtaaa|tttaccc[acg]'
      ,'a[act]ggtaaa|tttacc[agt]t'
      ,'ag[act]gtaaa|tttac[agt]ct'
      ,'agg[act]taaa|ttta[agt]cct'
      ,'aggg[acg]aaa|ttt[cgt]ccct'
      ,'agggt[cgt]aa|tt[acg]accct'
      ,'agggta[cgt]a|t[acg]taccct'
      ,'agggtaa[cgt]|[acg]ttaccct'
   ); 

$sequence = implode("", file("php://stdin"));

foreach ($variants as $v){
   $matches = array();
   $vDelimited = '/'.$v.'/';
   preg_match_all($vDelimited, $sequence, $matches);    
   printf("%s %d\n", $v, sizeof($matches[0]));   
} 
?>