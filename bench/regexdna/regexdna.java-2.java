/*
  The Computer Language Benchmarks Game
  http://shootout.alioth.debian.org/
  Modifications to Josh Goldfoot version by Byron Foster
  which was modified originally from the Nice entry by Isaac Guoy
*/

import java.io.*;
import java.lang.*;
import java.util.regex.*;

public class regexdna 
{
  
  public static void main(String[] args)
    throws IOException
  {
    BufferedReader br = new BufferedReader (new InputStreamReader(System.in));
    StringBuilder sb = new StringBuilder();
    int initialLength = 0;
    for (String line = ""; line != null; line = br.readLine())
    {
      initialLength += line.length() + 1;
      if (line.startsWith(">")) continue;
      sb.append(line);
    }
    
    String sequence = sb.toString();
    int codeLength = sequence.length();

    String[] variants = 
      {
        "agggtaaa|tttaccct" ,"[cgt]gggtaaa|tttaccc[acg]", "a[act]ggtaaa|tttacc[agt]t",
        "ag[act]gtaaa|tttac[agt]ct", "agg[act]taaa|ttta[agt]cct", "aggg[acg]aaa|ttt[cgt]ccct",
        "agggt[cgt]aa|tt[acg]accct", "agggta[cgt]a|t[acg]taccct", "agggtaa[cgt]|[acg]ttaccct" 
      };
    
  
    for (int i = 0; i < variants.length; i++) 
    {
      String split[] = variants[i].split("\\|");
      int count = 0;
      Matcher m = Pattern.compile(split[0]).matcher(sequence);
      while (m.find())
        count++;
      m = Pattern.compile(split[1]).matcher(sequence);
      while (m.find())
        count++;
      System.out.println(variants[i] + " " + count);
    }

    sb = new StringBuilder();
    for (int i=0; i<sequence.length(); i++)
    {
      char c = sequence.charAt(i);
      switch (c)
      {
      case 'B': sb.append("(c|g|t)"); break;
      case 'D': sb.append("(a|g|t)"); break;
      case 'H': sb.append("(a|c|t)"); break;
      case 'K': sb.append("(g|t)"); break;
      case 'M': sb.append("(a|c)"); break;
      case 'N': sb.append("(a|c|g|t)"); break;
      case 'R': sb.append("(a|g)"); break;
      case 'S': sb.append("(c|g)"); break;
      case 'V': sb.append("(a|c|g)"); break;
      case 'W': sb.append("(a|t)"); break;
      case 'Y': sb.append("(c|t)"); break;
      default: sb.append(c); break;
      }
    }
    
    System.out.println();
    System.out.println(initialLength-1); // Assume file does not end
                                         // with \n
    System.out.println(codeLength);
    System.out.println(sb.length());
  }
}


