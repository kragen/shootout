/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Josh Goldfoot
   based on the Nice entry by Isaac Guoy
   modified by Chad Whipkey
*/

import java.io.*;
import java.lang.*;
import java.util.regex.*;

public class regexdna {

    public regexdna() {
    }

    public static void main(String[] args)
            throws IOException
    {
        Reader r = new InputStreamReader(System.in);
        StringBuilder sb = new StringBuilder(10240 * 8);
        char[] cbuf = new char[10240];
        int charsRead;
        while ((charsRead = r.read(cbuf, 0, 10240)) != -1)
            sb.append(cbuf, 0, charsRead);
        String sequence = sb.toString();

        int initialLength = sequence.length();
        sequence = replaceAll(sequence, ">.*\n|\n", "");
        int codeLength = sequence.length();

        String[] variants = { "agggtaaa|tttaccct" ,
                              "[cgt]gggtaaa|tttaccc[acg]",
                              "a[act]ggtaaa|tttacc[agt]t", 
                              "ag[act]gtaaa|tttac[agt]ct", 
                              "agg[act]taaa|ttta[agt]cct", 
                              "aggg[acg]aaa|ttt[cgt]ccct",
                              "agggt[cgt]aa|tt[acg]accct", 
                              "agggta[cgt]a|t[acg]taccct", 
                              "agggtaa[cgt]|[acg]ttaccct" };

        for (String variant : variants)
        {
            int count = 0;
            Matcher m = Pattern.compile(variant).matcher(sequence);
            while (m.find())
                count++;
            System.out.println(variant + " " + count);
        }

        sequence = replaceAll(sequence, "W", "(a|t)");
        sequence = replaceAll(sequence, "Y", "(c|t)");
        sequence = replaceAll(sequence, "K", "(g|t)");
        sequence = replaceAll(sequence, "M", "(a|c)");
        sequence = replaceAll(sequence, "S", "(c|g)");
        sequence = replaceAll(sequence, "R", "(a|g)");
        sequence = replaceAll(sequence, "B", "(c|g|t)");
        sequence = replaceAll(sequence, "D", "(a|g|t)");
        sequence = replaceAll(sequence, "V", "(a|c|g)");
        sequence = replaceAll(sequence, "H", "(a|c|t)");
        sequence = replaceAll(sequence, "N", "(a|c|g|t)");

        System.out.println();
        System.out.println(initialLength);
        System.out.println(codeLength);
        System.out.println(sequence.length());
    }

    private static String replaceAll(String sequence, String search, String replacement)
    {
        final Matcher m = Pattern.compile(search).matcher(sequence);
        final StringBuffer sb = new StringBuffer(sequence.length() + sequence.length() / 10);
        while (m.find())
            m.appendReplacement(sb, replacement);
        m.appendTail(sb);

        return sb.toString();
    }
}
