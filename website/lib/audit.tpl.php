<?   // Copyright (c) Isaac Gouy 2005 ?>


<table class="div" >
<tr><td>&nbsp;</td></tr>

<tr><td><h4 class="rev"><a class="arev" href="#audit" name="audit">&nbsp;audit</a></h4></td></tr>


<tr class="b"><td><a class="ab" href="#missing" name="missing">data.csv missing rows</a> - rows in ndata.csv but not in data.csv</td></tr>
<tr><td>
<?
   foreach($NData as $k => $v){
      if (!isset($Data[$k])){
         $a = explode('-',$k);
         $s = $a[0]." ".$a[1];
         if ($a[2]>0){ $s .= " #".$a[2]; }
         printf('<p>%s</p>',$s); echo "\n";
      }
   }
?>
</td></tr>



<tr class="b"><td><a class="ab" href="#read" name="read">ndata.csv read & filter</a></td></tr>
<tr><td>
<p>rows: <?=number_format($NDataN);?> @fgetcsv: <?=number_format($NDataTimeL,3);?>s</p>
</td></tr>

</table>