// The Computer Language Benchmarks Game
// http://shootout.alioth.debian.org/
//
// Requires a PCRE [Perl Compatible Regular Expression] enabled Pike.
//
// contributed by Anthony Borla
// Modified by Bertrand LUPART and Mirar.

array(string) VARIANTS =
  ({
    "agggtaaa|tttaccct", "[cgt]gggtaaa|tttaccc[acg]", "a[act]ggtaaa|tttacc[agt]t",
    "ag[act]gtaaa|tttac[agt]ct", "agg[act]taaa|ttta[agt]cct", "aggg[acg]aaa|ttt[cgt]ccct",
    "agggt[cgt]aa|tt[acg]accct", "agggta[cgt]a|t[acg]taccct", "agggtaa[cgt]|[acg]ttaccct"
  });

array(string) IUB =
  ({
    "B","D","H","K","M","N","R","S","V","W","Y", 
  });
  
array(string) IUBnew =
  ({
    "(c|g|t)","(a|g|t)","(a|c|t)","(g|t)","(a|c)","(a|c|g|t)","(a|g)","(c|g)","(a|c|g)","(a|t)","(c|t)", 
  });



int main()
{
  // Read input data into string and record its length
  string seq = Stdio.stdin->read(); int initial_length = sizeof(seq);

  // Remove all newline and segment divider line occurrences
  seq = Regexp.PCRE.Studied("(>.*\n)|(\n)")->replace(seq, "");

  int code_length = sizeof(seq);

  // Perform regexp counts
  foreach(VARIANTS, string var)
  {
		int number_of_matches = 0;
		Regexp.PCRE.Studied(var, Regexp.PCRE.OPTION.CASELESS)->matchall(seq, lambda(){ number_of_matches++; });

    write("%s %d\n", var, number_of_matches);
  }

  // Perform replacements
  seq = replace(seq, IUB, IUBnew);

  // Print statistics
  write("\n%d\n%d\n%d\n", initial_length, code_length, sizeof(seq));

  return 0;
}
