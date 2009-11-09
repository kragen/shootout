<?php // website content changes at-most once an hour - say ten past the hour
$m = floor(time()/60); $h = floor($m/60); $fivedays = floor($h/120); $after_the_hour = $m - $h*60; $countdown = 10;
if ($countdown <= $after_the_hour) { $countdown += 60; $h++; }
header("Pragma: public");
header("Cache-Control: maxage=".($countdown - $after_the_hour)*60);
header("Expires: " . gmdate("D, d M Y H:i:s", $h*3600 + 600) . " GMT");
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<meta name="robots" content="index,follow,archive" /><meta name="revisit" content="1 days" />

<meta name="keywords" content="fastest programming language faster programming languages fastest programs speed performance compare programs language comparison source code benchmarks game computers shootout" />
<meta name="description" content="Compare programming language performance on a dozen flawed benchmarks and contribute faster more elegant programs." />

<title>The Computer Language Benchmarks Game</title>
<link rel="stylesheet" type="text/css" href="./benchmark.css" />
<link rel="shortcut icon" href="./favicon.ico" />
</head>

<body id="core">
<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;Language&nbsp; <br/>Benchmarks&nbsp;Game</a>&nbsp;(<a href="./u64/faq.php">Read the FAQ!</a>)</h1></td>
</tr></table>

<div id="home">
<h5>Benchmarking programming languages?</h5>
<p>How can we benchmark a programming language?<br/>
We can't - we benchmark programming language implementations.</p>
<p>How can we benchmark language implementations?<br/>
We can't - <strong>we measure particular programs</strong>.</p><br/>

<h5>The fastest programming language?</h5>
<p>It depends: The fastest programming language for which programmers?<br/> The fastest programming language for which tasks? The fastest <br/>programming language from which sample of language implementations?</p><br/>


<h5><a href="http://shootout.alioth.debian.org/u64/shapes.php" title="Fastest in each programming language forced onto one core, 64 bit Ubuntu.">Fastest <em>programs</em> in each programming language</a></h5>
<p>There are 4 sets of up-to-date measurements. Click one of these <br/>color-code links to see all measurements for a particular OS/machine -</p><br/>

<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language, 32 bit Ubuntu." href="./u32q/"><? printf('%s', gmdate("d M Y", filemtime('./u32q/data/data.csv'))) ?></a></p>
<h3><span class="u32q">
<a title="Fastest in each programming language, 32 bit Ubuntu."
href="./u32q/">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span></h3>
</td>
</tr>
</table>

<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language, 64 bit Ubuntu." href="./u64q/"><? printf('%s', gmdate("d M Y", filemtime('./u64q/data/data.csv'))) ?></a></p>
<h3><span class="u64q">
<a title="Fastest in each programming language, 64 bit Ubuntu."
href="./u64q/">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;quad-core&nbsp;</a></span></h3>
</td>
</tr>
</table>


<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language forced onto one core, 64 bit Ubuntu." href="./u64/"><? printf('%s', gmdate("d M Y", filemtime('./u64/data/data.csv'))) ?></a></p>
<h3><span class="u64q">
<a title="Fastest in each programming language forced onto one core, 64 bit Ubuntu." href="./u64/">&nbsp;x64&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one&nbsp;core&nbsp;</a></span></h3>
</td>
</tr>
</table>

<table class="layout">
<tr class="test">
<td>
<p class="timestamp"><a title="Fastest in each programming language forced onto one core, 32 bit Ubuntu." href="./u32/"><? printf('%s', gmdate("d M Y", filemtime('./u32/data/data.csv'))) ?></a></p>
<h3><span class="u32">
<a title="Fastest in each programming language forced onto one core, 32 bit Ubuntu." href="./u32/">&nbsp;Ubuntu&#8482;&nbsp;:&nbsp;Intel&#174;&nbsp;Q6600&#174;&nbsp;one&nbsp;core&nbsp;</a></span></h3>
</td>
</tr>
</table>


<h5><br/>Compare fastest <em>programs</em> - programming languages Z to A</h5><br/>

<?php

require_once('../lib/lib_whitelist.php');

function ReadA($FileName){
   $f = @fopen($FileName,'r') or die('Cannot open '.$FileName);
   $row = @fgetcsv($f,1024,',');
   while (!@feof ($f)){
      $row = @fgetcsv($f,1024,',');
      if (!is_array($row)){ continue; }
      $rows[ $row[0] ] = $row;
   }
   @fclose($f);
   return $rows;
}

function Keys($sites){
   $siteKeys = array();
   foreach($sites as $s){
      $a = array_flip( array_keys( ReadA('./'.$s.'/include.csv') ));
      $akeys = array_keys($a);
      foreach($akeys as $k){ $a[$k] = $s; }
      $siteKeys[] = $a;
   }
   return $siteKeys;
}

function CompareLangName($b, $a){
   if (isset($a[LANG_FULL]) && isset($b[LANG_FULL])){
      return strcasecmp($a[LANG_FULL],$b[LANG_FULL]);
   } else {
      return 0;
   }
}

function PrintIncludedLanguages(&$sites,&$a,$notShown0 ){
   $link = $a[LANG_LINK];
   $notShown = $notShown0;
   $showTag = TRUE;
   foreach($sites as $keys){
      if (isset($keys[$link]) && !empty($link)){
         $notShown = FALSE;
         $notShownYet =$showTag;
         if ($showTag) {
            $tag = $a[LANG_TAG];
            $showTag = FALSE;
         } else { $tag = ''; }

         if ($notShownYet){

            $arch = '';
            $site = $keys[$link];
            if ($site == 'debian'){ $arch = '<em>Debian</em>'; }
            elseif ($site == 'gp4'){ $arch = '<em>Gentoo</em>'; }

            if (isset($a[LANG_SPECIALURL]) && !empty($a[LANG_SPECIALURL])){ // special_url
                printf('<p><a href="./%s/%s.php">%s</a> <span class="smaller">%s %s</span></p>',
                   $site, $a[LANG_SPECIALURL], $a[LANG_HTML], $tag, $arch);
            } else {
                printf('<p><a href="./%s/benchmark.php?test=all&amp;lang=%s">%s</a> <span class="smaller">%s %s</span></p>',
                   $site, $link, $a[LANG_HTML], $tag, $arch);
            }

         }
      }
   }
   return $notShown;
}

$Langs = ReadA('../desc/lang.csv');
uasort($Langs, 'CompareLangName');

$choices = array(
   array('u32','u32q'),
   array('u64q','u32'),
   array('u32q','u32q'),
   array('u64','u32'),
   array('u32q','u32'),
   array('u64','u32q'),
   array('u32','u32'),
   array('u64q','u32q')
   );

$chosen = $choices[$fivedays%8];
$a_list = Keys( array( $chosen[0] ));
$b_list = Keys( array( $chosen[1] ));

foreach($Langs as $a){
   $notShown = PrintIncludedLanguages($a_list,$a,TRUE);
   if ($notShown){ $notShown = PrintIncludedLanguages($b_list,$a,$notShown); }
//   if ($notShown){ $notShown = PrintIncludedLanguages($u32,$a,$notShown); }
}
?>



<p class="imgfooter">
<a href="./u64/miscfile.php?file=license&amp;title=Revised BSD license" title="Software contributed to The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="./open_source_button.png" alt="Revised BSD license" height="31" width="88" />
</a>
</p>

</div>

</body>
</html>
