
import java.io.*;

public class revcomp {
        
    public static void main(String[] args) throws IOException {
        char[] comp = new char[128];
        comp['a'] = comp['A'] = 'T';
        comp['c'] = comp['C'] = 'G';
        comp['g'] = comp['G'] = 'C';
        comp['t'] = comp['T'] = 'A';
        comp['u'] = comp['U'] = 'A';
        comp['m'] = comp['M'] = 'K';
        comp['r'] = comp['R'] = 'Y';
        comp['w'] = comp['W'] = 'W';
        comp['s'] = comp['S'] = 'S';
        comp['y'] = comp['Y'] = 'R';
        comp['k'] = comp['K'] = 'M';
        comp['v'] = comp['V'] = 'B';
        comp['h'] = comp['H'] = 'D';
        comp['d'] = comp['D'] = 'H';
        comp['b'] = comp['B'] = 'V';
        comp['n'] = comp['N'] = 'N';
        
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        
        String header = in.readLine ();
        while (header != null && header.charAt (0) == '>') {
            StringBuffer sb = new StringBuffer(4*1024);
                        
            // read the sequence into the StringBuffer
            String line = in.readLine ();
            while (line != null && line.charAt (0) != '>') { 
                sb.append (line);
                line = in.readLine ();
            }
            
            // reverse StringBuffer + find complements
            int len = sb.length ();
            int from = 0, to = len - 1;
            while(from <= to) {
                char c1 = comp[sb.charAt (from)];
                char c2 = comp[sb.charAt (to)];
                sb.setCharAt (from, c2);
                sb.setCharAt (to, c1);
                from++;
                to--;
            }
            
            // print the header
            System.out.println(header);
                        
            // print the sequence
            from = 0;
            to = 60;
            char[] chars = new char[60];
            while(to < len) {
                sb.getChars (from, to, chars, 0);
                System.out.println(new String(chars));
                from = to;
                to += 60;
            }
            if(from != len) {
                sb.getChars (from, len, chars, 0);
                System.out.println(new String(chars, 0, len-from));
            }
                                   
            header = line;
        }
    }        
}