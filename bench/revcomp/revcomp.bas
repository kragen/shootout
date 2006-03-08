rem The Computer Language Shootout
rem http://shootout.alioth.debian.org/
rem contributed by Josh Goldfoot

option explicit

function toupper(b as byte) as byte
   if b > 90 then return b - 32 ' 90 is Z
   return b
end function

sub reverse_in_place(byref buf as string )
   static comp(65 to 90) as byte => {84, 86, 71, 72, 69, 70, 67, 68, 73, 74, _
     77, 76, 75, 78, 79, 80, 81, 89, 83, 65, 85, 66, 87, 88, 82, 90}
   dim as byte tmp
   dim as integer starti, stopi
   stopi = len(buf) - 1
      
   while starti < stopi
      tmp = comp(toupper(buf[starti]))
      buf[starti] = comp(toupper(buf[stopi]))
      buf[stopi] = tmp
      starti += 1
      stopi -= 1
   wend
end sub

sub print60(byref buf as string)
   dim as integer buflen, i
   buflen = len(buf)
   for i = 1 to buflen step 60
      print mid(buf,i,60)
   next i
end sub

sub main()
   dim as integer stdin
   dim as string zline, buffer
   stdin = freefile
   open cons as stdin
   line input #stdin, zline
   while zline <> ""
      if zline[0] = 62 then  ' 62 = asc(">")
         if buffer <> "" then
            reverse_in_place(buffer)
            print60(buffer)
            buffer = ""
         end if
         print zline
      else
         buffer += zline
      end if
      line input #stdin, zline
   wend
   reverse_in_place(buffer)
   print60(buffer)
end sub

main()

