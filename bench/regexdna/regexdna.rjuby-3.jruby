# The Computer Language Benchmarks Game
# http://shootout.alioth.debian.org/
#
# contributed by jose fco. gonzalez
# optimized & parallelized by Rick Branson

seq = STDIN.readlines.join
ilen = seq.size

seq.gsub!(/>.*\n|\n/,"")
clen = seq.length

MATCHERS = [
  /agggtaaa|tttaccct/,
  /[cgt]gggtaaa|tttaccc[acg]/,
  /a[act]ggtaaa|tttacc[agt]t/,
  /ag[act]gtaaa|tttac[agt]ct/,
  /agg[act]taaa|ttta[agt]cct/,
  /aggg[acg]aaa|ttt[cgt]ccct/,
  /agggt[cgt]aa|tt[acg]accct/,
  /agggta[cgt]a|t[acg]taccct/,
  /agggtaa[cgt]|[acg]ttaccct/
]

if RUBY_PLATFORM == "java"
  threads = MATCHERS.map do |f|
    Thread.new do
      Thread.current[:result] = "#{f.source} #{seq.scan(f).size}"
    end
  end

  threads.each do |t|
    t.join
  end

  threads.each do |t|
    puts t[:result]
  end
else
  children = MATCHERS.map do |f|
    r, w = IO.pipe
    p = Process.fork do
      r.close
      w.write "#{f.source} #{seq.scan(f).size}"
      w.close
    end
  
    w.close
    [p, r, w]
  end

  children.each do |p, r, w|
    puts r.read
    r.close
  end

  Process.waitall
end

{
'B' => '(c|g|t)', 'D' => '(a|g|t)', 'H' => '(a|c|t)', 'K' => '(g|t)',
'M' => '(a|c)', 'N' => '(a|c|g|t)', 'R' => '(a|g)', 'S' => '(c|t)',
'V' => '(a|c|g)', 'W' => '(a|t)', 'Y' => '(c|t)'
}.each { |f,r| seq.gsub!(f,r) }

puts
puts ilen
puts clen
puts seq.length
