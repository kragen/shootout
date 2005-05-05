/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Alexei Svitkine
*/

class fasta
{
  public static final int IM = 139968;
  public static final int IA = 3877;
  public static final int IC = 29573;
  public static int last = 42;

  public static final int LineLength = 60;

  // The usual pseudo-random number generator
  public static double random(double max)
  {
    last = (last * IA + IC) % IM;
    return max * last / IM ;
  }

  public static void main(String[] args)
  {
    MakeCumulative(HomoSapiens);
    MakeCumulative(IUB);
    
    int n = 1000;
    if (args.length > 0) n = Integer.parseInt(args[0]);

    MakeRepeatFasta("ONE", "Homo sapiens alu", ALU, n*2);
    MakeRandomFasta("TWO", "IUB ambiguity codes", IUB, n*3);
    MakeRandomFasta("THREE", "Homo sapiens frequency", HomoSapiens, n*5);
  }

  // Weighted selection from alphabet
  public static String ALU =
    "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
    "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
    "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
    "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
    "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
    "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
    "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";

  public static final Frequency[] IUB = new Frequency[] {
    new Frequency('a', 0.27),
    new Frequency('c', 0.12),
    new Frequency('g', 0.12),
    new Frequency('t', 0.27),
    new Frequency('B', 0.02),
    new Frequency('D', 0.02),
    new Frequency('H', 0.02),
    new Frequency('K', 0.02),
    new Frequency('M', 0.02),
    new Frequency('N', 0.02),
    new Frequency('R', 0.02),
    new Frequency('S', 0.02),
    new Frequency('V', 0.02),
    new Frequency('W', 0.02),
    new Frequency('Y', 0.02)
  };

  public static final Frequency[] HomoSapiens = new Frequency[] {
    new Frequency('a', 0.3029549426680),
    new Frequency('c', 0.1979883004921),
    new Frequency('g', 0.1975473066391),
    new Frequency('t', 0.3015094502008)
  };

  public static void MakeCumulative(Frequency[] a) {
    double cp = 0.0;
    for (int i = 0; i < a.length; i++) {
      cp += a[i].p;
      a[i].p = cp;
    }
  }
  
  // naive
  public static char SelectRandom(Frequency[] a) {
    double r = random(1.0);
    for (int i=0; i < a.length; i++)
      if (r < a[i].p) return a[i].c;

    return a[a.length-1].c;
  }
  
  static void MakeRandomFasta(String id, String desc, Frequency[] a, int n) {
    int m = 0;
    System.out.println(">" + id + " " + desc);

    while (n > 0) {
      if (n < LineLength) m = n; else m = LineLength;
      for (int i=0; i<m; i++) System.out.print(SelectRandom(a));
      System.out.println();
      n -= LineLength;
    }
  }
  
  static void MakeRepeatFasta(String id, String desc, String alu, int n) {
    
    int m = 0, k = 0, kn = alu.length();
    System.out.println(">" + id + " " + desc);
    
    while (n > 0) {
      if (n < LineLength) m = n; else m = LineLength;
      for (int i=0; i<m; i++){
        if (k == kn) k = 0;
        System.out.print(alu.charAt(k));
        k++;
      }
      System.out.println();
      n -= LineLength;
    }
  }

  public static class Frequency
  {
    public char c;
    public double p;

    public Frequency(char c, double p) {
      this.c = c;
      this.p = p;
    }
  }
}

