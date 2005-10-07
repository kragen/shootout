/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Mehmet Soyturk
*/

/*
  For an input size of n MB you need a direct memory of 3*n size.
  To ensure this, you must run java with the option: -XX:MaxDirectMemorySize=<m>M 
  with <m> at least 3*n. Default for <m> is 64MB.
  (see http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4879883)
*/


import java.io.*;
import java.nio.*;

public class revcomp {

    static final  byte[] chars = new byte[128];
    static {
        for(int i=0; i<chars.length; i++)
            chars[i] = (byte) i;
        chars['t'] = chars['T'] = (byte) 'A';
        chars['a'] = chars['A'] = (byte) 'T';
        chars['g'] = chars['G'] = (byte) 'C';
        chars['c'] = chars['C'] = (byte) 'G';
        chars['v'] = chars['V'] = (byte) 'B';
        chars['h'] = chars['H'] = (byte) 'D';
        chars['r'] = chars['R'] = (byte) 'Y';
        chars['m'] = chars['M'] = (byte) 'K';
        chars['y'] = chars['Y'] = (byte) 'R';
        chars['k'] = chars['K'] = (byte) 'M';
        chars['b'] = chars['B'] = (byte) 'V';
        chars['d'] = chars['D'] = (byte) 'H';
        chars['u'] = chars['U'] = (byte) 'A';
    }

    private static ByteBuffer appendToBuffer(ByteBuffer buf, String str) {
        byte[] bytes = str.getBytes();
        ByteBuffer newBuffer;
        if(buf.position() + bytes.length >= buf.capacity()) {
            newBuffer = ByteBuffer.allocateDirect(2*buf.capacity());
            buf.flip();
            newBuffer.put(buf);
            buf = null;
        } else {
            newBuffer = buf;
        }
        newBuffer.put(bytes);
        return newBuffer;
    }

    public static void main(String[] args) throws IOException {

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        String header = in.readLine ();
        while (header != null) {
            ByteBuffer buf = ByteBuffer.allocateDirect(7*512*1024);

            // read the sequence into the StringBuffer
            String line = in.readLine ();
            while (line != null && (line.length() == 0 || line.charAt (0) != '>')) {
                buf = appendToBuffer(buf, line + '\n');
                line = in.readLine ();
            }

            // reverse StringBuffer + find complements, don't touch '\n'
            byte NL = (byte) '\n';
            int from = 0, to = buf.position () - 1;
            while (from <= to) {

                byte fromCh = buf.get (from);
                if (fromCh == NL) {
                    from++;
                    continue;
                }

                byte toCh   = buf.get (to);
                if (toCh == NL) {
                    to--;
                    continue;
                }

                buf.put (from++, chars[toCh]);
                buf.put (to--, chars[fromCh]);
            }

            // print
            System.out.print(header);
            System.out.print('\n');

            byte[] b = new byte[1024];
            buf.flip();
            while(buf.hasRemaining()) {
                int len = b.length <= buf.remaining() ? b.length : 
                                                        buf.remaining();
                buf.get(b, 0, len);
                System.out.write(b, 0, len);
            }
            header = line;
            buf = null;
        }
    }
}
