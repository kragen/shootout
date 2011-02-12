/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
 
   contributed by Leonhard Holz
   thanks to James McIlree for Fragment idea
*/

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

public class knucleotide
{
   private static final byte A = 0;
   private static final byte T = 1;
   private static final byte C = 2;
   private static final byte G = 3;
   private static final byte BITS_PER_CHAR = 2;
   private static final byte CHAR_BIT_MASK = 3;
   
   private static void countFragmentsOfSize(List<byte[]> nucleotides, int nucleotideLength, Map<Fragment, Fragment> fragments, int fragmentSize)
   {
      long dna = 0, bitmask = 0;

      for (int i = 0; i < fragmentSize; i++) {
         bitmask = bitmask << BITS_PER_CHAR | CHAR_BIT_MASK;
      }

      int i = 0;
      byte[] buffer = nucleotides.get(0);
      
      for (; i < fragmentSize - 1; i++) {
         dna = dna << BITS_PER_CHAR | buffer[i];
      }
      
      int j = i;
      Fragment fragment = new Fragment(fragmentSize);
      Iterator<byte[]> it = nucleotides.iterator();
      while (it.hasNext()) {
         buffer = it.next();
         for (; j < buffer.length && i < nucleotideLength; j++) {
            dna = dna << BITS_PER_CHAR | buffer[j];
            fragment.value = dna & bitmask;
            Fragment counter = fragments.get(fragment);
            if (counter != null) {
               counter.count++;
            } else {
               fragments.put(fragment, fragment);
               fragment = new Fragment(fragmentSize);
            }
            i++;
         }
         j = 0;
      }
   }

   private static void writeFrequencies(SortedSet<Fragment> set)
   {
      int n = 0;
      Iterator<Fragment> i;
      
      i = set.iterator();
      while (i.hasNext()) {
         n += i.next().count;
      }
      
      i = set.iterator();
      while (i.hasNext()) {
         Fragment fragment = i.next();
         System.out.println(String.format("%s %.3f", fragment.toString(), fragment.count * 100.0f / n));
      }
   
      System.out.println();
   }

   @SuppressWarnings("unchecked")
   public static void main(String[] args) throws IOException
   {
      InputStream in = System.in;
      int totalBufferSize = 0, position = 0, chunkSize = 1024 * 128;
      List<byte[]> bufferList = new LinkedList<byte[]>();
      byte[] buffer = new byte[chunkSize];
      bufferList.add(buffer);
      
      for (;;) if (in.read() == '\n' && in.read() == '>' && in.read() == 'T' && in.read() == 'H' && in.read() == 'R' && in.read() == 'E' && in.read() == 'E') {
         while (in.read() != '\n');
         break;
      } 

      int c;
      while ((c = in.read()) > -1) {
         if (c == 'a' || c == 'A') {
            buffer[position++] = A;
         } else if (c == 't' || c == 'T') {
            buffer[position++] = T;
         } else if (c == 'c' || c == 'C') {
            buffer[position++] = C;
         } else if (c == 'g' || c == 'G') {
            buffer[position++] = G;
         }
         if (position == chunkSize) {
            buffer = new byte[chunkSize];
            bufferList.add(buffer);
            totalBufferSize += position;
            position = 0;
         }
      }
      totalBufferSize += position;

      Map<Fragment,Fragment> fragmentsOfSize1 = new HashMap<Fragment,Fragment>();
      countFragmentsOfSize(bufferList, totalBufferSize, fragmentsOfSize1, 1);
      writeFrequencies(new TreeSet<Fragment>(fragmentsOfSize1.values()));

      Map<Fragment,Fragment> fragmentsOfSize2 = new HashMap<Fragment,Fragment>();
      countFragmentsOfSize(bufferList, totalBufferSize, fragmentsOfSize2, 2);
      writeFrequencies(new TreeSet<Fragment>(fragmentsOfSize2.values()));
      
      int[] fragmentLength = { 3, 4, 6, 12, 18 };

      Map<Fragment, Fragment>[] fragmentMaps = new Map[fragmentLength.length];
      for (int i = 0; i < fragmentLength.length; i++) {
         fragmentMaps[i] = new HashMap<Fragment, Fragment>();
         countFragmentsOfSize(bufferList, totalBufferSize, fragmentMaps[i], fragmentLength[i]);
      }
      
      String[] reports = { "GGT", "GGTA", "GGTATT", "GGTATTTTAATT", "GGTATTTTAATTTATAGT" };
      for (int i = 0; i < reports.length; i++) {
         int count = 0;
         Fragment fragment = new Fragment(reports[i]);
         for (int j = 0; j < fragmentMaps.length; j++) {
            Fragment counter = fragmentMaps[j].get(fragment);
            if (counter != null) {
               count += counter.count;
            }
         }
         System.out.println(String.format("%d\t%s", count, fragment.toString()));
      }
   }

   private static class Fragment implements Comparable<Fragment>
   {
      private int count = 1;
      private long value;
      private long charsInValue;

      public Fragment(long size)
      {
         this.charsInValue = size;
      }
      
      public Fragment(String s)
      {
         for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == 'A') {
               value = value << BITS_PER_CHAR | A;
               charsInValue++;
            } else if (c == 'T') {
               value = value << BITS_PER_CHAR | T;
               charsInValue++;
            } else if (c == 'G') {
               value = value << BITS_PER_CHAR | G;
               charsInValue++;
            } else if (c == 'C') {
               value = value << BITS_PER_CHAR | C;
               charsInValue++;
            }
         }
      }
      
      public int hashCode()
        {
           return (int) value;
        }

        public boolean equals(Object o)
        {
           Fragment f = (Fragment) o;
           return f.value == value && f.charsInValue == charsInValue;
        }
       
        public int compareTo(Fragment o)
        {
           return o.count - count;
        }
   
        public String toString()
        {
           long chars = value;
           StringBuilder s = new StringBuilder();
           for (int i = 0; i < charsInValue; i++) {
              int c = (int) (chars & CHAR_BIT_MASK);
              if (c == A) {
                 s.insert(0, 'A');
              } else if (c == T) {
                 s.insert(0, 'T');
              } else if (c == G) {
                 s.insert(0, 'G');
              } else if (c == C) {
                 s.insert(0, 'C');
              }
              chars >>= BITS_PER_CHAR;
           }
           return s.toString();
        }
   }
}
