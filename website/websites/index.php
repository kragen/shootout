<?php
ob_start('ob_gzhandler');
$s = time();

// REVISED - don't have all pages expire at the same time!
// EXPIRE pages 31 hours after they are visited.
header("Pragma: public");
header("Cache-Control: maxage=".(31*3600).",public");
header("Expires: " . gmdate("D, d M Y H:i:s", $s + (31*3600)) . " GMT");
?>
<?php echo '<?xml version="1.0" encoding="utf-8"?>'; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<meta name="robots" content="all" /><meta name="revisit" content="1 days" />

<meta name="description" content="Compare the performance of ~24 programming languages using ~12 simple benchmarks and ~1100 programs. Contribute faster more elegant programs." />

<meta name="HandheldFriendly" content="false" />

<title>Computer Language Benchmarks Game</title>
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/benchmark_css_18aug2010.php" />
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/nohint_css_26jan2011.php" media="screen,print,projection"/>
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/hint_css_26jan2011.php" media="handheld,aural,braille"/>
<link rel="shortcut icon" href="http://shootout.alioth.debian.org/favicon_ico_11dec2009.php" />
</head>

<body id="core">
<p id="hint"><a href="http://shootout.alioth.debian.org/mobile/index.php">/mobile Handheld Friendly website</a></p>

<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;<strong>Language</strong>&nbsp; <br/><strong>Benchmarks</strong>&nbsp;Game</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://shootout.alioth.debian.org/help.php" title="How to compare these programming language measurements. How programs were measured. How to contribute programs. FAQs">[[ Help ]]</a></h1></td>
</tr></table>

<div id="sitemap">
<h5><strong>Compare the performance of &asymp;24 programming languages</strong> for 4 different combinations of OS/machine. <strong>Contribute faster more elegant programs.</strong> And please <a href="http://shootout.alioth.debian.org/dont-jump-to-conclusions.php" title="The performance of a benchmark, even if it is derived from a real program, may not help to predict the performance of similar programs that have different hot spots."><strong>don't jump to conclusions!</strong></a></h5> 


<table>

<?
$sites = array('u32','u32q','u64','u64q');

function PrintHeaders(){
   echo '<tr><th>&nbsp;</th><th></th><th></th><th></th></tr>';
   echo '<tr>';
   echo '<th class="u32">&nbsp;x86&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; one&nbsp;core&nbsp;</th>';
   echo '<th class="u32q">&nbsp;x86&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; quad-core&nbsp;</th>';
   echo '<th class="u64">&nbsp;x64&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; one&nbsp;core&nbsp;</th>';
   echo '<th class="u64q">&nbsp;x64&nbsp;Ubuntu&#8482; Intel&#174;&nbsp;Q6600&#174; quad-core&nbsp;</th>';
   echo '</tr>';
   echo '<tr><th>&nbsp;</th><th></th><th></th><th></th></tr>';
}

PrintHeaders();

$tests = array(
   array('nbody','n-body','Perform an N-body simulation of the Jovian planets')
   ,array('fannkuchredux','fannkuch-redux','Repeatedly access a tiny integer-sequence')
   ,array('meteor','meteor-contest','Search for solutions to shape packing puzzle')
   ,array('fasta','fasta','Generate and write random DNA sequences')
   ,array('spectralnorm','spectral-norm','Calculate an eigenvalue using the power method')
   ,array('revcomp','reverse-complement','Read DNA sequences and write their reverse-complement')
   ,array('mandelbrot','mandelbrot','Generate a Mandelbrot set and write a portable bitmap')
   ,array('knucleotide','k-nucleotide','Repeatedly update hashtables and k-nucleotide strings')
   ,array('regexdna','regex-dna','Match DNA 8-mers and substitute nucleotides for IUB code')
   ,array('pidigits','pidigits','Calculate the digits of Pi with streaming arbitrary-precision arithmetic')
   ,array('chameneosredux','chameneos-redux','Repeatedly perform symmetrical thread rendezvous requests')
   ,array('threadring','thread-ring','Repeatedly switch from thread to thread passing one token')
   ,array('binarytrees','binary-trees','Allocate and deallocate many many binary trees')
   );

foreach($tests as $t){
   printf('<tr>');
   foreach($sites as $s){
      printf('<td><a href="http://shootout.alioth.debian.org/%s/performance.php?test=%s" title="%s">%s</a></td>', $s, $t[0], $t[2], $t[1] );
   }
   printf('</tr>');
}

PrintHeaders();

$basesite = array('u32');
$onecoresites = array('u32','u64');
$u32sites = array('u32','u32q');
$allsites = array('u32','u32q','u64','u64q');

$langs = array(
   array('gnat','Ada 2005 GNAT','ada',$allsites),
   array('ats','ATS','ats',$allsites),
   array('gcc','C GNU','c',$allsites),
   array('clean','Clean','clean',$onecoresites),
   array('clojure','Clojure','',$allsites),
   array('csharp','C# Mono','csharp',$allsites),
   array('gpp','C++ GNU','cpp',$allsites),
   array('hipe','Erlang HiPE','erlang',$allsites),
   array('fsharp','F# Mono','fsharp',$allsites),
   array('ifc','Fortran Intel','fortran',$allsites),
   array('go','Go 6g 8g','',$allsites),
   array('ghc','Haskell GHC','haskell',$allsites),
   array('java','Java 6 -server','java',$allsites),
   array('javaxint','Java 6 -Xint','',$allsites),
   array('tracemonkey','JavaScript TraceMonkey','',$onecoresites),
   array('v8','JavaScript V8','javascript',$onecoresites),
   array('sbcl','Lisp SBCL','lisp',$allsites),
   array('lua','Lua','lua',$onecoresites),
   array('luajit','LuaJIT','luajit',$onecoresites),
   array('oz','Mozart/Oz','oz',$basesite),
   array('ocaml','OCaml','ocaml',$allsites),
   array('fpascal','Free Pascal','pascal',$allsites),
   array('perl','Perl','perl',$u32sites),
   array('php','PHP','php',$u32sites),
   array('pypy','PyPy','',$onecoresites),
   array('python3','Python 3','python3',$allsites),
   array('python','CPython','python',$u32sites),
   array('racket','Racket','racket',$onecoresites),
   array('yarv','Ruby 1.9','',$allsites),
   array('jruby','JRuby','jruby',$u32sites),
   array('ruby','Ruby 1.8.7','ruby',$basesite),
   array('scala','Scala','scala',$allsites),
   array('vw','Smalltalk VisualWorks','smalltalk',$onecoresites)
   );


$tag = array(
    'u32' => 'on single core 32 bit Linux'
   ,'u32q' =>'on multi core 32 bit Linux'
   ,'u64' =>'on single core 64 bit Linux'
   ,'u64q' =>'on multi core 64 bit Linux'
   );

foreach($langs as $lang){
   printf('<tr>');
   $name = $lang[1];
   $langsites = $lang[3];
   foreach($sites as $s){
      if (in_array($s,$langsites)){
         if (!empty($lang[2])){
            printf('<td><a href="http://shootout.alioth.debian.org/%s/%s.php" title="Compare %s program performance %s">%s</a></td>', $s, $lang[2], $name, $tag[$s], $name );
         } else {
            printf('<td><a href="http://shootout.alioth.debian.org/%s/compare.php?lang=%s" title="Compare %s program performance %s">%s</a></td>', $s, $lang[0], $name, $tag[$s], $name );
         }
      }
      else {
         printf('<td>&nbsp;</td>');
      }
   }
   printf('</tr>');
}



function PrintIncludedLanguages($site,$lang){
   $name = $lang[1];
   $tag = $lang[2];
   if (!empty($lang[3])){ // special_url
       printf('<p><a href="http://shootout.alioth.debian.org/%s/%s.php" title="Compare %s performance against one other programming language">%s</a> <span class="smaller">%s</span></p>',
          $site, $lang[3], $name, $name, $tag);
   } else {
       printf('<p><a href="http://shootout.alioth.debian.org/%s/compare.php?lang=%s" title="Compare %s performance against one other programming language">%s</a> <span class="smaller">%s</span></p>',
          $site, $lang[0], $name, $name, $tag);
   }
}



PrintHeaders();

$page = array(
    array('which-programming-languages-are-fastest.php','Which programming languages are fastest?','Which programming languages have the fastest benchmark programs?')
   ,array('code-used-time-used-shapes.php','Code-used Time-used Shapes','Look for patterns in Code-used Time-used Shapes')
   ,array('summarydata.php','Summary Data', 'Take the summary data and do your own analysis')
   ,array('which-language-is-best.php','Which programming language is best?','Which programming languages have benchmark programs that use less memory or less source code?')
   );

foreach($page as $p){
   printf('<tr>');
   foreach($sites as $s){
      printf('<td><a href="http://shootout.alioth.debian.org/%s/%s" title="%s">%s</a></td>', $s, $p[0], $p[2], $p[1] );
   }
   echo "</tr>";
}

?>

</table>

<p><br/>After all, facts are facts, <br/>and although we may quote one to another with a chuckle <br/>the words of the Wise Statesman, 'Lies--damned lies--and statistics,' <br/>still there are some easy figures the simplest must understand, <br/>and the astutest cannot wriggle out of. <br/><span class="smaller">Leonard Henry Courtney, 1895</span></p>



<p class="imgfooter">&nbsp; <a href="http://shootout.alioth.debian.org/mobile/index.php" title="Handheld Friendly website">Mobile</a> &nbsp; <a href="http://shootout.alioth.debian.org/dont-jump-to-conclusions.php">Conclusions</a> &nbsp; <a href="http://shootout.alioth.debian.org/license.php">License</a> &nbsp; <a href="http://shootout.alioth.debian.org/help.php">Help</a> &nbsp;</p>

</div>


<? include_once("analyticstracking.php") ?>
</body>
</html>
