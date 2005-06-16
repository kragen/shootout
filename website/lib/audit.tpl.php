<?   // Copyright (c) Isaac Gouy 2005 ?>

<div>
<p class="rs"><? printf('%s GMT', gmdate("l, M d, Y g:i a", $Now)) ?></p>
</div>

<table class="div"><tr><td><p>PHP Version: <?=PHP_VERSION;?></p></td></tr>

<tr><td><h4 class="rev"><a class="arev" href="#audit" name="audit">&nbsp;audit</a></h4></td></tr>
<? 
   list (
      $missingRows, $badPermissions, $missingLogs, $orphans, 
      $bad1, $bad2, $bad3, $bad4, $bad5, $big, $timeoutCount, 
      $failedCount
      ) = AuditResults($NData, $Logs, $Data);
?>


<tr class="b"><td><a class="ab" href="#read" name="read"><strong>Summary</strong></a></td></tr>
<tr><td>

<p><a href="#missingrows">missing rows:</a> <?=sizeof($missingRows);?></p>
<p><a href="#missinglogs">missing log files:</a> <?=sizeof($missingLogs);?></p>
<p><a href="#orphan">orphan log files:</a> <?=sizeof($orphans);?></p>
<p><a href="#bad1">bad log files 1:</a> <?=sizeof($bad1);?></p>
<p><a href="#bad2">bad log files 2:</a> <?=sizeof($bad2);?></p>
<p><a href="#bad3">bad log files 3:</a> <?=sizeof($bad3);?></p>
<p><a href="#bad4">bad log files 4:</a> <?=sizeof($bad4);?></p>
<p><a href="#bad5">bad log files 5:</a> <?=sizeof($bad5);?></p>
<p><a href="#big">log files >20KB:</a> <?=sizeof($big);?></p>
<p><a href="#denied">bad file permissions:</a> <?=sizeof($badPermissions);?></p>

<p>TIMEOUT log files: <?=$timeoutCount;?></p>
<p>FAILED log files: <?=$failedCount;?></p>
<p>rows: <?=number_format($NDataN);?> @fgetcsv: <?=number_format($NDataTime,3);?>s</p>
</td></tr>


<tr class="b"><td><a class="ab" href="#missingrows" name="missingrows"><strong>data.csv missing rows</strong></a><br />rows in ndata.csv but not in data.csv</td></tr>
<tr><td><? array_walk($missingRows,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#missinglogs" name="missinglogs"><strong>missing log files</strong></a><br />row in ndata.csv but no log file</td></tr>
<tr><td><? array_walk($missingLogs,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#orphan" name="orphan"><strong>orphan log files</strong></a><br />no row in ndata.csv but log file exists</td></tr>
<tr><td><? array_walk($orphans,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#bad1" name="bad1"><strong>bad log files 1</strong></a><br />error in ndata.csv but no 'FAILED' in log file</td></tr>
<tr><td><? array_walk($bad1,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#bad2" name="bad2"><strong>bad log files 2</strong></a><br />no error in ndata.csv but 'FAILED' in log file</td></tr>
<tr><td><? array_walk($bad2,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#bad3" name="bad3"><strong>bad log files 3</strong></a><br />no 'PROGRAM OUTPUT' in log file but no error</td></tr>
<tr><td><? array_walk($bad3,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#bad4" name="bad4"><strong>bad log files 4</strong></a><br />timeout in ndata.csv but no 'TIMEOUT' in log file</td></tr>
<tr><td><? array_walk($bad4,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#bad5" name="bad5"><strong>bad log files 5</strong></a><br />no timeout in ndata.csv but 'TIMEOUT' in log file</td></tr>
<tr><td><? array_walk($bad5,'PrintPrettyTag'); ?></td></tr>

<tr class="b"><td><a class="ab" href="#big" name="big"><strong>big log files</strong></a><br />log files bigger than 20KB</td></tr>
<tr><td>
<?         
   uasort($big, 'CompareLogFileSize');      
   foreach($big as $k => $v){ 
      printf('<p>%s %s</p>', number_format($v[1]),PrettyTag($k)); echo "\n";       
   }     
?>
</td></tr>

<tr class="b"><td><a class="ab" href="#denied" name="denied"><strong>bad file permission</strong></a><br />'Permission denied' in log file</td></tr>
<tr><td><? array_walk($badPermissions,'PrintPrettyTag'); ?></td></tr>

</table>