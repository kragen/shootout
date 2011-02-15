/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
 
   contributed by Leonhard Holz
   thanks to James McIlree for Fragment idea
*/

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class knucleotide
{
   private static final byte A = 0;
   private static final byte T = 1;
   private static final byte C = 2;
   private static final byte G = 3;
   private static final byte BITS_PER_CHAR = 2;
   private static final byte CHAR_BIT_MASK = 3;
   
   private static final int CHUNK_SIZE = 1024 * 1024 * 2;
   private static final int NUMBER_OF_CORES = Runtime.getRuntime().availableProcessors();
   
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
   public static void main(String[] args) throws IOException, InterruptedException, ExecutionException
   {
      boolean inGenom = false;
      ExecutorService service = Executors.newFixedThreadPool(NUMBER_OF_CORES);
      List<Future<List<byte[]>>> encoders = new ArrayList<Future<List<byte[]>>>();
      
      int read = CHUNK_SIZE, i;
      while (read == CHUNK_SIZE) {
         i = 0;
         byte[] buffer = new byte[CHUNK_SIZE];
         read = System.in.read(buffer);
         if (!inGenom) {
            for (; i < read; i++) if (buffer[i] == '\n' && i + 6 < buffer.length) {
               if (buffer[++i] == '>' && buffer[++i] == 'T' && buffer[++i] == 'H' && buffer[++i] == 'R' && buffer[++i] == 'E' && buffer[++i] == 'E') {
                  while (buffer[i++] != '\n');
                  inGenom = true;
                  break;
               }
            }
         }
         if (inGenom) {
            Encoder encoder = new Encoder(buffer, i, read);
            encoders.add(encoder);
            service.execute(encoder);
         }
      }

      Counter size1 = new Counter(encoders, 1);
      service.execute(size1);
      Counter size2 = new Counter(encoders, 2);
      service.execute(size2);

      String[] fragments = { "GGT", "GGTA", "GGTATT" };
      Counter[] counterMap = new Counter[fragments.length];
      for (i = 0; i < fragments.length; i++) {
         counterMap[i] = new Counter(encoders, fragments[i].length());
         service.execute(counterMap[i]);
      }

      int numberOfMaps = NUMBER_OF_CORES * 2 < encoders.size() ? NUMBER_OF_CORES * 2 : encoders.size();
      int subListSize = encoders.size() / numberOfMaps;
      String[] largeFragments = { "GGTATTTTAATT", "GGTATTTTAATTTATAGT" };
      List<Future<List<byte[]>>>[] encoderMap = new List[numberOfMaps];
      Counter[][] largeCounterMap = new Counter[largeFragments.length][numberOfMaps];

      for (i = 0; i < encoderMap.length - 1; i++) {
         encoderMap[i] = encoders.subList(i * subListSize, i * subListSize + subListSize);
      }
      encoderMap[i] = encoders.subList(i * subListSize, encoders.size());
      for (i = 0; i < largeFragments.length; i++) {
         for (int j = 0; j < largeCounterMap[i].length; j++) {
            largeCounterMap[i][j] = new Counter(encoderMap[j], largeFragments[i].length());
            service.execute(largeCounterMap[i][j]);
         }
      }
      
      service.shutdown();
      
      writeFrequencies(new TreeSet<Fragment>(size1.get().values()));
      writeFrequencies(new TreeSet<Fragment>(size2.get().values()));

      for (i = 0; i < fragments.length; i++) {
         Fragment fragment = new Fragment(fragments[i]);
         Fragment counter = counterMap[i].get().get(fragment);
         System.out.println(String.format("%d\t%s", counter.count, fragments[i]));
      }
   
      for (i = 0; i < largeFragments.length; i++) {
         int count = 0;
         Fragment fragment = new Fragment(largeFragments[i]);
         for (int j = 0; j < largeCounterMap[i].length; j++) {
            Fragment counter = largeCounterMap[i][j].get().get(fragment);
            if (counter != null) {
               count += counter.count;
            }
         }
         System.out.println(String.format("%d\t%s", count, largeFragments[i]));
      }
   }

   private static class Encoder implements Future<List<byte[]>>, Runnable
   {
      private byte[] src;
      private int start, end;
      private boolean done = false;
      private List<byte[]> result = new ArrayList<byte[]>();
      
      private static final int CHUNK_SIZE = 1024 * 250;
      
      private Encoder(byte[] src, int start, int end)
      {
         this.src = src;
         this.start = start;
         this.end = end;
      }

      @Override
      public boolean cancel(boolean mayInterruptIfRunning)
      {
         return false;
      }

      @Override
      public List<byte[]> get() throws InterruptedException, ExecutionException
      {
         while (!done) try {
            Thread.sleep(100);
         } catch (InterruptedException e) {
            // ignored
         }
         return result;
      }

      @Override
      public List<byte[]> get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException
      {
         return get();
      }

      @Override
      public boolean isCancelled()
      {
         return false;
      }

      @Override
      public boolean isDone()
      {
         return done;
      }
      
      @Override
      public void run()
      {
         int p = 0;
         byte[] encoded = new byte[CHUNK_SIZE];
         
         for (int i = start; i < end; i++) {
            byte c = src[i];
            if (c == 'a' || c == 'A') {
               encoded[p++] = A;
               if (p == encoded.length) {
                  result.add(encoded);
                  encoded = new byte[CHUNK_SIZE];
                  p = 0;
               }
            } else if (c == 't' || c == 'T') {
               encoded[p++] = T;
               if (p == encoded.length) {
                  result.add(encoded);
                  encoded = new byte[CHUNK_SIZE];
                  p = 0;
               }
            } else if (c == 'c' || c == 'C') {
               encoded[p++] = C;
               if (p == encoded.length) {
                  result.add(encoded);
                  encoded = new byte[CHUNK_SIZE];
                  p = 0;
               }
            } else if (c == 'g' || c == 'G') {
               encoded[p++] = G;
               if (p == encoded.length) {
                  result.add(encoded);
                  encoded = new byte[CHUNK_SIZE];
                  p = 0;
               }
            }
         }
      
         if (p != 0) {
            byte[] last = new byte[p];
            System.arraycopy(encoded, 0, last, 0, p);
            result.add(last);
         }
      
         done = true;
      }
   }
   
   private static class Fragment implements Comparable<Fragment>, Cloneable
   {
      private int count = 1;
      private int charsInValue;
      private long value;

      public Fragment(int size)
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
      
      @Override
      public Object clone() throws CloneNotSupportedException
        {
           return super.clone();
        }

      @Override
      public int hashCode()
        {
           return (int) value;
        }

      @Override
        public boolean equals(Object o)
        {
           Fragment f = (Fragment) o;
           return f.value == value;
        }
       
      @Override
        public int compareTo(Fragment o)
        {
           return o.count - count;
        }
   
      @Override
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

   private static class Counter implements Future<Map<Fragment, Fragment>>, Runnable
   {
      private int fragmentSize;
      private boolean done = false;
      private List<Future<List<byte[]>>> nucleotides;
      private Map<Fragment, Fragment> fragments = new HashMap<Fragment, Fragment>();
      
      private Counter(List<Future<List<byte[]>>> nucleotides, int fragmentSize)
      {
         this.nucleotides = nucleotides;
         this.fragmentSize = fragmentSize;
      }
      
      @Override
      public boolean cancel(boolean mayInterruptIfRunning)
      {
         return false;
      }

      @Override
      public Map<Fragment, Fragment> get() throws InterruptedException, ExecutionException
      {
         while (!done) try {
            Thread.sleep(100);
         } catch (InterruptedException e) {
            // ignored
         }
         return fragments;
      }

      @Override
      public Map<Fragment, Fragment> get(long timeout, TimeUnit unit) throws InterruptedException, ExecutionException, TimeoutException
      {
         return get();
      }

      @Override
      public boolean isCancelled()
      {
         return false;
      }

      @Override
      public boolean isDone()
      {
         return done;
      }

      @Override
      public void run()
      {
         long dna = 0, bitmask = 0;

         for (int i = 0; i < fragmentSize; i++) {
            bitmask = bitmask << BITS_PER_CHAR | CHAR_BIT_MASK;
         }

         try {
         
            int j = 0;
            byte[] buffer = nucleotides.get(0).get().get(0);

            for (; j < fragmentSize - 1; j++) {
               dna = dna << BITS_PER_CHAR | buffer[j];
            }

            Fragment fragment = new Fragment(fragmentSize);
            Iterator<Future<List<byte[]>>> fit = nucleotides.iterator();

            while (fit.hasNext()) {
               Future<List<byte[]>> encoder = fit.next();
               Iterator<byte[]> bit = encoder.get().iterator();
            
               while (bit.hasNext()) {
                  buffer = bit.next();
               
                  for (; j < buffer.length; j++) {
                     dna = dna << BITS_PER_CHAR | buffer[j];
                     fragment.value = dna & bitmask;
                     Fragment counter = fragments.get(fragment);
                  
                     if (counter != null) {
                        counter.count++;
                     } else {
                        fragments.put(fragment, fragment);
                        fragment = (Fragment) fragment.clone();
                     }
                  }
                  j = 0;
               }
            }
         } catch (Exception e) {
            e.printStackTrace();
         }
         
         done = true;
      }
   }
}
