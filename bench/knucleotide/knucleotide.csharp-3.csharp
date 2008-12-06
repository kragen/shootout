/* The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Isaac Gouy
 * modified by Antti Lankila for generics
 * modified by A.Nahr for performance and throwing unneccesary stuff out
 * remove unsafe code & add multithread by The Anh Tran
 */

using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Threading;

public class knucleotide
{
    static private string   input;
    static private int      task_count = 7;
    static private string[] result = new string[7];

   public static void Main(/*string[] arg*/)
   {
      StreamReader source = new StreamReader(Console.OpenStandardInput());
        
        string line;
      while ((line = source.ReadLine()) != null)
      {
         if (line.StartsWith(">THREE", StringComparison.CurrentCultureIgnoreCase))
            break;
      }

      StringBuilder buf = new StringBuilder(64 * 1024 * 1024); // 64mb
      while ((line = source.ReadLine()) != null)
         buf.Append(line);

        input = buf.ToString();
      buf = null;

        Thread[] threads = new Thread[Environment.ProcessorCount];
        for (int i = 0; i < threads.Length; i++)
        {
            threads[i] = new Thread(worker);
            threads[i].Start();
        }

        foreach (Thread t in threads)
            t.Join();
        foreach (string s in result)
            Console.Out.WriteLine(s);
   }

    private static void worker()
    {
        int j;
        while ((j = Interlocked.Decrement(ref task_count)) >= 0)
        {
            switch (j)
            {
                case 0:
                    result[j] = WriteFrequencies(1);
                    break;
                case 1:
                    result[j] = WriteFrequencies(2);
                    break;
                case 2:
                    result[j] = WriteCount("ggt");
                    break;
                case 3:
                    result[j] = WriteCount("ggta");
                    break;
                case 4:
                    result[j] = WriteCount("ggtatt");
                    break;
                case 5:
                    result[j] = WriteCount("ggtattttaatt");
                    break;
                case 6:
                    result[j] = WriteCount("ggtattttaatttatagt");
                    break;
            }
        }
    }

    private static string WriteFrequencies(int nucleotideLength)
   {
        Dictionary<Key, Value> frequencies = GenerateFrequencies(nucleotideLength);

        List<KeyValuePair<Key, Value>> items = new List<KeyValuePair<Key, Value>>(frequencies);
      items.Sort(SortByFrequencyAndCode);

        StringBuilder buf = new StringBuilder();
      int sum = input.Length - nucleotideLength + 1;

        foreach (KeyValuePair<Key, Value> element in items)
      {
         float percent = element.Value.value * 100.0f / sum;
            buf.AppendFormat("{0} {1:f3}\n", element.Key, percent);
      }

        return buf.ToString();
   }

   private static string WriteCount(string nucleotideFragment)
   {
        Dictionary<Key, Value> frequencies = GenerateFrequencies(nucleotideFragment.Length);
        Key specific = new Key(nucleotideFragment);
      
        int count = 0;
      if (frequencies.ContainsKey(specific))
         count = frequencies[specific].value;
      
        return string.Format("{0}\t{1}", count, nucleotideFragment.ToUpper());
   }

    private static Dictionary<Key, Value> GenerateFrequencies(int frame_size)
   {
        Dictionary<Key, Value> frequencies = new Dictionary<Key, Value>();
        
        Key k = new Key(frame_size);
        Value val;

        int end = input.Length - frame_size + 1;
        for (int index = 0; index < end; index++)
        {
            k.ReHash(input, index);

            frequencies.TryGetValue(k, out val);
            if (val != null)   // must use a class type in order to compare reference with null
                val.value++;   // if we use 'int', this step require 1 more lookup
            else
                frequencies.Add(new Key(k), new Value());
        }
        return frequencies;
   }

   private static int SortByFrequencyAndCode(KeyValuePair<Key, Value> item1, KeyValuePair<Key, Value> item2)
   {
      int comparison = item2.Value.value - item1.Value.value;
      if (comparison == 0) 
            return item1.Key.key.ToString().CompareTo(item2.Key.key.ToString());
      else 
            return comparison;
   }

    internal class Key
    {
        internal int    hash;
        internal char[] key;

        public Key(int frame)
        {
            key = new char[frame];
        }

        public Key(Key k)
        {
            hash = k.hash;
            this.key = (char[])k.key.Clone();
        }
        
        public Key(string s)
        {
            key = new char[s.Length];
            ReHash(s, 0);
        }
        public void ReHash(string k, int offset)
        {
            hash = 0;
            for (int i = 0; i < key.Length; i++)
            {
                key[i] = k[offset + i];
                hash = hash * 31 + key[i];
            }
        }

        public override int GetHashCode()
        {
            return hash;
        }

        public override string ToString()
        {
            return new string(key).ToUpper();
        }

        public override bool Equals(object k)
        {
            return this.hash == ((Key)k).hash;
        }
        /*
        public bool Equals (Key k)
        {
         return this.hash == k.hash;
        }
        */
    }

    internal class Value
    {
        internal int value;

        public Value()
        {
            value = 1;
        }
    }
}

