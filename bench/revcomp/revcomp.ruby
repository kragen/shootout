#!/usr/bin/ruby
# The Great Computer Language Shootout
# http://shootout.alioth.debian.org/
#
# Contributed by Peter Bjarke Olsen
revseq=""
seq=""

def revcomp(seq)
  revseq=seq.reverse
  revseq=revseq.upcase
  revseq=revseq.tr('ACGTUMRWSYKVHDBXN','TGCAAKYWSRMBDHVXN')
  stringlen=revseq.length
  0.step(stringlen-1,60) {|x| print revseq.slice(x,60) , "\n"}
end

while gets
  if />/
    if seq != ''
      revseq=revcomp(seq)
      seq="" 
    end 
    puts $_
  else
    sub(/\n/,'') 
    seq=seq + $_ 
  end  
end
revseq=revcomp(seq)
