<?php

$LANGS= array(
     #Implementation =>
     #{ Lang => 'Language',
     #  Home => 'URL of homepage',
     #  Down => 'URL of download page',
     #  Verfun => sub { }, # function to return version number
     #},

     'gnat' => array(
          'Lang' => 'Ada',
	  'Home' => 'http://www.gnat.com',
	  'Down' => 'ftp://gcc.gnu.org/pub/gcc/releases',
	  'Type' => 'native compiled'
     ),

     'gawk' => array(
         'Lang' => 'Awk',
	 'Home' => 'http://www.gnu.org/software/gawk/gawk.html',
	 'Down' => 'ftp://ftp.gnu.org/gnu/gawk/',
	 'Type' => 'interpreted'
     ),

     'mawk' => array(
         'Lang' => 'Awk',
	 'Home' => 'http://www.math.fu-berlin.de/~leitner/mawk/',
	 'Down' => 'ftp://ftp.fu-berlin.de/pub/unix/languages/mawk/',
	 'Type' => 'interpreted'
     ),

     'bash' => array(
         'Lang' => 'Bash',
	 'Home' => 'http://www.gnu.org/software/bash/bash.html',
	 'Down' => 'ftp://ftp.gnu.org/gnu/bash/',
	 'Type' => 'interpreted'
     ),

     'gcc' => array(
         'Lang' => 'C',
	 'Home' => 'http://gcc.gnu.org/',
	 'Down' => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
	 'Type' => 'native compiled'
     ),

     'g++' => array(
         'Lang' => 'C++',
	 'Home' => 'http://gcc.gnu.org/',
	 'Down' => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
	 'Type' => 'native compiled'
     ),
     
     'clean' => array(
         'Lang' => 'Clean',
	 'Home' => 'http://www.cs.kun.nl/~clean/index.html',
	 'Down' => 'http://www.cs.kun.nl/~clean/Download/main/main.htm',
	 'Type' => 'native compiled'
     ),

     'cmucl' => array(
         'Lang' => 'Common Lisp',
	 'Home' => 'http://www.cons.org/cmucl/',
	 'Down' => 'http://www.cons.org/cmucl/',
	 'Type' => 'native compiled'
     ),

     'sbcl' => array(
         'Lang' => 'Common Lisp',
	 'Home' => 'http://sbcl.sourceforge.net/',
	 'Down' => 'http://sbcl.sourceforge.net/',
	 'Type' => 'native compiled'
     ),


     'gwydion' => array(
         'Lang' => 'Dylan',
	 'Home' => 'http://www.gwydiondylan.org',
	 'Down' => 'http://www.gwydiondylan.org/download.html',
	 'Type' => 'native compiled'
     ),

     'se' => array(
         'Lang' => 'Eiffel',
	 'Home' => 'http://smarteiffel.loria.fr/',
	 'Down' => 'ftp://ftp.loria.fr/pub/loria/SmartEiffel/',
	 'Type' => 'native compiled'
     ),

     'erlang' => array(
         'Lang' => 'Erlang',
	 'Home' => 'http://www.erlang.org/',
	 'Down' => 'http://www.erlang.org/download.html',
	 'Type' => 'bytecomped/interpreted'
     ),

     'hipe' => array(
         'Lang' => 'Erlang',
	 'Home' => 'http://www.erlang.org/',
	 'Down' => 'http://www.erlang.org/download.html',
	 'Type' => 'bytecomped/interpreted'
     ),

     'gforth' => array(
         'Lang' => 'Forth',
	 'Home' => 'http://www.jwdt.com/~paysan/gforth.html',
	 'Down' => 'http://www.complang.tuwien.ac.at/forth/gforth/',
	 'Type' => 'interpreted'
     ),

     'ghc' => array(
         'Lang' => 'Haskell',
	 'Home' => 'http://www.haskell.org/',
	 'Down' => 'http://www.haskell.org/ghc/',
	 'Type' => 'native compiled'
     ),

     'icon' => array(
         'Lang' => 'Icon',
	 'Home' => 'http://www.cs.arizona.edu/icon/',
	 'Down' => 'http://www.cs.arizona.edu/icon/v93.htm',
	 'Type' => 'interpreted'
     ),

     'java' => array(
         'Lang' => 'Java',
	 'Home' => 'http://gcc.gnu.org/java/',
	 'Down' => 'http://gcc.gnu.org/install/binaries.html',
	 'Type' => 'interpreted'
     ),

     'sablevm' => array(
         'Lang' => 'Java',
	 'Home' => 'http://sablevm.org/',
	 'Down' => 'http://sablevm.sourceforge.net/download.html',
	 'Type' => 'interpreted'
     ),

     'lua' => array(
         'Lang' => 'Lua',
	 'Home' => 'http://www.lua.org/',
	 'Down' => 'http://www.lua.org/download.html',
	 'Type' => 'interpreted'
     ),

     'ocaml'=> array(
         'Lang' => 'Ocaml',
	 'Home' => 'http://www.ocaml.org/',
	 'Down' => 'http://caml.inria.fr/ocaml/distrib.html',
	 'Type' => 'native compiled'
     ),

     'ocamlb' => array(
         'Lang' => 'Ocaml',
	 'Home' => 'http://www.ocaml.org/',
	 'Down' => 'http://caml.inria.fr/ocaml/distrib.html',
	 'Type' => 'bytecomped/interpreted'
     ),

     'oz' => array(
         'Lang' => 'Mozart/Oz',
	 'Home' => 'http://www.mozart-oz.org',
	 'Down' => 'http://www.mozart-oz.org/download',
	 'Type' => 'interpreted'
     ),

     'php' => array(
         'Lang' => 'PHP',
	 'Home' => 'http://www.php.net/',
	 'Down' => 'http://www.php.net/downloads.php',
	 'Type' => 'interpreted'
     ),

     'perl' => array(
         'Lang' => 'Perl',
	 'Home' => 'http://www.perl.org/',
	 'Down' => 'http://www.cpan.org/src/5.0/',
	 'Type' => 'bytecomped/interpreted'
     ),

     'pike' => array(
         'Lang' => 'Pike',
	 'Home' => 'http://pike.roxen.com/',
	 'Down' => 'http://pike.roxen.com/download/',
	 'Type' => 'interpreted'
     ),

     'python' => array(
          'Lang' => 'Python',
	  'Home' => 'http://www.python.org/',
	  'Down' => 'http://www.python.org/download/',
	  'Type' => 'bytecomped/interpreted'
     ),

     'rep' => array(
         'Lang' => 'Lisp',
	 'Home' => 'http://librep.sourceforge.net/',
	 'Down' => 'ftp://librep.sourceforge.net/pub/librep/',
	 'Type' => 'bytecomped/interpreted'
     ),

     'ruby' => array(
         'Lang' => 'Ruby',
	 'Home' => 'http://www.ruby-lang.org/',
	 'Down' => 'ftp://ftp.netlab.co.jp/pub/lang/ruby/',
	 'Type' => 'interpreted'
     ),

     'bigloo' => array(
         'Lang' => 'Scheme',
	 'Home' => 'http://www-sop.inria.fr/mimosa/fp/Bigloo/',
	 'Down' => 'http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo-1.html',
	 'Type' => 'native compiled'
     ),

     'guile' => array(
         'Lang' => 'Scheme',
	 'Home' => 'http://www.gnu.org/software/guile/guile.html',
	 'Down' => 'ftp://ftp.gnu.org/pub/gnu/guile/',
	 'Type' => 'interpreted'
     ),

     'mzc' => array(
         'Lang' => 'Scheme',
	 'Home' => 'http://www.plt-scheme.org',
	 'Down' => 'http://download.plt-scheme.org/drscheme/',
	 'Type' => 'native compiled'
     ),

     'mzscheme' => array(
         'Lang' => 'Scheme',
	 'Home' => 'http://www.plt-scheme.org',
	 'Down' => 'http://download.plt-scheme.org/drscheme/',
	 'Type' => 'interpreted'
     ),

     'stalin' => array(
         'Lang' => 'Scheme',
	 'Home' => 'http://www.ece.purdue.edu/~qobi/software.html',
	 'Down' => 'http://www.ece.purdue.edu/~qobi/software.html',
	 'Type' => 'native compiled'
     ),

     'slang' => array(
         'Lang' => 'S-Lang',
	 'Home' => 'http://www.s-lang.org/',
	 'Down' => 'http://www.s-lang.org/download.html',
	 'Type' => 'interpreted'
     ),

     'smlnj' => array(
         'Lang' => 'SML',
	 'Home' => 'http://cm.bell-labs.com/cm/cs/what/smlnj/',
	 'Down' => 'http://cm.bell-labs.com/cm/cs/what/smlnj/software.html',
	 'Type' => 'native compiled'
     ),

     'mlton' => array(
         'Lang' => 'SML',
	 'Home' => 'http://www.mlton.org/',
	 'Down' => 'http://www.mlton.org/download/',
	 'Type' => 'native compiled'
     ),

     'tcl' => array(
         'Lang' => 'Tcl',
	 'Home' => 'http://dev.scriptics.com/',
	 'Down' => 'http://dev.scriptics.com/software/tcltk/downloadnow83.tml',
	 'Type' => 'bytecomped/interpreted'
     ),

     'xemacs' => array(
         'Lang' => 'Emacs Lisp',
	 'Home' => 'http://www.xemacs.org/',
	 'Down' => 'http://www.xemacs.org/Download/',
	 'Type' => 'bytecomped/interpreted'
      )
     );
?>
