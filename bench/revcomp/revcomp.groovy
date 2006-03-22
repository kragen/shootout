// ---------------------------------------------------------------------
// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// Redesigned [though minimally, and 'spirit' of original maintained as
// far as possible] by Anthony Borla based on code originally contributed
// by Jochen Hinrichsen.
//
// Original redesign used string concatenation to create segments but this
// proved extremely inefficient and slow, so modified code to utilise a
// StringBuffer
// ---------------------------------------------------------------------

def revcomp(sequence)
{
  def complement = ['A':'T', 'C':'G', 'G':'C', 'T':'A', 'M':'K', 'R':'Y', 'W':'W', 'S':'S', 'Y':'R', 'K':'M', 'V':'B', 'H':'D', 'D':'H', 'B':'V', 'N':'N']
  def compseq = new StringBuffer()

  sequence.reverse().toUpperCase().each()
  {
    compseq += complement[it]
  }

  compseq.toString()
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

  segment.setLength(0)
}

// --------------------------------

def main()
{
  System.in.newReader().withReader { reader ->

    def segment = new StringBuffer(); def sequence = ""

    while ((sequence = reader.readLine()) != null)
    {
      if (sequence.startsWith('>'))
      {
        dumpSegment(segment, 60) ; println sequence
      }
      else
      {
        segment.insert(0, revcomp(sequence))
      }
    }

    dumpSegment(segment, 60)
  }
}

// --------------------------------

main()

