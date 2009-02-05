/* The Computer Language Benchmarks Game
   http://shootout.alioth.debian.org/
 
   contributed by The Anh Tran
 */

import java.util.*;
import java.io.*;
import java.text.*;
import java.util.concurrent.atomic.*;

public final class knucleotide
{
    public static void main (String[] args)
    {
        final char[] source = ReadInput();
        
        final String[] result = new String[7];
        final AtomicInteger job = new AtomicInteger(6);
        
        Thread[] pool = new Thread[Runtime.getRuntime().availableProcessors()];
        for (int i = 0; i < pool.length; i++)
        {
            pool[i] = new Thread()
            {
                public void run()
                {
                    int j;
                    while ((j = job.getAndDecrement()) >= 0)
                    {
                        switch (j)
                        {
                            case 0:
                                result[j] = WriteFreq(source, 1);
                                break;
                            case 1:
                                result[j] = WriteFreq(source, 2);
                                break;
                            case 2:
                                result[j] = WriteFreq(source, "ggt");
                                break;
                            case 3:
                                result[j] = WriteFreq(source, "ggta");
                                break;
                            case 4:
                                result[j] = WriteFreq(source, "ggtatt");
                                break;
                            case 5:
                                result[j] = WriteFreq(source, "ggtattttaatt");
                                break;
                            case 6:
                                result[j] = WriteFreq(source, "ggtattttaatttatagt");
                                break;
                            default:
                                throw new RuntimeException("Invalid task");
                        }
                    }
                }
            };
            pool[i].start();
        }
        
        for (Thread t : pool)
        {
            try
            {
                t.join();
            }
            catch (InterruptedException e)
            {
                e.printStackTrace();
            }
        }
        
        for (String s : result)
            System.out.println(s);
    }

    private static char[] ReadInput()
    {
        try
        {
            BufferedReader reader = new BufferedReader (new InputStreamReader (System.in, "US-ASCII"));
            
            String s = null;
            while ((s = reader.readLine()) != null)
            {
                if (s.startsWith(">THREE"))
                    break;
            }

            StringBuilder sb = new StringBuilder();
            while ((s = reader.readLine()) != null)
                sb.append (s);

            return sb.toString().toCharArray();
        }
        catch (IOException ie)
        {
            ie.printStackTrace ();
        }
        
        return null;
    }

    static final class Key implements Comparable<Key>
    {
        public int     hash;
        public char[]  key;
        public int  count;
        
        public Key(int frame)
        {
            key = new char[frame];
        }
        
        public Key(final Key k)
        {
            hash = k.hash;
            key = k.key.clone();
        }
        
        public void ReHash(final char[] k, int offset)
        {
            for (int i = 0; i < key.length; i++)
                key[i] = k[offset + i];
            
            hash = 0;
            for (char c : key)
                hash = hash * 31 + c;
        }

        public int hashCode()
        {
            return hash;
        }

        public boolean equals(Object obj)
        {
            return hash == ((Key)obj).hash;
        }

        public int compareTo(Key o)
        {
            return o.count - count;
        }

    }

    static final class Value
    {
        public int  value;
        
        public Value()
        {   
            value = 1;
        }
    }
    
    private static void CalculateFreq(Map<Key, Value> htb, final char[] input, int frame_size)
    {
        int end = input.length - frame_size +1;
        Key k = new Key(frame_size);
        
        for (int i = 0; i < end; i++)
        {
            k.ReHash(input, i);
            
            Value v = htb.get(k);
            if (v != null)
                v.value++;
            else
                htb.put(new Key(k), new Value());
        }
    }

    private static String WriteFreq(final char[] input, int frame_size)
    {
        Map<Key, Value> m = new HashMap<Key, Value>();
        CalculateFreq(m, input, frame_size);
        
        ArrayList<Key> result = new ArrayList<Key>();
        result.addAll(m.keySet());
        for (Key k : result)
            k.count = m.get(k).value;
        
        Collections.sort(result);

        float totalchar = input.length - frame_size +1;
        StringBuilder sb = new StringBuilder();

        for (Key k : result)
            sb.append(String.format("%s %.3f\n", 
                String.valueOf(k.key).toUpperCase(), 
                (float)(k.count) * 100.0f / totalchar)  );
        
        return sb.toString();
    }

    private static String WriteFreq(final char[] input, String specific)
    {
        Map<Key, Value> m = new HashMap<Key, Value>();
        CalculateFreq(m, input, specific.length());

        Key k = new Key(specific.length());
        k.ReHash(specific.toCharArray(), 0);
        Value v = m.get(k);
        
        return String.format("%d\t%s", v.value, specific.toUpperCase());
    }
}
