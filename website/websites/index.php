<?php
ob_start('ob_gzhandler');
$s = time(); $m = floor($s/60); $h = floor($m/60); $rotate = floor($h/7);

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

<meta name="description" content="Compare the performance of ~30 programming languages using ~12 flawed benchmarks and ~1100 programs. Contribute faster more elegant programs." />

<title>Computer Language Benchmarks Game</title>
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/benchmark_css_22dec2009.php" />
<link rel="shortcut icon" href="http://shootout.alioth.debian.org/favicon_ico_11dec2009.php" />
</head>

<body id="core">

<table class="banner"><tr>
<td><h1><a>The&nbsp;Computer&nbsp;<strong>Language</strong>&nbsp; <br/><strong>Benchmarks</strong>&nbsp;Game</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://shootout.alioth.debian.org/help.php" title="How to compare these programming language measurements. How programs were measured. How to contribute programs. FAQs">Help</a></h1></td>
</tr></table>


<?php
$choices = array(
   array('u32','u64q'),
   array('u64q','u32'),
   array('u32q','u64q'),
   array('u64','u32'),
   array('u32q','u64'),
   array('u64','u32q'),
   array('u32','u64'),
   array('u64q','u32q')
   );

$nchoices = sizeof($choices);
$chosen = $choices[$rotate%$nchoices];


$siteTip = array(
   'u32' => ' on one core x86 Ubuntu'
   ,'u32q' =>' on quad-core x86 Ubuntu'
   ,'u64' =>' on one core x64 Ubuntu'
   ,'u64q' =>' on quad-core x64 Ubuntu'
   );
$chosenSiteTip = $siteTip[$chosen[1]];


$testchoices = array(
   'fannkuch'
   ,'knucleotide'
   ,'mandelbrot'
   ,'nbody'
   ,'fasta'
   ,'spectralnorm'
   ,'threadring'
   ,'chameneosredux'
   ,'regexdna'
   ,'pidigits'
   ,'binarytrees'
   ,'revcomp'
   );


$testtips = array(  // SHOULD MATCH $testchoices
   'repeatedly access a tiny integer-sequence'
   ,'repeatedly update hashtables and k-nucleotide strings'
   ,'generate a Mandelbrot set and write a portable bitmap'
   ,'perform an N-body simulation of the Jovian planets'
   ,'generate and write random DNA sequences'
   ,'calculate an eigenvalue using the power method'
   ,'repeatedly switch from thread to thread passing one token'
   ,'repeatedly perform symmetrical thread rendezvous requests'
   ,'match DNA 8-mers and substitute nucleotides for IUB code'
   ,'calculate the digits of Pi with streaming arbitrary-precision arithmetic'
   ,'allocate and deallocate many many binary trees'
   ,'read DNA sequences and write their reverse-complement'
   );

$nchoices = sizeof($testchoices);
$chosentest = $testchoices[$rotate%$nchoices];
$chosenTip = 'Fastest in each programming language to '.$testtips[$rotate%$nchoices];



$pagechoices = array(
   array(
      '/which-programming-languages-are-fastest.php'
      ,'Which programming languages have the fastest benchmark programs'.$chosenSiteTip.'?')
   ,array(
      '/benchmark.php?test='.$chosentest.'&amp;lang=all'
      ,$chosenTip.$chosenSiteTip)
   ,array(
      '/which-programming-languages-are-fastest.php'
      ,'Which programming languages have the fastest benchmark programs'.$chosenSiteTip.'?')
   ,array(
      '/code-used-time-used-shapes.php'
      ,'Look for patterns in Code-used Time-used Shapes'.$chosenSiteTip)
   ,array(
      '/which-programming-languages-are-fastest.php'
      ,'Which programming languages have the fastest benchmark programs'.$chosenSiteTip.'?')
   ,array(
      '/benchmark.php?test='.$chosentest.'&amp;lang=all'
      ,$chosenTip.$chosenSiteTip)
   );

$nchoices = sizeof($pagechoices);
$chosenpage = $pagechoices[$rotate%$nchoices];

$ChosenSite = $chosen[1];
$ChosenUrl = $chosenpage[0];
$ChosenTip = $chosenpage[1];

unset($choices);
unset($siteTip);
unset($testchoices);
unset($testtips);
unset($pagechoices);
?>


<div id="home">
<h5><strong>Compare the performance of &asymp;30 programming languages</strong> <br/>using &asymp;12 <a href="http://shootout.alioth.debian.org/flawed-benchmarks.php"><strong>flawed benchmarks</strong></a> and &asymp;1100 programs</h5>
<p><br/>Read the source code. Contribute faster more elegant programs.</p>
<p><a href="http://shootout.alioth.debian.org/<?=$ChosenSite;?><?=$ChosenUrl;?>" title="<?=$ChosenTip;?>"><strong>Compare performance</strong></a> on both 32 bit and 64 bit Ubuntu&#8482;.</p>
<p>Compare performance both when programs are allowed to use <br/>quad-core and when programs are forced to use one core.</p>

<h5><br/><strong>Programming language performance comparisons</strong> Z to A</h5><br/>


<?php
$u32sites = array('u32','u32q');
$allsites = array('u32','u32q','u64','u64q');

$langs = array(
   array('vw','Smalltalk VisualWorks','uniform reflective environment - real live objects','smalltalk',$allsites),
   array('mzscheme','Scheme PLT','statically-scoped properly tail-recursive dialect of lisp','scheme',$allsites),
   array('scala','Scala','higher-order type-safe programming for jvm','scala',$allsites),
   array('ruby','Ruby MRI','programmer fun - everything is an object scripting','ruby',$allsites),
   array('jruby','JRuby','everything is an object scripting for jvm','jruby',$allsites),
   array('yarv','Ruby 1.9','the new Ruby','',$u32sites),
   array('python','CPython','uncluttered imperative programming plus objects','python',$allsites),
   array('python3','Python 3','the new Python','python3',$u32sites),
   array('php','PHP','scripts embedded in html and much more','php',$allsites),
   array('perl','Perl','server-side shell &amp; cgi scripts','perl',$allsites),
   array('fpascal','Free Pascal','imperative programming plus objects','pascal',$allsites),
   array('ocaml','OCaml','modular type-safe strict functional programming plus objects','ocaml',$allsites),
   array('oz','Mozart/Oz','multi-multi-multi-paradigm distributed programming','oz',$u32sites),
   array('luajit','LuaJIT','jit compiler fully compatible with lua 5.1','luajit',$u32sites),
   array('lua','Lua','associative arrays for extensible embedded scripting','lua',$allsites),
   array('sbcl','Lisp SBCL','pioneering s-expression oriented programming','lisp',$allsites),
   array('lisaac','Lisaac','everything is a prototype object plus design by contract','lisaac',$allsites),
   array('v8','JavaScript V8','web-browser embedded scripting','javascript',$allsites),
   array('tracemonkey','JavaScript TraceMonkey','ubiquitous web-browser embedded scripting','',$allsites),
   array('javasteady','Java 6 steady state','approximate jvm steady state','',$allsites),
   array('javaxint','Java 6 -Xint','ubiquitous bytecode interpreter virtual machine','',$allsites),
   array('java','Java 6 -server','ubiquitous jit server virtual machine','java',$allsites),
   array('ghc','Haskell GHC','lazy pure functional programming','haskell',$allsites),
   array('go','Go 6g 8g','types just are - Go is an experiment','',$allsites),
   array('ifc','Fortran Intel','pioneering numeric and scientific programming','fortran',$allsites),
   array('fsharp','F# Mono','higher-order type-safe programming (mono is not ms .net)','fsharp',$allsites),
   array('hipe','Erlang HiPE','concurrent real-time distributed fault-tolerant software','erlang',$allsites),
   array('clean','Clean','lazy &amp; strict pure functional programming','clean',$allsites),
   array('gpp','C++ GNU','c plus objects plus generics','cpp',$allsites),
   array('csharp','C# Mono','oo plus functional style (mono is not ms .net)','csharp',$allsites),
   array('gcc','C GNU','unchecked low-level programming','c',$allsites),
   array('ats','ATS','dependent types &amp; linear types plus theorem proving','ats',$allsites),
   array('gnat','Ada 2005 GNAT','large-scale safety-critical software','ada',$allsites)
   );


function PrintIncludedLanguages($site,$lang){
   $name = $lang[1];
   $tag = $lang[2];
   if (!empty($lang[3])){ // special_url
       printf('<p><a href="http://shootout.alioth.debian.org/%s/%s.php" title="Compare %s performance against one other programming language">%s</a> <span class="smaller">%s</span></p>',
          $site, $lang[3], $name, $name, $tag);
   } else {
       printf('<p><a href="http://shootout.alioth.debian.org/%s/benchmark.php?test=all&amp;lang=%s" title="Compare %s performance against one other programming language">%s</a> <span class="smaller">%s</span></p>',
          $site, $lang[0], $name, $name, $tag);
   }
}


$site0 = $chosen[0];
$site1 = $chosen[1];
foreach($langs as $i => $lang){
   $sites = $lang[4];
   if (in_array($site0,$sites)){
      PrintIncludedLanguages($site0,$lang);
   } elseif (in_array($site1,$sites)){
      PrintIncludedLanguages($site1,$lang);
   }
}
unset($langs);
?>



<p class="imgfooter">
<a href="http://shootout.alioth.debian.org/license.php" title="The Computer Language Benchmarks Game is published under this revised BSD license" >
   <img src="http://shootout.alioth.debian.org/open_source_button_png_11dec2009.php" alt="Revised BSD license" height="31" width="88" />
</a>
</p>
<p class="imgfooter">&nbsp; <a href="http://shootout.alioth.debian.org/flawed-benchmarks.php">Flawed</a> &nbsp; <a href="http://shootout.alioth.debian.org/which-programming-language-is-fastest.php">Fastest</a> &nbsp; <a href="http://shootout.alioth.debian.org/license.php">License</a> &nbsp; <a href="http://shootout.alioth.debian.org/help.php">Help</a> &nbsp;</p>

</div>

<? include_once('analyticstracking.php'); ?>
</body>
</html>
