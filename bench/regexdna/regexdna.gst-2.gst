"* The Computer Language Shootout
 http://shootout.alioth.debian.org/
 contributed by Isaac Gouy 
 modified by Paolo Bonzini *"


| s size1 size2 |
s := (FileStream stdin bufferSize: 4096) contents.
size1 := s size.

"* remove FASTA sequence descriptions and new-lines *"
s := s copyReplacingAllRegex: '>.*\n|\n' with: ''.
size2 := s size.

"* regex match *"
(OrderedCollection new
   add: 'agggtaaa|tttaccct';
   add: '[cgt]gggtaaa|tttaccc[acg]';
   add: 'a[act]ggtaaa|tttacc[agt]t';
   add: 'ag[act]gtaaa|tttac[agt]ct';
   add: 'agg[act]taaa|ttta[agt]cct';
   add: 'aggg[acg]aaa|ttt[cgt]ccct';
   add: 'agggt[cgt]aa|tt[acg]accct';
   add: 'agggta[cgt]a|t[acg]taccct';
   add: 'agggtaa[cgt]|[acg]ttaccct'; yourself)

   do: [:each| (each, ' ', (s occurrencesOfRegex: each) printString) displayNl].


"* regex substitution *"
(OrderedCollection new
   add: (Association key: 'B' value: '(c|g|t)');
   add: (Association key: 'D' value: '(a|g|t)');
   add: (Association key: 'H' value: '(a|c|t)');
   add: (Association key: 'K' value: '(g|t)');
   add: (Association key: 'M' value: '(a|c)');
   add: (Association key: 'N' value: '(a|c|g|t)');
   add: (Association key: 'R' value: '(a|g)');
   add: (Association key: 'S' value: '(c|g)');
   add: (Association key: 'V' value: '(a|c|g)');
   add: (Association key: 'W' value: '(a|t)');
   add: (Association key: 'Y' value: '(c|t)'); yourself)

   do: [:each| s := s copyReplacingAllRegex: each key with: each value].


'' displayNl. size1 displayNl. size2 displayNl. s size displayNl !
