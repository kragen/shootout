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

<title>Computer Language Benchmarks Game</title>
<link rel="stylesheet" type="text/css" href="http://shootout.alioth.debian.org/benchmark_simple.css" />
</head>

<body>

<?
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
   array('ruby','Ruby MRI','ruby',$basesite),
   array('scala','Scala','scala',$allsites),
   array('vw','Smalltalk VisualWorks','smalltalk',$onecoresites)
   );
?>

<div>
<h1>The Computer Language Benchmarks Game</h1>

<p><a href="http://shootout.alioth.debian.org/mobile/which-programming-languages-are-fastest.php">Which programming languages have the fastest benchmark programs?</a></p>
<p>Compare x86 Ubuntu measurements:</p>
<ol>
<?
foreach($langs as $lang){
   printf('<li>');
   $name = $lang[1];
   $langsites = $lang[3];
   $s = 'u32';
   if (in_array($s,$langsites)){
      if (!empty($lang[2])){
         printf('<a href="http://shootout.alioth.debian.org/mobile/%s.php">%s</a>', $lang[2], $name );
      } else {
         printf('<a href="http://shootout.alioth.debian.org/mobile/compare.php?lang=%s">%s</a>', $lang[0], $name);
      }
   }
   printf('</li>');
}
?>
</ol>
</div>

</body>
</html>
