/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/

   contributed by Jochen Hinrichsen
   modified by Anthony Borla
   modified by Isaac Gouy
*/

def revcomp(sequence) {
  def complement = ['A':'T', 'C':'G', 'G':'C', 'T':'A', 'M':'K', 'R':'Y', 
                    'W':'W', 'S':'S', 'Y':'R', 'K':'M', 'V':'B', 'H':'D', 
                    'D':'H', 'B':'V', 'N':'N']
  def compseq = new StringBuffer()

  sequence.reverse().toUpperCase().each(){ compseq += complement[it] }
  compseq.toString()
}

def dumpSegment(segment, length) {
  def segsize = segment.size()
  if (segsize < 1) return

  def start = 0
  def end = length - 1

  while (true) {
    println segment[start..end]

    if (end + length < segsize-1) {
      start += length
      end += length
    }
    else {
      println segment[end + 1..segsize-1]
      break
    }
  }
  segment.setLength(0)
}


System.in.newReader().withReader { reader ->
   def segment = new StringBuffer()
   def sequence = ""

   while ((sequence = reader.readLine()) != null) {
      if (sequence.startsWith('>')) {
        dumpSegment(segment,60)
        println sequence
      }
      else {
        segment.insert(0,revcomp(sequence))
      }
    }
    dumpSegment(segment,60)
}


