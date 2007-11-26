/* The Computer Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Isaac Gouy
 * modified by Antti Lankila for generics
 */

using System;
using System.IO;
using System.Collections.Generic;
using System.Text;

public class program {
    public static void Main(string[] args) {
	string line;
	StreamReader source = new StreamReader(Console.OpenStandardInput());
	StringBuilder input = new StringBuilder();

	while ( (line = source.ReadLine() ) != null ) {
	    if (line[0] == '>' && line.Substring(1, 5) == "THREE")
		break;
	}
	 
	while ( (line = source.ReadLine()) != null ) {
            char c = line[0];
            if (c == '>')
               break;
            if (c != ';')
               input.Append(line.ToUpper());
	}

	KNucleotide kn = new KNucleotide(input.ToString());
        input = null;
	kn.WriteFrequencies(1);
	kn.WriteFrequencies(2);

	kn.WriteCount("GGT");
	kn.WriteCount("GGTA");
	kn.WriteCount("GGTATT");
	kn.WriteCount("GGTATTTTAATT");
	kn.WriteCount("GGTATTTTAATTTATAGT");
    }
}

public class KNucleotide {
    /* freq[foo] ++ implies a get and a set. */
    internal class Value {
	internal int v;

	internal Value(int v)
	{
	    this.v = v;
	}
    }

    private Dictionary<string, Value> frequencies = new Dictionary<string, Value>();
    private string sequence;

    public KNucleotide(string s)
    {
	sequence = s;
    }

    public void WriteFrequencies(int nucleotideLength) {
	GenerateFrequencies(nucleotideLength);

	List<KeyValuePair<string, Value>> items = new List<KeyValuePair<string, Value>>(frequencies);
	items.Sort(SortByFrequencyAndCode);

	int sum = sequence.Length - nucleotideLength + 1;
	foreach (KeyValuePair<string, Value> each in items) {
	    double percent = each.Value.v * 100.0 / sum;
	    Console.WriteLine("{0} {1:f3}", each.Key, percent);
	}
	Console.WriteLine("");
    }

    public void WriteCount(string nucleotideFragment) {
	GenerateFrequencies(nucleotideFragment.Length);

	int count = 0;
	if (frequencies.ContainsKey(nucleotideFragment))
	    count = frequencies[nucleotideFragment].v;
	Console.WriteLine("{0}\t{1}", count, nucleotideFragment);
    }

    private void GenerateFrequencies(int length) {
	frequencies.Clear();
	for (int frame = 0; frame < length; frame++)
	    KFrequency(frame, length);
    }

    private void KFrequency(int readingFrame, int k) {
	int n = sequence.Length - k + 1;
	/* string.Substring is a malloc monster :( */
	if (k > 6) {
	    for (int i = readingFrame; i < n; i += k) {
		string knucleo = sequence.Substring(i, k);
		if (frequencies.ContainsKey(knucleo))
		    frequencies[knucleo].v ++;
		else
		    frequencies[knucleo] = new Value(1);
	    }
	} else {
	    for (int i = readingFrame; i < n; i += k) {
		string knucleo = sequence.Substring(i, k);
		try {
		    frequencies[knucleo].v ++;
		}
		catch (KeyNotFoundException) {
		    frequencies[knucleo] = new Value(1);
		}
	    }
	}
    }

    int SortByFrequencyAndCode(KeyValuePair<string, Value> item1, KeyValuePair<string, Value> item2) {
	int comparison = item2.Value.v.CompareTo(item1.Value.v);
	if (comparison == 0) return item1.Key.CompareTo(item2.Key);
	else return comparison;
    }
}
