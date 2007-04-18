"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Isaac Gouy
    modified by Paolo Bonzini *"


!Tests class methodsFor: 'benchmarking'!matchPatterns
   ^#(   'agggtaaa|tttaccct'
         '[cgt]gggtaaa|tttaccc[acg]'
         'a[act]ggtaaa|tttacc[agt]t'
         'ag[act]gtaaa|tttac[agt]ct'
         'agg[act]taaa|ttta[agt]cct'
         'aggg[acg]aaa|ttt[cgt]ccct'
         'agggt[cgt]aa|tt[acg]accct'
         'agggta[cgt]a|t[acg]taccct'
         'agggtaa[cgt]|[acg]ttaccct'
   )! !

!Tests class methodsFor: 'benchmarking'!substitutionPatterns
   ^#(   #('B' '(c|g|t)')
         #('D' '(a|g|t)')
         #('H' '(a|c|t)')
         #('K' '(g|t)')
         #('M' '(a|c)')
         #('N' '(a|c|g|t)')
         #('R' '(a|g)')
         #('S' '(c|g)')
         #('V' '(a|c|g)')
         #('W' '(a|t)')
         #('Y' '(c|t)'))! !


!Tests class methodsFor: 'benchmarking'!regexDNA: sequence to: output
   | s size1 size2 |
   size1 := sequence size.

   "* remove FASTA sequence descriptions and new-lines *"
   s := sequence copyReplacingAllRegex: '>.*\n|\n' with: ''.
   size2 := s size.

   self matchPatterns do: [:each| 
      output 
         nextPutAll: each; space; 
         print: (s occurrencesOfRegex: each); nl
      ]. 

   self substitutionPatterns do: [:each| 
      s := s copyReplacingAllRegex: each first with: each last].

   output
      nl;
      print: size1; nl; 
      print: size2; nl; 
      print: s size; nl! !!Tests class methodsFor: 'benchmark scripts'!regexdna
   self regexDNA: self stdinSpecial contents to: self stdout.
   ^'' ! !

Tests regexdna!
