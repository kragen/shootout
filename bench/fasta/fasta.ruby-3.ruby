# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
# Contributed by Sokolov Yura
# Modified by Joseph LaFata
# Modified by Philip (flip) Kromer (used lookup table in place of search, unrolled print loop)

alu =
  "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"+
  "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"+
  "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"+
  "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"+
  "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"+
  "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"+
  "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

iub = [
  ["a", 0.27],
  ["c", 0.12],
  ["g", 0.12],
  ["t", 0.27],

  ["B", 0.02],
  ["D", 0.02],
  ["H", 0.02],
  ["K", 0.02],
  ["M", 0.02],
  ["N", 0.02],
  ["R", 0.02],
  ["S", 0.02],
  ["V", 0.02],
  ["W", 0.02],
  ["Y", 0.02],
]
homosapiens = [
  ["a", 0.3029549426680],
  ["c", 0.1979883004921],
  ["g", 0.1975473066391],
  ["t", 0.3015094502008],
]

$lasti = 42
IM=139968
IA=3877
IC=29573
# Generates an integer in 0 <= rx < IM
def gen_random_int
  $lasti = ($lasti * IA + IC) % IM
end

def print_in_rows_of row_len, str, fh=$stdout
  0.step(str.length-1,row_len){|x| fh.print str[x,row_len], "\n" }
end

def make_repeat_fasta(id, desc, src, n)
  puts ">#{id} #{desc}"
  l = src.length
  s = src * ((n / l) + 1) # enough duplicates to be longer than n chars
  s.slice!(n, l)          # remove characters past nth
  print_in_rows_of 60, s
end

# The given random number generator only creates integers in 0...IM (exclusive)
# Calculate the result for each rather than do linear search.
def make_lut_flat prob_dist
  lut = []
  pt = 0.0
  prob_dist.map do |ch,pr|
    lut << ((pt*IM).ceil ... ((pt+pr)*IM).ceil).map{ ch }
    pt += pr
  end
  lut.flatten!
end

def make_random_fasta_lut_chunked(id, desc, prob_dist, n)
  puts ">#{id} #{desc}"
  lut = make_lut_flat(prob_dist)
  rx = $lasti
  # ruby <= 1.8x's memory manager is an Achilles heel.  Let's print 60 chars as
  # we go along rather than accumulate n chars to print all at once.
  full_lines = (n/60); extra_lines = n - 60*full_lines
  full_lines.times do
    60.times       { print lut[rx = (rx * IA + IC) % IM] } ; print "\n"
  end
  extra_lines.times{ print lut[rx = (rx * IA + IC) % IM] } ; print "\n" unless extra_lines == 0
  $lasti = rx
end

n = (ARGV[0] || 27).to_i

make_repeat_fasta('ONE', 'Homo sapiens alu', alu, n*2)
make_random_fasta_lut_chunked('TWO', 'IUB ambiguity codes', iub, n*3)
make_random_fasta_lut_chunked('THREE', 'Homo sapiens frequency', homosapiens, n*5)
