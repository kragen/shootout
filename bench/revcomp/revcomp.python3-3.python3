# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# 
# contributed by Jacob Lee, Steven Bethard, et al
# 2to3
# fixed by Daniele Varrazzo

import sys, string

def show(seq, 
         table=bytes.maketrans(b'ACBDGHK\nMNSRUTWVYacbdghkmnsrutwvy',
                                b'TGVHCDM\nKNSYAAWBRTGVHCDMKNSYAAWBR')):
                                
   seq = (''.join(seq)).translate(table)[::-1]
   for i in range(0, len(seq), 60):
      print(seq[i:i+60])
      

def main():
   seq = []
   add_line = seq.append
   for line in sys.stdin:
      if line[0] in '>;':
         show(seq)
         print(line, end='')
         del seq[:]
      else:
         add_line(line[:-1])
   show(seq)

main()
