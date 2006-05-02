// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Requires that the PCRE [Perl Compatible Regular Expression] library
// be installed [Pike needs to be rebuilt after this is installed].
//
// Also, makes use of code from:
//
//   http://buoy.riverweb.com:8080/viewrep/cvs/pike_modules/Public_Web_Wiki/module.pmod.in/module.pmod
//
// to approximate the expected [but not currently implemented] functionality
// of 'Regexp.split'. Many thanks to Bill Welliver for suggesting this
// approach.
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

//
// Extracted from 'pmod' module
//
class BaseRule
{
  constant type = "BaseRule";
  static object regexp;
  static function split_fun;
  int max_iterations = 10;

  string _sprintf(mixed ... args)
  {
    return sprintf("%s(%s)", type, regexp->pattern);
  }

  void create(string match)
  {
    regexp = _Regexp_PCRE(match, Regexp.PCRE.OPTION.MULTILINE);
    split_fun = regexp->split;
  }

  array replace(string subject,string|function with, mixed|void ... args)
  {
    int i=0;
    array res = ({});
		
    for (;;)
    {
      array substrings = ({});
      array(int)|int v=regexp->exec(subject,i);

      if (intp(v) && !regexp->handle_exec_error([int]v)) break;

      if (v[0]>i) res+=({subject[i..v[0]-1]});

      if(sizeof(v)>2)
      {
        int c = 2;
        do
        {
          substrings += ({ subject[v[c]..(v[c+1]-1)] });
          c+=2;
        }
        while(c<= (sizeof(v)-2));
      }

      if (stringp(with)) res+=({with});
      else { array o = with(subject[v[0]..v[1]-1], substrings, @args); res+=o; }
 
      i=v[1];
    }

    res+=({subject[i..]});
    return res;
  }
}

// --------------------------------

constant VARIANTS = ({
  "agggtaaa|tttaccct", "[cgt]gggtaaa|tttaccc[acg]", "a[act]ggtaaa|tttacc[agt]t",
  "ag[act]gtaaa|tttac[agt]ct", "agg[act]taaa|ttta[agt]cct", "aggg[acg]aaa|ttt[cgt]ccct",
  "agggt[cgt]aa|tt[acg]accct", "agggta[cgt]a|t[acg]taccct", "agggtaa[cgt]|[acg]ttaccct"});

constant IUBS = ([
  "B":"(c|g|t)", "D":"(a|g|t)", "H":"(a|c|t)", "K":"(g|t)",
  "M":"(a|c)", "N":"(a|c|g|t)", "R":"(a|g)", "S":"(c|g)",
  "V":"(a|c|g)", "W":"(a|t)", "Y":"(c|t)"]);

// --------------------------------

int main()
{
  // Read input data into string and record its length
  string seq = Stdio.stdin->read(); int initial_length = sizeof(seq);

  // Remove all newline and segment divider line occurrences
  seq = Regexp.replace("(>.*\n)|(\n)", seq, ""); int code_length = sizeof(seq);

  // Perform regexp counts
  foreach(VARIANTS, string var)
  {
    // 'Regexp.split' version would probably look like this:
    //
    // int number_of_matches; string pattern = "(?i)" + var;
    // 
    // if (array(string) matches = Regexp.split(pattern, seq))
    //   number_of_matches = sizeof(matches);
    //

    // 'pmod' module version
    int number_of_matches = sizeof(BaseRule("(?i)" + var)->replace(seq, "")) / 2;

    write("%s %d\n", var, number_of_matches);
  }

  // Perform replacements
  foreach(indices(IUBS), string key)
  {
    seq = Regexp.replace(key, seq, IUBS[key]);
  }

  // Print statistics
  write("\n%d\n%d\n%d\n", initial_length, code_length, sizeof(seq));

  return 0;
}

