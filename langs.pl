%::LANG =
    (
     #Implementation =>
     #{ Lang => 'Language',
     #  Home => 'URL of homepage',
     #  Down => 'URL of download page',
     #  Verfun => sub { }, # function to return version number
     #},

     gawk =>
     { Lang => 'Awk',
       Home => 'http://www.gnu.org/software/gawk/gawk.html',
       Down => 'ftp://ftp.gnu.org/gnu/gawk/',
       Type => 'interpreted',
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
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCC} --version`);
	   return($ver);
       },
     },

     'g++' =>
     { Lang => 'C++',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GXX} --version`);
	   return($ver);
       },
     },

     se =>
     { Lang => 'Eiffel',
       #Note => '(patched to fix string append bug).',
       Home => 'http://smalleiffel.loria.fr/',
       Down => 'ftp://ftp.loria.fr/pub/loria/genielog/SmallEiffel/',
       Type => 'native compiled',
       Verfun => sub {
	   my $ver = `$ENV{SE} -version`;
	   $ver =~ /(Release\s.*?\))/;
	   return($1);
       },
     },

     erlang =>
     { Lang => 'Erlang',
       Home => 'http://www.erlang.org/',
       Down => 'http://www.erlang.org/download.html',
       Type => 'bytecomped/interpreted',
       Verfun => sub {
	   my $ver = `$ENV{ERLANG} -version 2>&1`;
	   $ver =~ s/\r?\n$//;
	   return($ver);
       },
     },

     gforth =>
     { Lang => 'Forth',
       Home => 'http://www.jwdt.com/~paysan/gforth.html',
       Down => 'http://www.complang.tuwien.ac.at/forth/gforth/',
       Type => 'interpreted',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GFORTH} --version 2>&1`);
	   return($ver);
       },
     },

     bigforth =>
     { Lang => 'Forth',
       Home => 'http://www.jwdt.com/~paysan/bigforth.html',
       Down => 'http://www.jwdt.com/~paysan/bigforth.html',
       Type => 'native compiled',
       Verfun => sub {
	   chomp(my $ver = `strings -a /usr/bin/bigforth| fgrep 'ANS bigFORTH'`);
	   $ver =~ s/.*ANS//;
	   return($ver);
       },
     },

     guile =>
     { Lang => 'Scheme',
       Home => 'http://www.gnu.org/software/guile/guile.html',
       Down => 'ftp://ftp.gnu.org/pub/gnu/guile/',
       Type => 'interpreted',
       Verfun => sub {
	   my $ver = `$ENV{GUILE} --version`;
	   $ver =~ s/\n.*//s;
	   return($ver);
       },
     },

     ghc =>
     { Lang => 'Haskell',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/ghc/',
       Type => 'native compiled',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GHC} --version 2>&1`);
	   return($ver);
       },
     },

     icon =>
     { Lang => 'Icon',
       Home => 'http://www.cs.arizona.edu/icon/',
       Down => 'http://www.cs.arizona.edu/icon/v93.htm',
       Type => 'interpreted',
       Verfun => sub {
	   chomp(my $ver = `unset STRSIZE BLOCKSIZE COEXPSIZE MSTKSIZE TRACE NOERRBUF ; echo 'procedure main() ; write(&version) ; end' | $ENV{ICON} - -x 2>/dev/null`);
	   unlink("stdin");	# ick, leftover from icon
	   return($ver);
       },
     },

     java =>
     { Lang => 'Java',
       Home => 'http://java.sun.com/',
       Down => 'http://java.sun.com/j2se/1.3/',
       Type => 'JIT native compiled',
       Verfun => sub {
	   my $ver = `$ENV{JAVA} -version 2>&1`;
	   $ver =~ /(Java.*Runtime Environment.*)\n/;
	   return($1);
       },
     },

     njs =>
     { Lang => 'Javascript',
       Home => 'http://www.bbassett.net/njs/',
       Down => 'http://www.bbassett.net/njs/download.html',
       Type => 'interpreted',
       Verfun => sub {
	   my $ver = `$ENV{NJS} --version 2>&1`;
	   $ver =~ /(\d+\.\d+\.\d+)/;
	   return($1);
       },
     },

     mercury =>
     { Lang => 'Mercury',
       Home => 'http://www.cs.mu.oz.au/research/mercury/',
       Down => 'http://www.cs.mu.oz.au/research/mercury/download/release.html',
       Type => 'native compiled',
       Verfun => sub {
	   my $ver = `grep MR_VERSION $ENV{MERCURYDIR}/lib/mercury/inc/mercury_conf.h`;
	   $ver =~ /MR_VERSION\D+(\d+\.\d+\.\d+)/;
	   return('Mercury ' . $1);
       },
     },

     lua =>
     { Lang => 'Lua',
       Home => 'http://www.lua.org/',
       Down => 'http://www.lua.org/download.html',
       Type => 'interpreted',
       Verfun => sub {
	   my $ver = `$ENV{LUA} -v`;
	   $ver =~ /^(.*?)\s+Copy/;
	   return($1);
       },
     },

     ocaml =>
     { Lang => 'Ocaml',
       Home => 'http://www.ocaml.org/',
       Down => 'http://caml.inria.fr/ocaml/distrib.html',
       Type => 'native compiled',
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
       Verfun => sub {
	   my $ver = `$ENV{OCAMLB} -v`;
	   $ver =~ /^(.*)\n/;
	   return("$1 (Byte Code)");
       },
     },

     perl =>
     { Lang => 'Perl',
       Home => 'http://www.perl.org/',
       Down => 'http://www.cpan.org/src/5.0/',
       Type => 'bytecomped/interpreted',
       Verfun => sub {
	   my $ver = `$ENV{PERL} -v`;
	   $ver =~ /(This is perl.*)\n/;
	   return($1);
       },
     },

     php =>
     { Lang => 'PHP',
       Home => 'http://www.php.net/',
       Down => 'http://www.php.net/downloads.php',
       Type => 'interpreted',
       Verfun => sub {
	   my $ver = `$ENV{PHP} -v`;
	   return("PHP $ver");
       },
     },

     pike =>
     { Lang => 'Pike',
       Note => '(configured: --with-double-precision).',
       Home => 'http://pike.roxen.com/',
       Down => 'http://pike.roxen.com/download/',
       Type => 'interpreted',
       Verfun => sub {
	   my $ver = `$ENV{PIKE} --version 2>&1`;
	   $ver =~ /(Pike v.*?)Copy/;
	   return($1);
       },
     },

     python =>
     { Lang => 'Python',
       Home => 'http://www.python.org/',
       Down => 'http://www.python.org/download/',
       Type => 'bytecomped/interpreted',
       Verfun => sub {
	   chomp(my $ver = `$ENV{PYTHON} -c 'import sys; print "Python %d.%d.%d" % sys.version_info[0:3]'`);
	   return($ver);
       },
     },

     rep =>
     { Lang => 'Lisp',
       Home => 'http://librep.sourceforge.net/',
       Down => 'ftp://librep.sourceforge.net/pub/librep/',
       Type => 'bytecomped/interpreted',
       Verfun => sub {
	   chomp(my $ver = `$ENV{REP} --version`);
	   return($ver);
       },
     },

     ruby =>
     { Lang => 'Ruby',
       Home => 'http://www.ruby-lang.org/',
       Down => 'ftp://ftp.netlab.co.jp/pub/lang/ruby/',
       Type => 'interpreted',
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
       Verfun => sub {
	   chomp(my $ver = `$ENV{BIGLOO} -version`);
	   return($ver);
       },
     },

     'smlnj' =>
     { Lang => 'SML',
       Home => 'http://cm.bell-labs.com/cm/cs/what/smlnj/',
       Down => 'http://cm.bell-labs.com/cm/cs/what/smlnj/software.html',
       Type => 'native compiled',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SMLNJ} </dev/null`);
	   $ver =~ s/\s*\[.*//;
	   return($ver);
       },
     },

     tcl =>
     { Lang => 'Tcl',
       Home => 'http://dev.scriptics.com/',
       Down => 'http://dev.scriptics.com/software/tcltk/downloadnow83.tml',
       Type => 'bytecomped/interpreted',
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
       Verfun => sub {
	   chomp(my $ver = `$ENV{XEMACS} -vanilla -batch -eval '(princ (emacs-version))'`);
	   $ver =~ s/ of .*//;
	   return($ver);
       },
     },

     cmucl =>
     { Lang => 'Common Lisp',
       Home => 'http://www.cons.org/cmucl/',
       Down => 'http://www.cons.org/cmucl/',
       Type => 'native compiled',
       Verfun => sub {
	   chomp(my $ver = `$ENV{CMUCL} -batch -eval '(progn (princ COMMON-LISP::*LISP-IMPLEMENTATION-VERSION*) (quit))'`);
	   $ver = "CMU Common Lisp $ver";
	   return($ver);
       },
     },

     mlton =>
     { Lang => 'SML',
       Home => 'http://www.sourcelight.com/MLton/',
       Down => 'http://www.sourcelight.com/MLton/',
       Type => 'native compiled',
       Verfun => sub {
	   chomp(my($ver) = grep(/^mlton/i,`$ENV{MLTON} -v 2>&1`));
	   $ver =~ s/\(built.*//;
	   return($ver);
       },
     },

     stalin =>
     { Lang => 'Scheme',
       Home => 'http://www.neci.nec.com/homepages/qobi/software.html',
       Down => 'http://www.neci.nec.com/homepages/qobi/software.html',
       Type => 'native compiled',
       Verfun => sub {
  	   #chomp(my $ver = `$ENV{STALIN} -version`);
  	   return('0.9');
       },
     },

    );
