%::LANG =
    (
     #Implementation =>
     #{ Lang => 'Language',
     #  Name => 'Implementation',
     #  Status => '+', 'X'
     #  Home => 'URL of homepage',
     #  Down => 'URL of download page',
     #  Type => 'native compiled', 'bytecode',
     #  Note => 'Short blurb about the language',
     #  Ext  => 'c', etc.
     #  Verfun => sub { }, # function to return version number
     #},

     gnat =>
     { Lang => 'Ada 95',
       Name => 'GNAT',
       Status => '+',
       Home => 'http://www.gnat.com',
       Down => 'ftp://gcc.gnu.org/pub/gcc/releases',
       Type => 'native compiled',
       Note => 'Large-scale, safety-critical software',
       Ext  => 'ada',
       Verfun => sub {
	   my $ver = `gnatls -v`;
	   $ver =~ /GNATLS\s(.*)\n.*/;
	   return("GNAT $1");
       },
     },

     gawk =>
     { Lang => 'Awk',
       Name => 'gawk',
       Status => '+',
       Home => 'http://www.gnu.org/software/gawk/gawk.html',
       Down => 'ftp://ftp.gnu.org/gnu/gawk/',
       Type => 'interpreted',
       Note => 'GNU AWK',
       Ext  => 'awk',
       Verfun => sub {
	   my $ver = `$ENV{GAWK} --version`;
	   $ver =~ /(GNU\s.*)/;
	   return($1);
       },
     },

     mawk =>
     { Lang => 'Awk',
       Name => 'mawk',
       Status => '+',
       Home => 'http://www.math.fu-berlin.de/~leitner/mawk/',
       Down => 'ftp://ftp.fu-berlin.de/pub/unix/languages/mawk/',
       Type => 'interpreted',
       Note => 'Associative array & string processing',
       Ext  => 'awk',
       Verfun => sub {
	   my $ver = `$ENV{MAWK} -W version 2>/dev/null`;
	   $ver =~ s/\n.*//s;
	   return($ver);
       },
     },

     bash =>
     { Lang => 'Bash',
       Name => 'Bash',
       Status => 'X',
       Home => 'http://www.gnu.org/software/bash/bash.html',
       Down => 'ftp://ftp.gnu.org/gnu/bash/',
       Type => 'interpreted',
       Note => 'Unix shell scripting',
       Ext  => 'sh',
       Verfun => sub {
	   $ENV{BASH} = '/bin/bash';
	   chomp(my $ver = `echo ""|$ENV{BASH} --version`);
	   $ver =~ s/-release.*//s;
	   return($ver);
       },
     },

     bigforth =>
     { Lang => 'Forth',
       Name => 'BigForth',
       Status => '+',
       Home => 'http://bigforth.sourceforge.net',
       Down => 'http://bigforth.sourceforge.net/files',
       Type => 'native compiled',
       Note => 'native code postfix stack programming',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{BIGFORTH} --version 2>&1`);
	   return($ver);
       },
     },

     cyc =>
     { Lang => 'Cyclone',
       Name => 'cyclone',
       Status => '+',
       Home => 'http://cyclone.thelanguage.org/',
       Down => 'http://cyclone.thelanguage.org/wiki/Download',
       Type => 'native compiled',
       Note => 'Concise, checked, safe dialect of C',
       Ext  => 'c',
       Verfun => sub {
       	   $ver="1.0";
	   return($ver);
       },
     },

     gcc =>
     { Lang => 'C',
       Name => 'gcc',
       Status => '+',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Note => 'Concise, unchecked low-level programming',
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
       Name => 'GCJ',
       Status => '+',
       Home => 'http://gcc.gnu.org/java',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Note => 'GNU compiled Java',
       Ext  => 'java',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCJ} --version | grep Debian`);
	   $ver =~ s/(gcj\-\d+\.\d+ \(GCC\) \d+\.\d+\.\d+) .*/$1/;
	   return($ver);
       },
     },

     'icc' =>
     { Lang => 'C',
       Name => 'Intel',
       Status => '+',
       Home => 'http://www.intel.com/software/products/compilers/linux',
       Down => 'http://www.intel.com/software/products/compilers/clin/',
       Type => 'native compiled',
       Note => 'C plus objects plus generics',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{ICPP} --version`);
	   return("Intel C++ Compiler Version $ver");
       },
     },

     'icpp' =>
     { Lang => 'C++',
       Name => 'Intel',
       Status => '+',
       Home => 'http://www.intel.com/software/products/compilers/linux',
       Down => 'http://www.intel.com/software/products/compilers/clin/',
       Type => 'native compiled',
       Note => 'C plus objects plus generics',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{ICPP} --version`);
	   return("Intel C++ Compiler Version $ver");
       },
     },

     'gpp' =>
     { Lang => 'C++',
       Name => 'g++',
       Status => '+',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Note => 'C plus objects plus generics',
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
       Name => 'Mono',
       Status => '+',
       Home => 'http://www.go-mono.com/',
       Down => 'http://www.go-mono.com/',
       Type => 'bytecomped/interpreted',
       Note => 'GNOME project EMCA C#',
       Ext  => 'cs',
       Verfun => sub {
	   chomp(my $ver = `$ENV{MONOC} --version 2>&1`);
	   return($ver);
       },
     },


     'fsharp' =>
     { Lang => 'F#',
       Name => 'Mono',
       Status => '+',
       Home => 'http://www.go-mono.com/',
       Down => 'http://www.go-mono.com/',
       Type => 'bytecomped/interpreted',
       Note => 'F#',
       Ext  => 'fs',
       Verfun => sub {
	   chomp(my $ver = `$ENV{MONOC} --version 2>&1`);
	   return($ver);
       },
     },
     
     'pnet' =>
     { Lang => 'C#',
       Name => 'Portable.NET,',
       Status => '+',
       Home => 'http://www.gnu.org/software/dotgnu/',
       Down => 'http://www.gnu.org/software/dotgnu/',
       Type => 'bytecomped/interpreted',
       Note => 'GNOME project EMCA C#',
       Ext  => 'cs',
       Verfun => sub {
	   chomp(my $ver = `$ENV{MONOC} --version 2>&1`);
	   return($ver);
       },
     },

     chicken =>
     { Lang => 'Scheme',
       Name => 'Chicken',
       Home => 'http://www.call-with-current-continuation.org/',
       Down => 'http://www.call-with-current-continuation.org/',
       Status => '+',
       Note => 'Efficient compiled Scheme',
       Type => 'native compiled',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{CHICKEN} -version | grep Version`);
	   return($ver);
       },
     },

     clean =>
     { Lang => 'Clean',
       Name => 'Clean',
       Status => '+',
       Home => 'http://www.cs.kun.nl/~clean/index.html',
       Down => 'http://www.cs.kun.nl/~clean/Download/main/main.htm',
       Type => 'native compiled',
       Note => 'Lazy & strict, pure functional programming',
       Ext  => 'haskell',
       Verfun => sub {
	   my $ver = "Clean 2.2";
	   return($ver);
       },
     },

     dlang =>
     { Lang => 'D',
       Name => 'Digitalmars D',
       Status => '+',
       Home => 'http://digitalmars.com/d/dcompiler.html',
       Down => 'http://digitalmars.com/d/dcompiler.html#linux',
       Type => 'native compiled',
       Note => 'A reimagined, reinvigorated C++ (with batteries)',
       Ext => 'd',
       Verfun => sub {
          chomp(my $ver = `$ENV{DLANG} -v`);
	  $ver =~ /(Digital.*)\n/;
	  return ($1);
       },
     },

     io =>
     { Lang => 'Io',
       Name => 'Io',
       Status => '+',
       Home => 'http://www.iolanguage.com/about/',
       Down => 'http://www.iolanguage.com/downloads/',
       Type => 'bytecomped/interpreted',
       Note => 'Small simple prototype based OO programming',
       Ext => 'io',
       Verfun => sub {
          chomp(my $ver = `$ENV{IO} --version`);
	  return ($ver);
       },
     },

     cmucl =>
     { Lang => 'Lisp',
       Name => 'CMUCL',
       Status => '+',
       Home => 'http://www.cons.org/cmucl/',
       Down => 'http://www.cons.org/cmucl/',
       Type => 'native compiled',
       Note => 'Large-scale and explorative programming',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{CMUCL} -batch -eval '(progn (princ (LISP-IMPLEMENTATION-VERSION)) (quit))'`);
	   $ver = "CMU Common Lisp $ver";
	   return($ver);
       },
     },

     sbcl =>
     { Lang => 'Lisp',
       Name => 'SBCL',
       Status => '+',
       Home => 'http://sbcl.sourceforge.net/',
       Down => 'http://sbcl.sourceforge.net/',
       Type => 'native compiled',
       Note => 'CMU CL fork with greater emphasis on maintainability',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SBCL} --version`);
	   return($ver);
       },
     },

     scala =>
     { Lang => 'scala',
       Name => 'scala',
       Status => 'X',
       Home => 'http://scala.epfl.ch/',
       Down => 'http://scala.epfl.ch/downloads/index.html',
       Type => 'bytecomped/interpreted',
       Note => 'Modern multi-paradigm programming',
       Ext => 'scala',
       Verfun => sub {
           chomp(my $ver = `$ENV{SCALA} -version 2>&1`);
	   return ($ver);
       },
     },

     curry =>
     { Lang => 'Curry',
       Name => 'Curry',
       Status => 'X',
       Home => 'http://danae.uni-muenster.de/~lux/curry/',
       Down => 'http://danae.uni-muenster.de/~lux/curry/download',
       Type => 'native compiled',
       Note => 'Functional & logic programming',
       Ext => 'haskell',
       Verfun => sub {
           chomp(my $ver = `$ENV{CURRY} -v 2>&1`);
	   return ($ver);
       },
     },

     gwydion =>
     { Lang => 'Dylan',
       Name => 'Gwydion',
       Status => '+',
       Home => 'http://www.gwydiondylan.org',
       Down => 'http://www.gwydiondylan.org/download.html',
       Type => 'native compiled',
       Note => 'Multi-method OO with type inference',
       Ext  => 'dylan',
       Verfun => sub {
	   my $ver = `$ENV{GWYDION} --version`;
	   $ver =~ /(d2c\s.*)/;
	   return($1);
       },
     },

     se =>
     { Lang => 'Eiffel',
       Name => 'SmartEiffel',
       Status => '+',
       Home => 'http://smarteiffel.loria.fr/',
       Down => 'ftp://ftp.loria.fr/pub/loria/SmartEiffel/',
       Type => 'native compiled',
       Note => 'Pure OO software engineering with Design by Contract',
       Ext  => 'e',
       Verfun => sub {
	   my $ver = `$ENV{SE} -version`;
	   $ver =~ /(Release\s.*?\))/;
	   return("SmartEiffel $1");
       },
     },

     erlang =>
     { Lang => 'Erlang',
       Name => 'Erlang',
       Status => '+',
       Home => 'http://www.erlang.org/',
       Down => 'http://www.erlang.org/download.html',
       Type => 'bytecomped/interpreted',
       Note => 'Concurrent, real-time distributed fault-tolerant software',
       Ext  => 'erl',
       Verfun => sub {
	   my $ver = `$ENV{ERLANG} -version 2>&1`;
	   $ver =~ s/\r?\n$//;
	   return($ver);
       },
     },

     hipe =>
     { Lang => 'Erlang',
       Name => 'hipe',
       Status => '+',
       Home => 'http://www.erlang.org/',
       Down => 'http://www.erlang.org/download.html',
       Type => 'native compiled',
       Note => 'Concurrent, real-time distributed fault-tolerant software, JIT compiler',
       Ext  => 'erl',
       Verfun => sub {
	   my $ver = `$ENV{ERLANG} -version 2>&1`;
	   $ver =~ s/\r?\n$//;
	   return($ver);
       },
     },

     felix =>
     { Lang => 'Felix',
       Name => 'Felix',
       Status => '+',
       Home => 'http://felix.sourceforge.net/',
       Down => 'http://felix.sourceforge.net/download.html',
       Type => 'native compiled',
       Note => 'ML-style type system with C++-friendly syntax',
       Ext  => 'flx',
       Verfun => sub {
	   my $ver = `$ENV{FELIX} --version 2>&1`;
	   return("Felix $ver");
       },
     },

     ifc =>
     { Lang => 'Fortran',
       Name => 'Intel',
       Status => '+',
       Home => 'http://www.intel.com/software/products/compilers/linux',
       Down => 'http://www.intel.com/software/products/compilers/flin/',
       Type => 'native compiled',
       Note => 'Legendary Number Cruncher',
       Ext  => 'f90',
       Verfun => sub {
	   chomp(my $ver = `$ENV{IFC} -V 2>&1`);
	   return("Intel Fortran Compiler Version $ver");
       },
     },

     g95 =>
     { Lang => 'Fortran',
       Name => 'G95',
       Status => '+',
       Home => 'http://www.g95.org',
       Down => 'http://sourceforge.net/projects/g95/',
       Type => 'native compiled',
       Note => 'Free Legendary Number Cruncher',
       Ext  => 'f90',
       Verfun => sub {
	   chomp(my $ver = `$ENV{G95} --version 2>&1`);
	   $ver =~ /(G95.*)\n.*/;
	   return($1);
       },
     },

     gfortran =>
     { Lang => 'Fortran',
       Name => 'GNU',
       Status => '+',
       Home => 'http://gcc.gnu.org/fortran/',
       Down => 'http://gcc.gnu.org/install/binaries.html',
       Type => 'native compiled',
       Note => 'Free Legendary Number Cruncher',
       Ext  => 'f90',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GFORTRAN} --version 2>&1`);
	   $ver =~ /(GNU Fortran 95.*)\n.*/;
	   return($1);
       },
     },

     gcl =>
     { Lang => 'Lisp',
       Name => 'GNU Common Lisp',
       Status => '+',
       Home => 'http://www.gnu.org/software/gcl/gcl.html',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcl/',
       Type => 'native compiled',
       Note => 'Basis for Maxima, ACL2, and Axiom',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCL} -eval '(quit)'`);
	   $ver =~ /(GCL.*)\n/;
	   return($1);
       },
     },

     gforth =>
     { Lang => 'Forth',
       Name => 'GForth',
       Status => '+',
       Home => 'http://www.jwdt.com/~paysan/gforth.html',
       Down => 'http://www.complang.tuwien.ac.at/forth/gforth/',
       Type => 'interpreted',
       Note => 'GNU postfix stack programming',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GFORTH} --version 2>&1`);
	   return($ver);
       },
     },

     groovy =>
     { Lang => 'Groovy',
       Name => 'Groovy',
       Status => '+',
       Home => 'http://groovy.codehaus.org/',
       Down => 'http://groovy.codehaus.org/Download',
       Type => 'interpreted',
       Note => 'Agile dynamic language for the JVM',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GROOVY} --version 2>&1`);
	   return($ver);
       },
     },

     ghc =>
     { Lang => 'Haskell',
       Name => 'GHC',
       Status => '+',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/ghc/',
       Type => 'native compiled',
       Note => 'Lazy, pure functional language',
       Ext  => 'haskell',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GHC} --version 2>&1`);
	   return($ver);
       },
     },

     hugs =>
     { Lang => 'Haskell',
       Name => 'HUGS',
       Status => 'X',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/hugs/',
       Type => 'interpreted',
       Note => 'University-favored Haskell interpreter',
       Ext  => 'haskell',
       Verfun => sub {
	   chomp(my $ver = `$ENV{HUGSI} -h 2>&1`);
	   $ver =~ /(Version:\s+.*\d\d\d\d).*\n/;
	   return("HUGS $1");
       },
     },

     nhc98 =>
     { Lang => 'Haskell',
       Name => 'nhc98',
       Status => 'X',
       Home => 'http://www.haskell.org/',
       Down => 'http://www.haskell.org/nhc98/',
       Type => 'interpreted',
       Note => 'Efficient, portable Haskell implementation',
       Ext  => 'haskell',
       Verfun => sub {
	   chomp(my $ver = `$ENV{NHC98} --version 2>&1`);
	   $ver =~ /(nhc98: v.*)\n/;
	   return($1);
       },
     },

     icon =>
     { Lang => 'Icon',
       Name => 'Icon',
       Status => '+',
       Home => 'http://www.cs.arizona.edu/icon/',
       Down => 'http://www.cs.arizona.edu/icon/v93.htm',
       Type => 'interpreted',
       Note => 'High-level string processing',
       Ext  => 'icn',
       Verfun => sub {
	   chomp(my $ver = `unset STRSIZE BLOCKSIZE COEXPSIZE MSTKSIZE TRACE NOERRBUF ; echo 'procedure main() ; write(&version) ; end' | $ENV{ICON} - -x 2>/dev/null`);
	   unlink("stdin");	# ick, leftover from icon
	   return($ver);
       },
     },

     gij =>
     { Lang => 'Java',
       Name => 'GIJ',
       Status => '+',
       Home => 'http://gcc.gnu.org/java/',
       Down => 'http://gcc.gnu.org/install/binaries.html',
       Type => 'interpreted',
       Note => 'GNU interpreted Java',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{GIJ} -version 2>&1`;
	   $ver =~ /(gij.*)\n/;
	   return($1);
       },
     },

     sablevm =>
     { Lang => 'Java',
       Name => 'SableVM',
       Status => '+',
       Home => 'http://sablevm.org/',
       Down => 'http://sablevm.sourceforge.net/download.html',
       Type => 'interpreted',
       Note => 'Clean-room, standards-compliant Java VM and libraries',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{SABLEVM} --version 2>&1`;
	   $ver =~ /(SableVM version.*)\n/;
	   return($1);
       },
     },

     kaffe =>
     { Lang => 'Java',
       Name => 'Kaffe',
       Status => '+',
       Home => 'http://kaffe.org',
       Down => 'http://www.kaffe.org/ftp/pub/kaffe/',
       Type => 'interpreted',
       Note => 'Clean room Java VM and libraries',
       Ext  => 'java',
       Verfun => sub {
	   my $out = `$ENV{KAFFE} -fullversion 2>&1`;
	   $out =~ /Version: *([^ ]*) +Java Version.*/;
	   my $ver = $1;
	   if ($out =~ /ChangeLog head   : ([^ ]+)/) {
	       my $date = $1;
	       return("Kaffe $ver ($date)");
	   } else {
	       return("Kaffe $ver");
	   }
       },
     },

     java =>
     { Lang => 'Java',
       Name => 'Java',
       Status => '+',
       Home => 'http://www.sun.com/',
       Down => 'http://www.sun.com/',
       Type => 'interpreted',
       Note => 'Official SUN Java with HotSpot',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{JAVA} -version -server 2>&1`;
	   $ver =~ /(Java HotSpot.*)/;
	   return($1);
       },
     },

     java14 =>
     { Lang => 'Java',
       Name => 'Java',
       Status => '+',
       Home => 'http://www.sun.com/',
       Down => 'http://www.sun.com/',
       Type => 'interpreted',
       Note => 'Official SUN Java 1.4 with HotSpot',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{JAVA14} -version -server 2>&1`;
	   $ver =~ /(Java HotSpot.*)/;
	   return($1);
       },
     },

     javaxint =>
     { Lang => 'Java',
       Name => 'Xint',
       Status => '+',
       Home => 'http://www.sun.com/',
       Down => 'http://www.sun.com/',
       Type => 'interpreted',
       Note => 'Ubiquitous JIT Virtual Machine',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{JAVA} -version -server 2>&1`;
	   $ver =~ /(Java HotSpot.*)/;
	   return($1);
       },
     },
     
     javaclient =>
     { Lang => 'Java',
       Name => 'Java -client',
       Status => '+',
       Home => 'http://www.sun.com/',
       Down => 'http://www.sun.com/',
       Type => 'interpreted',
       Note => 'Ubiquitous JIT Virtual Machine',
       Ext  => 'java',
       Verfun => sub {
	   my $ver = `$ENV{JAVA} -version -client 2>&1`;
	   $ver =~ /(Java HotSpot.*)/;
	   return($1);
       },
     },
     
     'javascript' =>
     { Lang => 'JavaScript',
       Name => 'SpiderMonkey',
       Status => '+',
       Home => 'http://www.mozilla.org/js/language/',
       Down => 'http://www.mozilla.org/js/spidermonkey/',
       Type => 'interpreted',
       Note => '',
       Ext  => 'js',
       Verfun => sub {
	   my $ver = `$ENV{JAVASCRIPT} -v 2>&1`;
	   $ver =~ /(JavaScript-C.*)\n/;
	   return($1);
       },
     },     
     
     rep =>
     { Lang => 'Lisp',
       Name => 'librep',
       Status => '+',
       Home => 'http://librep.sourceforge.net/',
       Down => 'ftp://librep.sourceforge.net/pub/librep/',
       Type => 'bytecomped/interpreted',
       Note => 'Lisp reborn as a scripting and extension language',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{REP} --version`);
	   return($ver);
       },
     },

     'lua' =>
     { Lang => 'Lua',
       Name => 'Lua',
       Status => '+',
       Home => 'http://www.lua.org/',
       Down => 'http://www.lua.org/download.html',
       Type => 'interpreted',
       Note => 'Simple, extensible, embedded scripting',
       Ext  => 'lua',
       Verfun => sub {
	   my $ver = `$ENV{LUA} -v 2>&1`;
	   $ver =~ /(Lua.*) Copyright.*/;
	   return($1);
       },
     },

     mercury =>
     { Lang => 'Mercury',
       Name => 'Mercury',
       Status => '+',
       Home => 'http://www.cs.mu.oz.au/mercury/',
       Down => 'http://www.cs.mu.oz.au/mercury/',
       Type => 'native compiled',
       Note => 'Functional & logic programming',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{MMC} --version 2>&1`;
	   $ver =~ /(Mercury Compiler.*)\n/;
	   return($1);
       },
     },

     newlisp =>
     { Lang => 'Lisp',
       Name => 'Newlisp',
       Status => '+',
       Home => 'http://newlisp.org/',
       Down => 'http://newlisp.org/index.cgi?page=Downloads',
       Type => 'interpreted',
       Note => 'Lisp reborn as a scripting language, again',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{NEWLISP} -h 2>&1`;
	   $ver =~ /(newLISP .*) Copyright.*/;
	   return($1);
       },
     },

     nice =>
     { Lang => 'Nice',
       Name => 'Nice',
       Status => 'X',
       Home => 'http://nice.sourceforge.net/',
       Down => 'http://nice.sourceforge.net/install.html',
       Type => 'interpreted',
       Note => 'Safe multi-method OO for JVM',
       Ext  => 'nice',
       Verfun => sub {
	   my $ver = `$ENV{NICEC} --version 2>&1`;
	   $ver =~ /(Nice compiler.*)\n/;
	   return($1);
       },
     },

     objc =>
     { Lang => 'Objective C',
       Name => 'GNU',
       Status => 'X',
       Home => 'http://gcc.gnu.org/',
       Down => 'ftp://ftp.gnu.org/pub/gnu/gcc/',
       Type => 'native compiled',
       Note => 'OO superset of C with a Smalltalk-style syntax',
       Ext  => 'objc',
       Verfun => sub {
	   chomp(my $ver = `$ENV{GCC} --version`);
	   $ver =~ s/Copyright.*//s;
	   $ver =~ s/This is free.*//s;
	   return($ver);
       },
     },

     ocaml =>
     { Lang => 'OCaml',
       Name => 'OCaml',
       Status => '+',
       Home => 'http://caml.inria.fr/',
       Down => 'http://caml.inria.fr/ocaml/distrib.html',
       Type => 'native compiled',
       Note => 'OO integreated with ML',
       Ext  => 'ml',
       Verfun => sub {
	   my $ver = `$ENV{OCAML} -v`;
	   $ver =~ /^(.*)\n/;
	   return($1);
       },
     },

     ocamlb =>
     { Lang => 'OCaml',
       Name => '(bytecode)',
       Status => 'X',
       Home => 'http://www.ocaml.org/',
       Down => 'http://caml.inria.fr/ocaml/distrib.html',
       Type => 'bytecomped/interpreted',
       Note => 'OO integreated with ML (bytecode)',
       Ext  => 'ml',
       Verfun => sub {
	   my $ver = `$ENV{OCAMLB} -v`;
	   $ver =~ /^(.*)\n/;
	   return("$1 (Byte Code)");
       },
     },
          
     octave =>
     { Lang => 'octave',
       Name => 'GNU Octave',
       Status => 'X',
       Home => 'http://www.gnu.org/software/octave/',
       Down => 'http://www.gnu.org/software/octave/download.html',
       Type => 'bytecomped/interpreted',
       Note => 'Matlab-compatible, free, numerical computing',
       Ext  => 'm',
       Verfun => sub {
	   my $ver = `$ENV{OCTAVE} -v`;
	   $ver =~ /^GNU Octave, (.*)\n/;
	   return("$1");
       },
     },
          
     ooc =>
     { Lang => 'Oberon-2',
       Name => 'OO2C',
       Status => '+',
       Home => 'http://oo2c.sourceforge.net/',
       Down => 'http://oo2c.sourceforge.net/files',
       Type => 'native compiled',
       Note => 'Lean component development: modules & OO',
       Ext  => 'oberon',
       Verfun => sub {
	   my $ver = `$ENV{OOC} --version 2>&1`;
	   $ver =~ s/oo2c\/(\w+) (\d+\.\d+\.\d+)/oo2c $2 (using $1)/;
	   return($ver);
       },
     },               

     xds =>
     { Lang => 'Oberon-2',
       Name => 'XDS',
       Status => '+',
       Home => 'http://www.excelsior-usa.com/xdsdl.html',
       Down => 'http://www.excelsior-usa.com/xdsdl.html?h=4B4D4538345F3034544C45452E524547',
       Type => 'native compiled',
       Note => 'Proprietary Oberon-2, with native code generator',
       Ext  => 'oberon',
       Verfun => sub {
	   my $ver = `$ENV{XDS} =help 2>&1`;
	   $ver =~ /^(.*)\n/;
	   return("$1");
       },
     },               

     oz =>
     { Lang => 'Mozart/Oz',
       Name => 'Mozart/Oz',
       Status => 'X',
       Home => 'http://www.mozart-oz.org',
       Down => 'http://www.mozart-oz.org/download',
       Type => 'interpreted',
       Note => 'Multi-paradigm, distributed programming',
       Ext  => 'oz',
       Verfun => sub {
	   my $ver = `$ENV{OZC} -e d 2>&1`;
	   $ver =~ /(Mozart Compiler\s.*)/;
	   return($1);
       },
     },

     fpascal =>
     { Lang => 'Pascal',
       Name => 'Free Pascal',
       Status => '+',
       Home => 'http://www.freepascal.org',
       Down => 'http://www.freepascal.org/download.html',
       Type => 'native compiled',
       Note => 'Structured programming plus objects',
       Ext  => 'pas',
       Verfun => sub {
           my $ver = `$ENV{FPASCAL} -i`;
	   $ver =~ /(Free Pascal.*version [\d\.]+)/;
	   return $1;
       },
     },

     php =>
     { Lang => 'PHP',
       Home => 'http://www.php.net/',
       Status => '+',
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

     parrot =>
     { Lang => 'Parrot',
       Name => 'Parrot VM',
       Status => '+',
       Home => 'http://www.parrotcode.org/',
       Down => 'http://www.parrotcode.org/source.html',
       Type => 'bytecomped/interpreted',
       Note => 'April Fool prank turned scripting engine core',
       Ext  => 'asm',
       Verfun => sub {
          my $ver = `$ENV{PARROT} -V`;
	  $ver =~ /(PASM\/PIR compiler.*)\n/;
	  return ($1);
       },
     },

     perl =>
     { Lang => 'Perl',
       Name => 'Perl',
       Status => '+',
       Home => 'http://www.perl.org/',
       Down => 'http://www.cpan.org/src/5.0/',
       Type => 'bytecomped/interpreted',
       Note => 'Server-side shell & CGI scripts',
       Ext  => 'pl',
       Verfun => sub {
	   my $ver = `$ENV{PERL} -v`;
	   $ver =~ /(This is perl.*)\n/;
	   return($1);
       },
     },

     pike =>
     { Lang => 'Pike',
       Name => 'Pike',
       Status => '+',
       Home => 'http://pike.roxen.com/',
       Down => 'http://pike.roxen.com/download/',
       Type => 'bytecomped/interpreted',
       Note => 'Scripting with explicit types',
       Ext  => 'pike',
       Verfun => sub {
	   my $ver = `$ENV{PIKE} --version 2>&1`;
	   $ver =~ /(Pike v.*?)Copy/;
	   return($1);
       },
     },

     poplisp =>
     { Lang => 'Lisp',
       Name => 'Poplisp',
       Status => 'X',
       Home => 'http://www.cs.bham.ac.uk/research/poplog/freepoplog.html/',
       Down => 'http://www.cs.bham.ac.uk/research/poplog/new/',
       Type => 'bytecomped/interpreted',
       Note => 'Lisp hosted in Poplog',
       Ext  => 'lisp',
       Verfun => sub {
           my $tmp = `$ENV{POP11} ":popversion=>" 2>&1`;
	   $tmp =~ /.*\s\((Version\s\d\d\.\d\d).*/;
	   my $val = "$1-Lisp ";
           $tmp = `$ENV{POPLISP} ":(lisp-implementation-version)" 2>&1`;
	   $tmp =~ /(\d+\.\d+)/;
	   $val .= "$1";
	   return ("Poplog hosted Common Lisp: $val");
       },
     },

     pop11 =>
     { Lang => 'Pop11',
       Name => 'Pop11',
       Status => 'X',
       Home => 'http://www.cs.bham.ac.uk/research/poplog/freepoplog.html/',
       Down => 'http://www.cs.bham.ac.uk/research/poplog/new/',
       Type => 'bytecomped/interpreted',
       Note => 'Multi-paradigm, multi-language core',
       Ext  => 'c',
       Verfun => sub {
           my $val = `$ENV{POP11} ":popversion=>" 2>&1`;
	   $val =~ /.*\s\((Version\s\d\d\.\d\d).*/;
	   return ("pop11 $1");
       },
     },

     popsml =>
     { Lang => 'SML',
       Name => 'PSML',
       Status => 'X',
       Home => 'http://www.cs.bham.ac.uk/research/poplog/freepoplog.html/',
       Down => 'http://www.cs.bham.ac.uk/research/poplog/new/',
       Type => 'bytecomped/interpreted',
       Note => 'SML hosted in Poplog',
       Ext  => 'sml',
       Verfun => sub {
           my $val = `$ENV{POP11} ":popversion=>" 2>&1`;
	   $val =~ /.*\s\((Version\s\d\d\.\d\d).*/;
	   return ("Poplog Hosted SML: $1");
       },
     },

     ciao =>
     { Lang => 'Prolog',
       Name => 'Ciao',
       Status => 'X',
       Home => 'http://www.clip.dia.fi.upm.es',
       Down => 'http://www.clip.dia.fi.upm.es/Software/Ciao/index.html#ciao/',
       Type => 'bytecomped/interpreted',
       Note => 'Constraint-enhanced Prolog platform',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{CIAOC} 2>&1`;
	   $ver =~ /(Ciao-Prolog.*)/;
	   return ($1);
       },
     },

     gprolog =>
     { Lang => 'Prolog',
       Name => 'GNU',
       Status => 'X',
       Home => 'http://prolog.inria.fr',
       Down => 'ftp://ftp.inria.fr/INRIA/Projects/contraintes/gprolog',
       Type => 'native compiled',
       Note => 'Logic and constraint logic programming',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{GPLC} --version 2>&1`;
	   $ver =~ /(Prolog.*\d\d)/;
	   return ($1);
       },
     },

     swiprolog =>
     { Lang => 'Prolog',
       Name => 'SWI',
       Status => 'X',
       Home => 'http://www.swi-prolog.org',
       Down => 'http://www.swi-prolog.org/download.html',
       Type => 'bytecomped/interpreted',
       Note => 'Comprehensive, portable Prolog compiler',
       Ext  => 'pro',
       Verfun => sub {
           my $ver = `$ENV{SWIPROLOG} -v 2>&1`;
	   return ($ver);
       },
     },

     psyco =>
     { Lang => 'Python',
       Name => 'Psyco',
       Status => 'X',
       Home => 'http://psyco.sourceforge.net/',
       Down => 'http://psyco.sourceforge.net/download.html',
       Type => 'native compiled',
       Note => 'Python, compiled for speed',
       Ext  => 'py',
       Verfun => sub {
           return('Psyco 1.2');
       },
     },

     python =>
     { Lang => 'Python',
       Name => 'Python',
       Status => '+',
       Home => 'http://www.python.org/',
       Down => 'http://www.python.org/download/',
       Type => 'bytecomped/interpreted',
       Note => 'Interpreted, interactive, OO language',
       Ext  => 'py',
       Verfun => sub {
	   chomp(my $ver = `$ENV{PYTHON} -c 'import sys; print "Python %d.%d.%d" % sys.version_info[0:3]'`);
	   return($ver);
       },
     },

     iron =>
     { Lang => 'Python',
       Name => 'IronPython',
       Status => '+',
       Home => 'http://www.gotdotnet.com/workspaces/workspace.aspx?id=ad7acff7-ab1e-4bcb-99c0-57ac5a3a9742',
       Down => 'http://www.microsoft.com/downloads/details.aspx?FamilyID=e4058d5f-49ec-47cb-899e-c4f781e6648f&displaylang=en',
       Type => 'bytecomped/interpreted',
       Note => 'Interpreted, interactive, OO language on C# VM',
       Ext  => 'py',
       Verfun => sub {
	   chomp(my $ver = `$ENV{IRON} -V`);
	   return($ver);
       },
     },

     ruby =>
     { Lang => 'Ruby',
       Name => 'Ruby',
       Status => '+',
       Home => 'http://www.ruby-lang.org/',
       Down => 'ftp://ftp.netlab.co.jp/pub/lang/ruby/',
       Type => 'interpreted',
       Note => 'Pure OO - everything is an object - scripting',
       Ext  => 'rb',
       Verfun => sub {
	   chomp(my $ver = `$ENV{RUBY} -v`);
	   return($ver);
       },
     },

     regina =>
     { Lang => 'rexx',
       Name => 'regina',
       Status => '+',
       Home => 'http://regina-rexx.sourceforge.net/',
       Down => 'http://prdownloads.sourceforge.net/regina-rexx',
       Type => 'interpreted',
       Note => 'Extensively ported macro language interpreter',
       Ext  => 'rexx',
       Verfun => sub {
	   chomp(my $ver = `$ENV{REGINA} -v 2>&1`);
	   return($ver);
       },
     },

     'bigloo' =>
     { Lang => 'Scheme',
       Name => 'Bigloo',
       Status => '+',
       Home => 'http://www-sop.inria.fr/mimosa/fp/Bigloo/',
       Down => 'http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo-1.html',
       Type => 'native compiled',
       Note => 'Scheme-based C(++) replacement',
       Ext  => 'lisp',
       Verfun => sub {
	   chomp(my $ver = `$ENV{BIGLOO} -version`);
	   return($ver);
       },
     },

     guile =>
     { Lang => 'Scheme',
       Name => 'Guile',
       Status => '+',
       Home => 'http://www.gnu.org/software/guile/guile.html',
       Down => 'ftp://ftp.gnu.org/pub/gnu/guile/',
       Type => 'interpreted',
       Note => 'Scheme reborn as a scripting and extension language',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{GUILE} --version`;
	   $ver =~ s/\n.*//s;
	   return($ver);
       },
     },

     mzscheme =>
     { Lang => 'Scheme',
       Name => 'MzScheme',
       Status => '+',
       Home => 'http://www.plt-scheme.org',
       Down => 'http://download.plt-scheme.org/drscheme/',
       Type => 'interpreted',
       Note => 'Statically scoped, properly tail-recursive dialect of Lisp',
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
       Name => 'Stalin',
       Status => 'X',
       Home => 'http://www.ece.purdue.edu/~qobi/software.html',
       Down => 'http://www.ece.purdue.edu/~qobi/software.html',
       Type => 'native compiled',
       Note => 'Optimizing Scheme compiler',
       Ext  => 'lisp',
       Verfun => sub {
           return('Stalin 0.9');
       },
     },

     gambit =>
     { Lang => 'Scheme',
       Name => 'Gambit',
       Status => '+',
       Home => '',
       Down => '',
       Type => '',
       Note => '',
       Ext  => 'lisp',
       Verfun => sub {
	   my $ver = `$ENV{MZSCHEME} --version`;
	   $ver =~ s/\n.*//s;
	   $ver =~ s/Welcome to//s;
	   $ver =~ s/, Copyright.*//s;
	   return($ver);
       },
     },

     'slang' =>
     { Lang => 'S-Lang',
       Name => 'S-Lang',
       Status => '+',
       Home => 'http://www.s-lang.org/',
       Down => 'http://www-s-lang.org/download.html',
       Type => 'interpreted',
       Note => 'Embeddable extension language',
       Ext  => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SLANG} --version`);
	   $ver =~ s/slsh.*//;	# Dump the slsh version -- who cares!
	   return($ver);
       },
     },

     'smlnj' =>
     { Lang => 'SML',
       Name => 'SML/NJ',
       Status => '+',
       Home => 'http://cm.bell-labs.com/cm/cs/what/smlnj/',
       Down => 'http://cm.bell-labs.com/cm/cs/what/smlnj/software.html',
       Type => 'native compiled',
       Note => 'Elegance of FP combined with effectiveness of imperative programming',
       Ext  => 'sml',
       Verfun => sub {
	   chomp(my $ver = `$ENV{SMLNJ} </dev/null`);
	   $ver =~ s/\s*\[.*//;
	   return($ver);
       },
     },

     mlton =>
     { Lang => 'SML',
       Name => 'MLton',
       Status => '+',
       Home => 'http://mlton.org/',
       Down => 'http://mlton.org/download/',
       Type => 'native compiled',
       Note => 'Whole-program optimizing ML compiler',
       Ext  => 'sml',
       Verfun => sub {
	   chomp(my($ver) = grep(/^mlton/i,`$ENV{MLTON} 2>&1`));
	   $ver =~ s/\(built.*//;
	   return($ver);
       },
     },

     poly =>
     { Lang => 'SML',
       Name => 'Poly/ML',
       Status => 'X',
       Home => 'http://www.polyml.org/',
       Down => 'http://www.polyml.org/download/',
       Type => 'native compiled',
       Note => 'Stable, standards-compliant SML 97',
       Ext  => 'sml',
       Verfun => sub {
	   chomp(my $ver = `$ENV{POLY} -v`);
	   $ver =~ /(version.*)\n/;
	   return("Poly/ML $1");
       },
     },

     gst =>
     { Lang => 'Smalltalk',
       Name => 'GST',
       Status => '+',
       Home => 'http://www.gnu.org/software/smalltalk/smalltalk.html',
       Type => 'bytecomped/interpreted',
       Note => 'Pure OO - Smalltalk as a scripting language',
       Ext => 'pl',
       Verfun => sub {
           chomp(my($ver) = grep(/^GNU.*/i,`$ENV{GST} --version 2>&1`));
	   return ($ver);
       },
     },

     tcc =>
     { Lang => 'C',
       Name => 'Tiny C',
       Status => '+',
       Home => 'http://fabrice.bellard.free.fr/tcc/',
       Type => 'native compiled',
       Note => 'Compile and execute C code everywhere',
       Ext => 'c',
       Verfun => sub {
	   chomp(my $ver = `$ENV{TCC} -v`);
	   $ver =~ s/tcc version//s;
	   return($ver);
       },
     },

     tcl =>
     { Lang => 'Tcl',
       Name => 'Tcl',
       Status => '+',
       Home => 'http://tcl.tk/',
       Down => 'http://www.tcl.tk/software/tcltk/downloadnow84.tml',
       Type => 'bytecomped/interpreted',
       Note => 'Unix and GUI scripting',
       Ext  => 'tcl',
       Verfun => sub {
	   chomp(my $ver = `echo 'puts [info patchlevel]'|$ENV{TCL}`);
	   return('Tcl ' . $ver);
       },
     },

     xemacs =>
     { Lang => 'Emacs Lisp',
       Name => 'Xemacs',
       Status => '+',
       Home => 'http://www.xemacs.org/',
       Down => 'http://www.xemacs.org/Download/',
       Type => 'bytecomped/interpreted',
       Note => 'Lucid\'s Emacs fork extension language',
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
     'Ada 95'      => 'dash',
     'awk'         => 'shell',
     'Awk'         => 'shell',
     'Bash'        => 'shell',
     'bigloo'      => 'scheme',
     'C'           => 'c',
     'C++'         => 'c',
     'C#'          => 'c',
     'Ciao Prolog' => 'prolog',
     'Clean'       => 'c',
     'Common Lisp' => 'scheme',
     'Cyclone'     => 'c',
     'cyclone'     => 'c',
     'D'           => 'c',
     'Dylan'       => 'c',
     'Eiffel'      => 'dash',
     'ElastiC'     => 'c',
     'Erlang'      => 'prolog',
     'groovy'      => 'c',
     'Groovy'	   => 'c',
     'Java'        => 'c',
     'JavaScript'  => 'c',     
     'Forth'       => 'forth',
     'Fortran'     => 'fortran',
     'Haskell'     => 'dash',
     'Felix'       => 'c',
     'gawk'        => 'shell',
     'Gawk'        => 'shell',
     'Icon'        => 'shell',
     'Io'          => 'shell',
     'Lua'         => 'dash',
     'Mercury'     => 'prolog',
     'mawk'        => 'shell',
     'mzscheme'    => 'lisp',
     'mzc'         => 'lisp',
     'MzScheme'    => 'lisp',
     'newlisp'     => 'lisp',
     'Newlisp'     => 'lisp',
     'Nice'        => 'c',
     'Oberon-2'    => 'pascal',
     'Objective C' => 'c',
     'OCaml'       => 'ml',
     'poplog'      => 'c',
     'Parrot'      => 'shell',
     'Poplog'      => 'c',
     'Mozart/Oz'   => 'prolog',
     'Perl'        => 'shell',
     'PHP'         => 'php',
     'Pascal'      => 'pas',
     'Pike'        => 'c',
     'Prolog'      => 'prolog',
     'Python'      => 'shell',
     'IronPython'  => 'shell',
     'Lisp'        => 'scheme',
     'Ruby'        => 'shell',
     'S-Lang'      => 'c',
     'Smalltalk'   => 'smalltalk',
     'SML'         => 'ml',
     'Tcl'         => 'shell',
     'Emacs Lisp'  => 'elisp',
     'Scheme'      => 'scheme',
     'XEmacs'      => 'lisp',
     'Xemacs'      => 'lisp',
     'xemacs'      => 'lisp',

     # Overrides for specific languages, which seem to belong to a different
     # family that their languages hints at
     'cyc'         => 'c',
     'd'           => 'c',
     'dlang'       => 'c',
     'f90'         => 'fortran',
     'g95'         => 'fortran',
     'ifc'         => 'fortran',
     'rep'         => 'scheme',
     'Pop11'       => 'c',
     'fpascal'     => 'pascal',
     'regina'	   => 'c',
     'rexx'        => 'c',
 );
