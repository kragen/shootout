/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by Greg Haines
 * based on work by Michael Stover
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class regexdna
{
   private static final Map<String,String> replacements = 
      new HashMap<String,String>(11);
   private static final Pattern newSeqPattern = 
      Pattern.compile("[WYKMSRBDVHN]");
   private static final String[] variants = { 
      "agggtaaa|tttaccct", 
      "[cgt]gggtaaa|tttaccc[acg]",
      "a[act]ggtaaa|tttacc[agt]t",
      "ag[act]gtaaa|tttac[agt]ct",
      "agg[act]taaa|ttta[agt]cct",
      "aggg[acg]aaa|ttt[cgt]ccct",
      "agggt[cgt]aa|tt[acg]accct",
      "agggta[cgt]a|t[acg]taccct",
      "agggtaa[cgt]|[acg]ttaccct"
   };

   static
   {
      replacements.put("W", "(a|t)");
      replacements.put("Y", "(c|t)");
      replacements.put("K", "(g|t)");
      replacements.put("M", "(a|c)");
      replacements.put("S", "(c|g)");
      replacements.put("R", "(a|g)");
      replacements.put("B", "(c|g|t)");
      replacements.put("D", "(a|g|t)");
      replacements.put("V", "(a|c|g)");
      replacements.put("H", "(a|c|t)");
      replacements.put("N", "(a|c|g|t)");
   }
   
   private static final class NewSeqThread extends Thread
   {
      private final String sequence;
      private final AtomicInteger newSeqLength;
      private final AtomicInteger inputLength;

      private NewSeqThread(final ThreadGroup threadGroup, 
            final String sequence, final AtomicInteger newSeqLength, 
            final AtomicInteger inputLength)
      {
         super(threadGroup, "newSeq");
         this.sequence = sequence;
         this.newSeqLength = newSeqLength;
         this.inputLength = inputLength;
      }

      @Override
      public final void run()
      {
         final StringBuffer buf = new StringBuffer(
            (int)(this.inputLength.get() * 1.32));
         final Matcher m = newSeqPattern.matcher(this.sequence);
         while (m.find())
         {
            m.appendReplacement(buf, "");
            buf.append(replacements.get(m.group()));
         }
         m.appendTail(buf);
         this.newSeqLength.set(buf.length());
      }
   }

   private static final class VariantThread extends Thread
   {
      private final Map<String,Integer> results;
      private final String variant;
      private final String sequence;

      private VariantThread(final ThreadGroup threadGroup, 
            final String name, final Map<String,Integer> results, 
            final String variant, final String sequence)
      {
         super(threadGroup, name);
         this.results = results;
         this.variant = variant;
         this.sequence = sequence;
      }

      @Override
      public final void run()
      {
         int count = 0;
         final Matcher m = Pattern.compile(this.variant)
                        .matcher(this.sequence);
         while (m.find())
         {
            count++;
         }
         this.results.put(this.variant, count);
      }
   }
   
   private static String readInput(final AtomicInteger inputLength, 
         final AtomicInteger seqLength)
   throws IOException
   {
      final StringBuilder sb = new StringBuilder(10000000);
      final BufferedReader r = new BufferedReader(
         new InputStreamReader(System.in, Charset.defaultCharset()));
      int commentLength = 0;
      try
      {
         String line;
         while ((line = r.readLine()) != null)
         {
            if (line.charAt(0) == '>')
            {
               commentLength += line.length() + 1;
            }
            else
            {
               sb.append(line);
               commentLength += 1;
            }
         }
      }
      finally
      {
         r.close();
      }
      seqLength.set(sb.length());
      inputLength.set(seqLength.get() + commentLength);
      return sb.toString();
   }
   
   private static void awaitThreads(final ThreadGroup tg)
   {
      final Thread[] threads = new Thread[variants.length];
      tg.enumerate(threads);
      for (final Thread thread : threads)
      {
         if (thread != null)
         {
            while (thread.isAlive())
            {
               try { thread.join(); } catch (InterruptedException ie){}
            }
         }
      }
      tg.destroy();
   }

   public static void main(final String[] args)
   throws IOException
   {
      final AtomicInteger inputLength = new AtomicInteger(0);
      final AtomicInteger seqLength = new AtomicInteger(0);
      final AtomicInteger newSeqLength = new AtomicInteger(0);
      final Map<String,Integer> results = 
         new HashMap<String,Integer>(variants.length);
      {
         final ThreadGroup threadGroup = new ThreadGroup("regexWork");
         {
            final String sequence = readInput(inputLength, seqLength);
            new NewSeqThread(threadGroup, sequence, 
               newSeqLength, inputLength).start();
            for (final String variant : variants)
            {
               new VariantThread(threadGroup, variant, results, 
                  variant, sequence).start();
            }
         }
         awaitThreads(threadGroup);
      }
      for (final String variant : variants)
      {
         System.out.println(variant + " " + results.get(variant));
      }
      System.out.println();
      System.out.println(inputLength.get());
      System.out.println(seqLength.get());
      System.out.println(newSeqLength.get());
   }
}
