%::LANG =
    (
     #Implementation =>
     #{ Lang => 'Language',
     #  Home => 'URL of homepage',
     #  Down => 'URL of download page',
     #  Type => 'native compiled', 'bytecode'
     #  Ext  => 'c', etc.
     #  Verfun => sub { }, # function to return version number
     #},

     gnat =>
     { Lang => 'Ada',
       Home => 'http://www.gnat.com',
       Down => 'ftp://gcc.gnu.org/pub/gcc/releases',
       Type => 'native compiled',
       Ext  => 'ada',
       Verfun => sub {
	   my $ver = `gnat -v`;
	   $ver =~ /(GNAT\s.*)/;
	   return($1);
       },
     },

     gawk =>
     { Lang => 'Awk',
       Home => 'http://www.gnu.org/software/gawk/gawk.html',
       Down => 'ftp://ftp.gnu.org/gnu/gawk/',
       Type => 'interpreted',
       Ext  => 'awk',
       Verfun => sub {
	   my $ver = `$ENV{GAWK} --version`;
	   $ver =~ s/\n.*//s;
	   return($ver);
       },
     },

     mawk =>
     { Lang => 'Awk',
       Home => 'http://www.math.fu-berlin.de/~leitner/mawk/',
       Down => 'ftp://ftp.fu-berlin.de/pub/unix/languages/mawk/',
       Type => 'interpreted',
       Ext  => 'awk',
       Verfun => sub {
	   my $ver = `$ENV{MAWK} -W version 2>/dev/null`;
	   $ver =~ s/\n.*//s;
	   return($ver);
       },
     },

     bash =>
     { Lang => 'Bash',
       Home => 'http://www.gnu.org/software/bash/bash.html',
       Down => 'ftp://ftp.gnu.org/gnu/bash/',
       Type => 'interpreted',
       Ext  => 'sh',
       Verfun => sub {
	   $ENV{BASH} = '/bin/bash';
	   chomp(my $ver = `echo ""|$ENV{BASH} --version`);
	   $ver =~ s/-release.*//s;
	   return($ver);
       },
     },

     gcc =>
     { Lang => 'C',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCC} --version`);
	   $ver =~ s/Copyright.*//s;
	   $ver =~ s/This is free.*//s;
	   return($ver);
       },
     },

     gcj =>
     { Lang => 'Java',
       Home => 'http://gcc.gnu.org/java',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Ext  => 'java',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCJ} --version | grep Debian`);
	   $ver =~ s/(gcj\-\d+\.\d+ \(GCC\) \d+\.\d+\.\d+) .*/\1/;
	   return($ver);
       },
     },

     'g++' =>
     { Lang => 'C++',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GXX} --version`);
	   $ver =~ s/Copyright.*//s;
	   $ver =~ s/This is free.*//s;
	   return($ver);
       },
     },

     'csharp' =>
     { Lang => 'C#',
       Home => 'http://www.go-mono.com/',
       Down => 'http://www.go-mono.com/',
       Type => 'bytecomped/interpreted',
       Ext  => 'cs',
       Verfun => sub {
	   #chomp(my $ver = `$ENV{MONOC} --version`);
	   $ver = '0.96';
	   return($ver);
       },
     },
     
     chicken =>
     { Lang => 'Scheme',
       Home => 'http://www.call-with-current-continuation.org/',
       Down => 'http://www.call-with-current-continuation.org/',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{CHICKEN} -version`;
	   $ver =~ /Version (\d+), Build (\d+) - (.*)/;
	   return("Chicken $1.$2 [$3]");
       },
     },

     clean =>
     { Lang => 'Clean',
       Home => 'http://www.cs.kun.nl/~clean/index.html',
       Down => 'http://www.cs.kun.nl/~clean/Download/main/main.htm',
       Type => 'native compiled',
       Ext  => 'haskell',
       Verfun => sub {
	   my $ver = "Clean 2.1";
	   return($ver);
       },
     },

     cmucl =>
     { Lang => 'Common Lisp',
       Home => 'http://www.cons.org/cmucl/',
       Down => 'http://www.cons.org/cmucl/',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{CMUCL} -batch -eval '(progn (princ (LISP-IMPLEMENTATION-VERSION)) (quit))'`);
	   $ver = "CMU Common Lisp $ver";
	   return($ver);
       },
     },

     sbcl =>
     { Lang => 'Common Lisp',
       Home => 'http://sbcl.sourceforge.net/',
       Down => 'http://sbcl.sourceforge.net/',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SBCL} --version`);
	   return($ver);
       },
     },

     curry =>
     { Lang => 'Haskell',
       Home => 'http://danae.uni-muenster.de/~lux/curry/',
       Down => 'http://danae.uni-muenster.de/~lux/curry/download',
       Type => 'native compiled',
       Ext => 'haskell',
       Verfun => sub {
           chomp(my $ver = `$ENV{CURRY} -v 2>&1`);
	   return ($ver);
       },
     },

     gwydion =>
     { Lang => 'Dylan',
       Home => 'http://www.gwydiondylan.org',
       Down => 'http://www.gwydiondylan.org/download.html',
       Type => 'native compiled',
       Ext  => 'dylan',
       Verfun => sub {
	   my $ver = `$ENV{GWYDION} --version`;
	   $ver =~ /(d2c\s.*)/;
	   return($1);
       },
     },

     se =>
     { Lang => 'Eiffel',
       Home => 'http://smarteiffel.loria.fr/',
       Down => 'ftp://ftp.loria.fr/pub/loria/SmartEiffel/',
       Type => 'native compiled',
       Ext  => 'e',
       Verfun => sub {
	   my $ver = `$ENV{SE} -version`;
	   $ver =~ /(Release\s.*?\))/;
	   return($1);
       },
     },

     elastic =>
     { Lang => 'ElastiC',
       Home => 'http://www.elasticworld.com/',
       Down => 'http://www.elasticworld.com/',
       Type => 'bytecomped/interpreted',
       Ext  => 'c',
       Verfun => sub {
	   my $ver = `$ENV{ELASTICC} -V 2>&1`;
	   $ver =~ s/ecc version.*$//;
	   return($ver);
       },
     },

     erlang =>
     { Lang => 'Erlang',
       Home => 'http://www.erlang.org/',
       Down => 'http://www.erlang.org/download.html',
       Type => 'bytecomped/interpreted',
       Ext  => 'erl',
       Verfun => sub {
	   my $ver = `$ENV{ERLANG} -version 2>&1`;
	   $ver =~ s/\r?\n$//;
	   return($ver);
       },
     },

     hipe =>
     { Lang => 'Erlang',
       Home => 'http://www.erlang.org/',
       Down => 'http://www.erlang.org/download.html',
       Type => 'native compiled',
       Ext  => 'erl',
       Verfun => sub {
	   my $ver = `$ENV{ERLANG} -version 2>&1`;
	   $ver =~ s/\r?\n$//;
	   return($ver);
       },
     },

     felix =>
     { Lang => 'Felix',
       Home => 'http://felix.sourceforge.net/',
       Down => 'http://felix.sourceforge.net/download.html',
       Type => 'native compiled',
       Ext  => 'c',
       Verfun => sub {
	   my $ver = `$ENV{FELIX} --version 2>&1`;
	   return($ver);
       },
     },

     gforth =>
     { Lang => 'Forth',
       Home => 'http://www.jwdt.com/~paysan/gforth.html',
       Down => 'http://www.complang.tuwien.ac.at/forth/gforth/',
       Type => 'interpreted',
       Ext  => '4th',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GFORTH} --version 2>&1`);
	   return($ver);
       },
     },

     ghc =>
     { Lang => 'Haskell',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/ghc/',
       Type => 'native compiled',
       Ext  => 'haskell',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GHC} --version 2>&1`);
	   return($ver);
       },
     },

     hugs =>
     { Lang => 'Haskell',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/hugs/',
       Type => 'interpreted',
       Ext  => 'haskell',
       Verfun => sub {
	   chomp(my $ver = `$ENV{HUGSI} -h 2>&1`);
	   $ver =~ /Version:\s+(.*\d\d\d\d).*\n/;
	   return($1);
       },
     },

     nhc98 =>
     { Lang => 'Haskell',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/nhc98/',
       Type => 'interpreted',
       Ext  => 'haskell',
       Verfun => sub {
	   chomp(my $ver = `$ENV{NHC98} --version 2>&1`);
	   $ver =~ /(v.*)\n/;
	   return($1);
       },
     },

     icon =>
     { Lang => 'Icon',
       Home => 'http://www.cs.arizona.edu/icon/',
       Down => 'http://www.cs.arizona.edu/icon/v93.htm',
       Type => 'interpreted',
       Ext  => 'icn',
       Verfun => sub {
	   chomp(my $ver = `unset STRSIZE BLOCKSIZE COEXPSIZE MSTKSIZE TRACE NOERRBUF ; echo 'procedure main() ; write(&version) ; end' | $ENV{ICON} - -x 2>/dev/null`);
	   unlink("stdin");	# ick, leftover from icon
	   return($ver);
       },
     },

     gij =>
     { Lang => 'Java',
       Home => 'http://gcc.gnu.org/java/',
       Down => 'http://gcc.gnu.org/install/binaries.html',
       Type => 'interpreted',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{GIJ} -version 2>&1`;
	   $ver =~ /(gij.*)\n/;
	   return($1);
       },
     },

     sablevm =>
     { Lang => 'Java',
       Home => 'http://sablevm.org/',
       Down => 'http://sablevm.sourceforge.net/download.html',
       Type => 'interpreted',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{SABLEVM} --version 2>&1`;
	   $ver =~ /(SableVM version.*)\n/;
	   return($1);
       },
     },

     kaffe =>
     { Lang => 'Java',
       Home => 'http://kaffe.org',
       Down => 'http://www.kaffe.org/ftp/pub/kaffe/',
       Type => 'interpreted',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{KAFFE} -version 2>&1`;
	   $ver =~ /(Version.*) Java Version.*/;
	   return($1);
       },
     },

     java =>
     { Lang => 'Java',
       Home => 'http://www.blackdown.org/',
       Down => 'http://www.blackdown.org/',
       Type => 'interpreted',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{JAVA} -version 2>&1`;
	   $ver =~ /(Java HotSpot.*)/;
	   return($1);
       },
     },

     rep =>
     { Lang => 'Lisp',
       Home => 'http://librep.sourceforge.net/',
       Down => 'ftp://librep.sourceforge.net/pub/librep/',
       Type => 'bytecomped/interpreted',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{REP} --version`);
	   return($ver);
       },
     },

     'lua' =>
     { Lang => 'Lua',
       Home => 'http://www.lua.org/',
       Down => 'http://www.lua.org/download.html',
       Type => 'interpreted',
       Ext  => 'lua',
       Verfun => sub {
	   my $ver = `$ENV{LUA} -v 2>&1`;
	   $ver =~ /(Lua.*) Copyright.*/;
	   return($1);
       },
     },

     mercury =>
     { Lang => 'Mercury',
       Home => 'http://www.cs.mu.oz.au/mercury/',
       Down => 'http://www.cs.mu.oz.au/mercury/',
       Type => 'native compiled',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{MMC} --version 2>&1`;
	   $ver =~ /(Mercury Compiler.*)\n/;
	   return($1);
       },
     },

     newlisp =>
     { Lang => 'Lisp',
       Home => 'http://newlisp.org/',
       Down => 'http://newlisp.org/index.cgi?page=Downloads',
       Type => 'interpreted',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{NEWLISP} -h 2>&1`;
	   $ver =~ /(newLISP .*) Copyright.*/;
	   return($1);
       },
     },

     nice =>
     { Lang => 'Nice',
       Home => 'http://nice.sourceforge.net/',
       Down => 'http://nice.sourceforge.net/install.html',
       Type => 'native compiled',
       Ext  => 'nice',
       Verfun => sub {
	   my $ver = `$ENV{NICEC} --version 2>&1`;
	   $ver =~ /(Nice compiler.*)\n/;
	   return($1);
       },
     },

     oberon2 =>
     { Lang => 'Oberon-2',
       Home => 'http://oo2c.sourceforge.net/',
       Down => 'http://oo2c.sourceforge.net/files',
       Type => 'native compiled',
       Ext  => 'oberon',
       Verfun => sub {
	   my $ver = `$ENV{OO2C} --version 2>&1`;
	   $ver =~ s/oo2c\/(\w+) (\d+\.\d+\.\d+)/oo2c \2 (using \1)/;
	   return($ver);
       },
     },

     objc =>
     { Lang => 'Objective C',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCC} --version`);
	   $ver =~ s/Copyright.*//s;
	   $ver =~ s/This is free.*//s;
	   return($ver);
       },
     },

     ocaml =>
     { Lang => 'Ocaml',
       Home => 'http://www.ocaml.org/',
       Down => 'http://caml.inria.fr/ocaml/distrib.html',
       Type => 'native compiled',
       Ext  => 'ml',
       Verfun => sub {
	   my $ver = `$ENV{OCAML} -v`;
	   $ver =~ /^(.*)\n/;
	   return($1);
       },
     },

     ocamlb =>
     { Lang => 'Ocaml',
       Home => 'http://www.ocaml.org/',
       Down => 'http://caml.inria.fr/ocaml/distrib.html',
       Type => 'bytecomped/interpreted',
       Ext  => 'ml',
       Verfun => sub {
	   my $ver = `$ENV{OCAMLB} -v`;
	   $ver =~ /^(.*)\n/;
	   return("$1 (Byte Code)");
       },
     },

     oz =>
     { Lang => 'Mozart/Oz',
       Home => 'http://www.mozart-oz.org',
       Down => 'http://www.mozart-oz.org/download',
       Type => 'interpreted',
       Ext  => 'pro',
       Verfun => sub {
	   my $ver = `$ENV{OZC} -e d 2>&1`;
	   $ver =~ /(Mozart Compiler\s.*)/;
	   return($1);
       },
     },

     php =>
     { Lang => 'PHP',
       Home => 'http://www.php.net/',
       Down => 'http://www.php.net/downloads.php',
       Type => 'interpreted',
       Ext  => 'php',
       Verfun => sub {
	   my $ver = `$ENV{PHP} -v`;
	   $ver =~ s/Copyright.*//s;
	   $ver =~ s/Zend.*//s;
	   return($ver);
       },
     },

     perl =>
     { Lang => 'Perl',
       Home => 'http://www.perl.org/',
       Down => 'http://www.cpan.org/src/5.0/',
       Type => 'bytecomped/interpreted',
       Ext  => 'pl',
       Verfun => sub {
	   my $ver = `$ENV{PERL} -v`;
	   $ver =~ /(This is perl.*)\n/;
	   return($1);
       },
     },

     pike =>
     { Lang => 'Pike',
       Home => 'http://pike.roxen.com/',
       Down => 'http://pike.roxen.com/download/',
       Type => 'bytecomped/interpreted',
       Ext  => 'pike',
       Verfun => sub {
	   my $ver = `$ENV{PIKE} --version 2>&1`;
	   $ver =~ /(Pike v.*?)Copy/;
	   return($1);
       },
     },

     ciao =>
     { Lang => 'Ciao Prolog',
       Home => 'http://www.clip.dia.fi.upm.es',
       Down => 'http://www.clip.dia.fi.upm.es/Software/Ciao/index.html#ciao/',
       Type => 'bytecomped/interpreted',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{CIAOC} 2>&1`;
	   $ver =~ /(Ciao-Prolog.*)/;
	   return ($1);
       },
     },

     gprolog =>
     { Lang => 'Prolog',
       Home => 'http://prolog.inria.fr',
       Down => 'ftp://ftp.inria.fr/INRIA/Projects/contraintes/gprolog',
       Type => 'native compiled',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{GPLC} --version 2>&1`;
	   $ver =~ /(GNU Prolog.*)/;
	   return ($1);
       },
     },

     psyco =>
     { Lang => 'Python',
       Home => 'http://psyco.sourceforge.net/',
       Down => 'http://psyco.sourceforge.net/download.html',
       Type => 'native compiled',
       Ext  => 'py',
       Verfun => sub {
           return('1.2');
       },
     },

     python =>
     { Lang => 'Python',
       Home => 'http://www.python.org/',
       Down => 'http://www.python.org/download/',
       Type => 'bytecomped/interpreted',
       Ext  => 'py',
       Verfun => sub {
	   chomp(my $ver = `$ENV{PYTHON} -c 'import sys; print "Python %d.%d.%d" % sys.version_info[0:3]'`);
	   return($ver);
       },
     },

     ruby =>
     { Lang => 'Ruby',
       Home => 'http://www.ruby-lang.org/',
       Down => 'ftp://ftp.netlab.co.jp/pub/lang/ruby/',
       Type => 'interpreted',
       Ext  => 'rb',
       Verfun => sub {
	   chomp(my $ver = `$ENV{RUBY} -v`);
	   return($ver);
       },
     },

     'bigloo' =>
     { Lang => 'Scheme',
       Home => 'http://www-sop.inria.fr/mimosa/fp/Bigloo/',
       Down => 'http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo-1.html',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{BIGLOO} -version`);
	   return($ver);
       },
     },

     guile =>
     { Lang => 'Scheme',
       Home => 'http://www.gnu.org/software/guile/guile.html',
       Down => 'ftp://ftp.gnu.org/pub/gnu/guile/',
       Type => 'interpreted',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{GUILE} --version`;
	   $ver =~ s/\n.*//s;
	   return($ver);
       },
     },

     mzc =>
     { Lang => 'Scheme',
       Home => 'http://www.plt-scheme.org',
       Down => 'http://download.plt-scheme.org/drscheme/',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{MZC} -h`;
	   $ver =~ s/\n.*//s;
	   $ver =~ s/mzc \[ <flag>.*//s;
	   $ver =~ s/Copyright.*//s;
	   return($ver);
       },
     },

     mzscheme =>
     { Lang => 'Scheme',
       Home => 'http://www.plt-scheme.org',
       Down => 'http://download.plt-scheme.org/drscheme/',
       Type => 'interpreted',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{MZSCHEME} --version`;
	   $ver =~ s/\n.*//s;
	   $ver =~ s/Welcome to//s;
	   $ver =~ s/, Copyright.*//s;
	   return($ver);
       },
     },

     stalin =>
     { Lang => 'Scheme',
       Home => 'http://www.ece.purdue.edu/~qobi/software.html',
       Down => 'http://www.ece.purdue.edu/~qobi/software.html',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
           return('0.9');
       },
     },

     'slang' =>
     { Lang => 'S-Lang',
       Home => 'http://www.s-lang.org/',
       Down => 'http://www-s-lang.org/download.html',
       Type => 'interpreted',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SLANG} --version`);
	   $ver =~ s/slsh.*//;	# Dump the slsh version -- who cares!
	   return($ver);
       },
     },

     'smlnj' =>
     { Lang => 'SML',
       Home => 'http://cm.bell-labs.com/cm/cs/what/smlnj/',
       Down => 'http://cm.bell-labs.com/cm/cs/what/smlnj/software.html',
       Type => 'native compiled',
       Ext  => 'sml',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SMLNJ} </dev/null`);
	   $ver =~ s/\s*\[.*//;
	   return($ver);
       },
     },

     mlton =>
     { Lang => 'SML',
       Home => 'http://www.mlton.org/',
       Down => 'http://www.mlton.org/download/',
       Type => 'native compiled',
       Ext  => 'sml',
       Verfun => sub {
	   chomp(my($ver) = grep(/^mlton/i,`$ENV{MLTON} 2>&1`));
	   $ver =~ s/\(built.*//;
	   return($ver);
       },
     },

     poly =>
     { Lang => 'SML',
       Home => 'http://www.polyml.org/',
       Down => 'http://www.polyml.org/download/',
       Type => 'native compiled',
       Ext  => 'sml',
       Verfun => sub {
	   chomp(my $ver = `$ENV{POLY} -v`);
	   $ver =~ /(version.*)\n/;
	   return($1);
       },
     },

     gst =>
     { Lang => 'Smalltalk',
       Home => 'http://www.gnu.org/software/smalltalk/smalltalk.html',
       Type => 'bytecomped/interpreted',
       Ext => 'rb',
       Verfun => sub {
           chomp(my($ver) = grep(/^GNU.*/i,`$ENV{GST} --version 2>&1`));
	   return ($ver);
       },
     },

     tcl =>
     { Lang => 'Tcl',
       Home => 'http://tcl.tk/',
       Down => 'http://www.tcl.tk/software/tcltk/downloadnow84.tml',
       Type => 'bytecomped/interpreted',
       Ext  => 'tcl',
       Verfun => sub {
	   chomp(my $ver = `echo 'puts [info patchlevel]'|$ENV{TCL}`);
	   return('Tcl ' . $ver);
       },
     },

     xemacs =>
     { Lang => 'Emacs Lisp',
       Home => 'http://www.xemacs.org/',
       Down => 'http://www.xemacs.org/Download/',
       Type => 'bytecomped/interpreted',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{XEMACS} -vanilla -batch -eval '(princ (emacs-version))'`);
	   $ver =~ s/ of .*//;
	   return($ver);
       },
     },
    );

# Used by bin/loc to know the syntax of comments.
%::FAMILY =
    (
     # Language name => Family name
     'Ada'         => 'dash',
     'Awk'         => 'shell',
     'Bash'        => 'shell',
     'bigloo'      => 'lisp',
     'C'           => 'c',
     'C++'         => 'c',
     'C#'          => 'c',
     'Ciao Prolog' => 'prolog',
     'Clean'       => 'c',
     'Common Lisp' => 'lisp',
     'Eiffel'      => 'dash',
     'ElastiC'     => 'c',
     'Erlang'      => 'prolog',
     'Java'        => 'c',
     'Forth'       => 'forth',
     'Haskell'     => 'dash',
     'Dylan'       => 'c',
     'Felix'       => 'c',
     'Icon'        => 'shell',
     'Lua'         => 'dash',
     'Mercury'     => 'prolog',
     'Nice'        => 'c',
     'Oberon-2'    => 'pascal',
     'Objective C' => 'c',
     'Ocaml'       => 'ml',
     'Mozart/Oz'   => 'prolog',
     'Perl'        => 'shell',
     'PHP'         => 'php',
     'Pike'        => 'c',
     'Prolog'      => 'prolog',
     'Python'      => 'shell',
     'Lisp'        => 'lisp',
     'Ruby'        => 'shell',
     'S-Lang'      => 'c',
     'Smalltalk'   => 'smalltalk',
     'SML'         => 'ml',
     'Tcl'         => 'shell',
     'Emacs Lisp'  => 'lisp',
     'Scheme'      => 'scheme',

     # Overrides for specific languages, which seem to belong to a different
     # family that their languages hints at
     'rep'         => 'scheme',
     'mzc'         => 'lisp',
     'mzscheme'    => 'lisp',
 );
