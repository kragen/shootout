<?   // Copyright (c) Isaac Gouy 2005 ?>

<div>
<p class="rs"><? printf('%s GMT', gmdate("l, M d, Y g:i a", $Now)) ?></p>
</div>

<table class="div" >
<tr><td>&nbsp;</td></tr>

<tr><td><h4 class="rev"><a class="arev" href="#audit" name="audit">&nbsp;audit</a></h4></td></tr>

<tr class="b"><td><a class="ab" href="#missingrows" name="missingrows"><strong>data.csv missing rows</strong></a><br />rows in ndata.csv but not in data.csv</td></tr>
<tr><td>
<?
   foreach($NData as $k => $v){
      if (!isset($Data[$k])){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }
   }
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#missinglogs" name="missinglogs"><strong>missing log files</strong></a><br />row in ndata.csv but no log file</td></tr>
<tr><td>
<?
   foreach($NData as $k => $v){ 
      if (!isset($Logs[$k])){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }     
   }     
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#orphan" name="orphan"><strong>orphan log files</strong></a><br />no row in ndata.csv but log file exists</td></tr>
<tr><td>
<?
   foreach($Logs as $k => $v){ 
      if (!isset($NData[$k])){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }     
   }     
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#bad1" name="bad1"><strong>bad log files 1</strong></a><br />error in ndata.csv but no 'FAILED' in log file</td></tr>
<tr><td>
<?
   foreach($NData as $k => $v){ 
      if ($v==PROGRAM_ERROR && isset($Logs[$k])){
         if ($Logs[$k][0]!=PROGRAM_ERROR){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }     
      }      
   }     
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#bad2" name="bad2"><strong>bad log files 2</strong></a><br />no error in ndata.csv but 'FAILED' in log file</td></tr>
<tr><td>
<?
   foreach($Logs as $k => $v){ 
      if ($v[0]==PROGRAM_ERROR && isset($NData[$k])){
         if ($NData[$k]!=PROGRAM_ERROR){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }     
      }      
   }      
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#bad3" name="bad3"><strong>bad log files 3</strong></a><br />no 'PROGRAM OUTPUT' in log file but no error</td></tr>
<tr><td>
<?
   foreach($Logs as $k => $v){ 
      if ($v[0]==NO_PROGRAM_OUTPUT){printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }          
   }      
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#time1" name="time1"><strong>bad log files 4</strong></a><br />timeout in ndata.csv but no 'KILLED' in log file</td></tr>
<tr><td>
<?
   foreach($NData as $k => $v){ 
      if ($v==PROGRAM_TIMEOUT && isset($Logs[$k])){
         if ($Logs[$k][0]!=PROGRAM_TIMEOUT){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }     
      }      
   }     
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#time2" name="time2"><strong>bad log files 5</strong></a><br />no timeout in ndata.csv but 'KILLED' in log file</td></tr>
<tr><td>
<?
   foreach($Logs as $k => $v){ 
      if ($v[0]==PROGRAM_TIMEOUT && isset($NData[$k])){
         if ($NData[$k]!=PROGRAM_TIMEOUT){ printf('<p>%s</p>',PrettyTag($k)); echo "\n"; }     
      }      
   }      
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#big" name="big"><strong>big log files</strong></a><br />log files bigger than 20KB</td></tr>
<tr><td>
<?
   $big = array();
   foreach($Logs as $k => $v){ 
      if ($v[1]>20480){ $big[$k] = $v; } 
   }
         
   uasort($big, 'CompareLogFileSize');      
   foreach($big as $k => $v){ 
      printf('<p>%s %s</p>', number_format($v[1]),PrettyTag($k)); echo "\n";       
   }     
?>
</td></tr>


<tr class="b"><td><a class="ab" href="#read" name="read"><strong>ndata.csv read & filter</strong></a></td></tr>
<tr><td>
<p>rows: <?=number_format($NDataN);?> @fgetcsv: <?=number_format($NDataTime,3);?>s</p>
</td></tr>

</table>