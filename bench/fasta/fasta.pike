/* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Lance Dillon
   significant speedup [used 'String.Buffer' for I/O] by Anthony Borla
*/

class Frequency {
  string code;
  float percent;

  void create(string c, float p) {
    code=c;
    percent=p;
  }
}

int main(int argc, array argv) {
  string ALU="GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"
      "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"
      "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"
      "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"
      "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"
      "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"
      "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";

  array(Frequency) IUB=({ Frequency("a",0.27),
	       Frequency("c",0.12),
	       Frequency("g",0.12),
	       Frequency("t",0.27),
	       Frequency("B",0.02),
	       Frequency("D",0.02),
	       Frequency("H",0.02),
	       Frequency("K",0.02),
	       Frequency("M",0.02),
	       Frequency("N",0.02),
	       Frequency("R",0.02),
	       Frequency("S",0.02),
	       Frequency("V",0.02),
	       Frequency("W",0.02),
	       Frequency("Y",0.02)
  });

  array(Frequency) HomoSapiens=({ Frequency("a",0.3029549426680),
		       Frequency("c",0.1979883004921),
		       Frequency("g",0.1975473066391),
		       Frequency("t",0.3015094502008)
  });

  makeCumulative(HomoSapiens);
  makeCumulative(IUB);

  int n=(int)argv[1];
  makeRepeatFasta("ONE","Homo sapiens alu",ALU,n*2);
  makeRandomFasta("TWO","IUB ambiguity codes",IUB,n*3);
  makeRandomFasta("THREE","Homo sapiens frequency",HomoSapiens,n*5);

}

void makeCumulative(array(Frequency) a) {
  float cp=0.0;
  foreach (a; int ind; Frequency f) {
    cp+=f->percent;
    f->percent=cp;
  }
}

string selectRandom(array(Frequency) a) {
  float r=myrandom(1.0);
  for (int i=0; i<sizeof(a); i++)
    if (r<a[i]->percent)
      return a[i]->code;
  return a[-1]->code;
}

int LineLength=60;

void makeRandomFasta(string id, string desc, array(Frequency) a, int n) {
  int m=0;
  String.Buffer lineout = String.Buffer(); 

  write(">"+id+" "+desc+"\n");

  while (n>0) {
    if (n<LineLength)
      m=n;
    else
      m=LineLength;

    for (int i=0; i<m; i++) lineout->add(selectRandom(a));
    write("%s\n", lineout->get()); n-=LineLength;
  }
}

void makeRepeatFasta(string id, string desc, string alu, int n) {
  int m=0;
  int k=0;
  int kn=sizeof(alu);
  String.Buffer lineout = String.Buffer(); 

  write(">"+id+" "+desc+"\n");

  while (n>0) {
    if (n<LineLength)
      m=n;
    else
      m=LineLength;
    for (int i=0; i<m; i++) {
      if (k==kn)
	k=0;
      lineout->add(sprintf("%c", alu[k]));
      k++;
    }

    write("%s\n", lineout->get()); n-=LineLength;
  }
}
constant IM=139968;
constant IA=3877;
constant IC=29573;
int seed=42;

float myrandom(float max) {
  seed=(seed*IA+IC)%IM;
  return (max*seed/IM);
}

