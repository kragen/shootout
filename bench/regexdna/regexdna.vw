"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Eliot Miranda *"


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

regexdna
   self regexDNAFrom: Stdin to: Stdout.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

regexDNAFrom: input to: output 
   | s size1 size2 translation |
   s := input contents.
   size1 := s size.

   "* remove FASTA sequence descriptions and new-lines *"
   s := s copyWithRegex: '>[^\r]*\r|\r' matchesReplacedWith: ''.
   size2 := s size.

   "* regex match *"
   #(   'agggtaaa|tttaccct'
      '[cgt]gggtaaa|tttaccc[acg]'
      'a[act]ggtaaa|tttacc[agt]t'
      'ag[act]gtaaa|tttac[agt]ct'
      'agg[act]taaa|ttta[agt]cct'
      'aggg[acg]aaa|ttt[cgt]ccct'
      'agggt[cgt]aa|tt[acg]accct'
      'agggta[cgt]a|t[acg]taccct'
      'agggtaa[cgt]|[acg]ttaccct') 
      do: [:each | 
         output nextPutAll: each; space; print: (s occurrencesOfRegex: each); cr].


   "* regex substitution *"
   "#(   #('B' '(c|g|t)')
      #('D' '(a|g|t)')
      #('H' '(a|c|t)')
      #('K' '(g|t)')
      #('M' '(a|c)')
      #('N' '(a|c|g|t)')
      #('R' '(a|g)')
      #('S' '(c|g)')
      #('V' '(a|c|g)')
      #('W' '(a|t)')
      #('Y' '(c|t)')) 
      do: [:each | s := s copyReplacingAllRegex: each first with: each last]."
   translation := Dictionary new.
   #(   #('B' '(c|g|t)')
      #('D' '(a|g|t)')
      #('H' '(a|c|t)')
      #('K' '(g|t)')
      #('M' '(a|c)')
      #('N' '(a|c|g|t)')
      #('R' '(a|g)')
      #('S' '(c|g)')
      #('V' '(a|c|g)')
      #('W' '(a|t)')
      #('Y' '(c|t)')) 
      do: [:each | translation at: each first put: each last].
   s := s
         copyWithRegex: '[', (translation keys asArray fold: [:a :b| a, b]), ']'
         matchesTranslatedUsing: [:l| translation at: l].

   output cr; print: size1; cr; print: size2; cr; print: s size; cr ! !

