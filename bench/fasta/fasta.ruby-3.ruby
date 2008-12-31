# The Computer Language Shootout
# http://shootout.alioth.debian.org/
# Contributed by Sokolov Yura
# Modified by Wesley Moxam

$last = 42.0
def gen_random (max,im=139968,ia=3877,ic=29573)
  (max * ($last = ($last * ia + ic) % im)) / im
end

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

def make_repeat_fasta(id, desc, src, n)
    $out.write ">#{id} #{desc}"
    v = nil
    width = 60
    l = src.length
    s = src * ((n / l) + 1)
    s.slice!(n, l)
    $out.write(s.scan(/.{1,#{width}}/).join("\n"))
end

def make_random_fasta(id, desc, table, n)
  $out.write ">#{id} #{desc}"
  rand, v = nil,nil
  width = 60
  chunk = 1 * width
  prob = 0.0
  table.each{|v| v[1]= (prob += v[1])}
  1.upto(n / width) {|i|
      1.upto(width) {
          rand = gen_random(1.0)
          table.each {|e|
              if e[1] > rand
                $out.write e[0]
                break
              end
          }
      }
      $out.write "\n"
  }
  if n % width != 0
    1.upto(n % width) {
      rand = gen_random(1.0)
      table.each {|e|
        if e[1] > rand
          $out.write e[0]
          break
        end
      }
    }
    $out.write "\n"
  end
end


n = (ARGV[0] or 27).to_i

# Ruby's stdout isn't fast. Buffering in a file helps a lot
output_file_name = 'fasta.txt'
$out = File.open(output_file_name, 'w')
make_repeat_fasta('ONE', 'Homo sapiens alu', alu, n*2)
make_random_fasta('TWO', 'IUB ambiguity codes', iub, n*3)
make_random_fasta('THREE', 'Homo sapiens frequency', homosapiens, n*5)
$out.close

out = File.open(output_file_name, 'r')
while ! out.eof?
  print out.read(1048576) # read 1 MB at a time
end
out.close

File.unlink output_file_name

