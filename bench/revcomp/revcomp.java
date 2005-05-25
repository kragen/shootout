/* The Great Computer Language Shootout 
   http://shootout.alioth.debian.org/

   contributed by Mehmet Soyturk
*/

import java.io.*;

public class revcomp {
    static final char getComp(char ch) {
        if(ch >= 'a' && ch <= 'z')
            ch += 'A' - 'a';
            
        switch(ch) {
            case 'T': return 'A';
            case 'A': return 'T';
            case 'G': return 'C';
            case 'C': return 'G';
            case 'V': return 'B';
            case 'S': return 'S';
            case 'H': return 'D';
            case 'R': return 'Y';
            case 'W': return 'W';
            case 'M': return 'K';
            case 'Y': return 'R';
            case 'K': return 'M';
            case 'B': return 'V';
            case 'D': return 'H';
            case 'U': return 'A';
        }
        return ch;
    }


    public static void main(String[] args) throws IOException {
     
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        String header = in.readLine ();
        while (header != null) {
            StringBuffer sb = new StringBuffer(5*1024);

            // read the sequence into the StringBuffer
            String line = in.readLine ();
            while (line != null && line.charAt (0) != '>') {
                sb.append (line).append ('\n');
                line = in.readLine ();
            }
           
            // reverse StringBuffer + find complements, don't touch '\n'
            int from = 0, to = sb.length ()-1;
            while(from<=to) {
               
                char fromCh = sb.charAt (from);
                if(fromCh == '\n') {
                    from++;
                    continue;
                }
                
                char toCh   = sb.charAt (to);
                if(toCh == '\n') {
                    to--;
                    continue;
                }
                
                sb.setCharAt (from++, getComp(toCh));
                sb.setCharAt (to--, getComp(fromCh));
            }
            
            // print
            System.out.print(header);
            System.out.print('\n');
            System.out.print(sb);

            header = line;
        }
    }
}
