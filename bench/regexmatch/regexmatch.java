/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Paul Lofte
*/

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
public class regexmatch 
   {
   public static void main(String args[]) {
      try {
         String regex = "(^|^\\D*[^\\(\\d])"    // must be preceeded by non-digit
            + "((\\(\\d\\d\\d\\))|(\\d\\d\\d))" // match 2: Area Code inner match 3: area with perens, 
                                                //inner match 4: without perens 
            + "[ ]"                             // area code followed by one space
            + "(\\d\\d\\d)"                     //match 5: prefix of 3 digits
            + "[ -]"                            // prefix followed by space or dash
            + "(\\d\\d\\d\\d)"                  // match 6: last 4 digits
            + "(\\D*$)";                        // followed by non numeric chars 

         Pattern phonePattern = Pattern.compile(regex);
         BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
         String line;
         int count = 0;
         while ((line = in.readLine()) != null) {
            Matcher match = phonePattern.matcher(line);
            if (match.matches()) {
               count++;
               if (match.group(3) != null) {
                     System.out.println(count + ": " 
                                       + match.group(3) + " " 
                                       + match.group(5) + "-" 
                                       + match.group(6));
               } else {
                     System.out.println(count + ": (" 
                                       + match.group(4) + ") " 
                                       + match.group(5) + "-" 
                                       + match.group(6));
               }
            }

         }
         in.close();
            
      } catch (IOException e) {
         System.err.println(e);
      }
      System.exit(0);
   }
}