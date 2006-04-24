/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
  contributed by - Lance Dillon
*/

class KNucleotide {
  string sequence;
  int count=1;

  void create(string s) {
    sequence=s;
  }

  void writeFrequencies(int k) {
    mapping(string:KNucleotide) frequencies=generateFrequencies(k);
    array(KNucleotide) list=values(frequencies);
    list=reverse(Array.sort_array(list,lambda(KNucleotide a, KNucleotide b) {
			if (a->count>b->count)
			  return 1;
			if (a->count<b->count)
			  return -1;
			if (a->sequence>b->sequence)
			  return 1;
			if (a->sequence<b->sequence)
			  return -1;
			return 0; } ));
    int sum=sizeof(sequence)-k+1;
    foreach (list; int ind; object kn) {
      predef::write("%s %03.3f\n",kn->sequence,((float)kn->count/(float)sum*100.0));
    }
    predef::write("\n");
  }

  void writeCount(string nucleotideFragment) {
    mapping(string:KNucleotide) frequencies=generateFrequencies(sizeof(nucleotideFragment));
    int count=0;
    KNucleotide item=frequencies[nucleotideFragment];
    if (item)
      count=item->count;
    predef::write("%d\t%s\n",count,nucleotideFragment);
  }


  mapping(string:KNucleotide) generateFrequencies(int length) {
    mapping(string:KNucleotide) frequencies=([]);

    void kFrequency(int offset, int k) {
      int n=sizeof(sequence)-k+1;
      for (int i=offset; i<n; i+=k) {
	string fragment=sequence[i..i+k-1];
	object item=frequencies[fragment];
	if (item) {
	  item->count++;
	} else {
	  frequencies[fragment]=KNucleotide(fragment);
	}
      }
    };

    for (int offset=0; offset<length; offset++)
      kFrequency(offset,length);
    return frequencies;
  }
}

int main(int argc, array argv) {
  Stdio.FILE r=Stdio.stdin;
  string line;
  String.Buffer buffer=String.Buffer();

  while (line=r->gets()) {
    if (line[..5]==">THREE")
      break;
  }

  while (line=r->gets()) {
    if (line[0]=='>')
      break;
    if (line[0]!=';')
      buffer+=upper_case(line);
  }
  
  object kn=KNucleotide(buffer->get());
  kn->writeFrequencies(1);
  kn->writeFrequencies(2);
  
  kn->writeCount("GGT");
  kn->writeCount("GGTA");
  kn->writeCount("GGTATT");
  kn->writeCount("GGTATTTTAATT");
  kn->writeCount("GGTATTTTAATTTATAGT");
}
