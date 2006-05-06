#  The Computer Language Shootout
#  http://shootout.alioth.debian.org/
#  contributed by Karl von Laudermann

size = ARGV[0].to_i
puts "P4\n#{size} #{size}"

iter = 50
limit2 = 4.0 
byte_acc = 0
bit_num = 0
escape = 0b0
zr, zi = 0.0, 0.0
cr, ci = 0.0, 0.0
tr, ti = 0.0, 0.0

size.times do |y|
     size.times do |x|
         zr = 0.0
         zi = 0.0
         cr = (2.0*x/size)-1.5
         ci = (2.0*y/size)-1.0
         escape = 0b0 

         iter.times do
            tr = zr*zr - zi*zi + cr
            ti = 2*zr*zi + ci
            zr, zi = tr, ti

            if (zr*zr+zi*zi) > limit2 
                escape = 0b1 
                break
            end
         end

         byte_acc = (byte_acc << 1) | escape 
         bit_num += 1

         if (bit_num == 8) || (x == size - 1)
             byte_acc <<= (8 - bit_num)
             print byte_acc.chr
             byte_acc = 0
             bit_num = 0
         end
     end
end

