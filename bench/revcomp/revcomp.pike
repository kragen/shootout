// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Contributed by Anthony Borla
// ---------------------------------------------------------------------

void dumpSegment(String.Buffer segment)
{
  constant
    LINELENGTH = 60.0,
    FROM = "wsatugcyrkmbdhvnATUGCYRKMBDHVN" / 1,
    TO = "WSTAACGRYMKVHDBNTAACGRYMKVHDBN" / 1;

  write("%s\n", ((reverse(replace(segment->get(), FROM, TO)) / LINELENGTH) * "\n"));
}

// --------------------------------

int main()
{
  String.Buffer segment = String.Buffer(); string sequence;

  while ((sequence = Stdio.stdin.gets()) != 0)
  {
    if (sequence[0] == '>')
    {
      if (segment->_sizeof() != 0) dumpSegment(segment);
      write("%s\n", sequence);
    }
    else
    {
      segment->add(sequence);
    }
  }

  dumpSegment(segment);

  return 0;
}

