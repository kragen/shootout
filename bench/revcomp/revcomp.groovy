// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Redesigned [though minimally, and 'spirit' of original maintained as
// far as possible] by Anthony Borla based on code originally contributed
// by Jochen Hinrichsen.
//
// Use of string concatenation for segment creation could prove a
// performance bottleneck under heavy loads and may need replacing with
// a StringBuffer-based approach 
// ---------------------------------------------------------------------

def complement = ['A':'T', 'C':'G', 'G':'C', 'T':'A', 'M':'K', 'R':'Y', 'W':'W', 'S':'S', 'Y':'R', 'K':'M', 'V':'B', 'H':'D', 'D':'H', 'B':'V', 'N':'N']

// --------------

def revcomp(sequence)
{
  def compseq = ""

  sequence.reverse().toUpperCase().each()
  {
    compseq += complement[it]
  }

  compseq
}

// --------------

def dumpSegment(segment, length)
{
  def segsize = segment.size() ; if (segsize < 1) return

  def start = 0 ; def end = length - 1

  while (true)
  {
    println segment[start .. end]

    if (end + length < segsize - 1)
    {
      start += length ; end += length
    }
    else
    {
      println segment[end + 1 .. segsize - 1] ; break
    }
  }
}

// --------------------------------

def main()
{
  System.in.newReader().withReader { reader ->

    def segment = "" ; def sequence = ""

    while ((sequence = reader.readLine()) != null)
    {
      if (sequence.startsWith('>'))
      {
        dumpSegment(segment, 60) ; segment = "" ; println sequence
      }
      else
      {
        segment = revcomp(sequence) + segment
      }
    }

    dumpSegment(segment, 60)
  }
}

// --------------------------------

main()

