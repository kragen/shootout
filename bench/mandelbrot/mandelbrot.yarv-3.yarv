#  The Computer Language Benchmarks Game
#  http://shootout.alioth.debian.org/
#
#  contributed by Karl von Laudermann
#  modified by Jeremy Echols
#  modified by Detlef Reichl
#  modified by Joseph LaFata
#  modified by Peter Zotov

size = ARGV.shift.to_i

puts "P4\n#{size} #{size}"

byte_acc = 0
bit_num = 0

y = 0
while y < size
  ci = (2.0*y/size)-1.0

  x = 0
  while x < size
    z = Complex(0, 0)
    c = Complex(2.0*x/size-1.5, ci)
    escape = 0b1

    n = 0
    while n < 50
      z = z*z + c
      if z.abs > 4.0
        escape = 0b0
        break
      end
      n += 1
    end

    byte_acc = (byte_acc << 1) | escape
    bit_num += 1

    # Code is very similar for these cases, but using separate blocks
    # ensures we skip the shifting when it's unnecessary, which is most cases.
    if (bit_num == 8)
      print byte_acc.chr
      byte_acc = 0
      bit_num = 0
    elsif (x == size - 1)
      byte_acc <<= (8 - bit_num)
      print byte_acc.chr
      byte_acc = 0
      bit_num = 0
    end
    x += 1
  end
  y += 1
end
