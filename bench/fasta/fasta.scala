/* ------------------------------------------------------------------ */
/* The Great Computer Language Shootout                               */
/* http://shootout.alioth.debian.org/                                 */
/*                                                                    */
/* Contributed by Anthony Borla                                       */
/* ------------------------------------------------------------------ */

object fasta
{
  def main(args: Array[String]): unit =
  {
    val N: int = Integer.parseInt(args(0));

    val fasta: Fasta = new Fasta;

    fasta.repeatFasta("ONE", "Homo sapiens alu", N * 2, ALU, 60);
    fasta.randomFasta("TWO", "IUB ambiguity codes", N * 3, makeCumulativeTable(IUB), 60);
    fasta.randomFasta("THREE", "Homo sapiens frequency", N * 5, makeCumulativeTable(HOMOSAPIENS), 60);
  }

  // -------------

  def makeCumulativeTable(frequencyTable: Array[Frequency]): Array[Frequency] =
  {
    val cumulativeTable: Array[Frequency] = new Array[Frequency](frequencyTable.length);

    var i: int = 0; var cumulativeValue: double = 0.0;

    while (i < frequencyTable.length)
    {
      cumulativeValue = cumulativeValue + frequencyTable(i).value;
      cumulativeTable(i) = new Frequency(frequencyTable(i).key, cumulativeValue);
      i = i + 1;
    }

    return cumulativeTable;
  } 

  // -------------

  val ALU: String =
    "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
    "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
    "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
    "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
    "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
    "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
    "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";

  val IUB: Array[Frequency] = Array(
    new Frequency('a', 0.27), new Frequency('c', 0.12), new Frequency('g', 0.12),
    new Frequency('t', 0.27), new Frequency('B', 0.02), new Frequency('D', 0.02),
    new Frequency('H', 0.02), new Frequency('K', 0.02), new Frequency('M', 0.02),
    new Frequency('N', 0.02), new Frequency('R', 0.02), new Frequency('S', 0.02),
    new Frequency('V', 0.02), new Frequency('W', 0.02), new Frequency('Y', 0.02)
  );

  val HOMOSAPIENS: Array[Frequency] = Array(
    new Frequency('a', 0.3029549426680), new Frequency('c', 0.1979883004921),
    new Frequency('g', 0.1975473066391), new Frequency('t', 0.3015094502008)
  );
}

// -------------------------------

final class Fasta
{
  def repeatFasta(id: String, desc: String, _n: int, sequence: String, lineLength: int): unit =
  {
    val seqlen: int = sequence.length; val lineout = new StringBuffer(); var n: int = _n;  var k: int = 0; 

    Console.println(">" + id + " " + desc);

    while (n > 0)
    {
      var i: int = 0; var m: int = if (n < lineLength) n else lineLength;

      while (i < m)
      {
        if (k == seqlen) k = 0;

        lineout.append(sequence(k));

        k = k + 1; i = i + 1;
      }

      Console.println(lineout.toString()); lineout.setLength(0); n = n - lineLength;
    }
  }  

  // -------------

  def randomFasta(id: String, desc: String, _n: int, cumulativeTable: Array[Frequency], lineLength: int): unit =
  {
    var n: int = _n; val lineout = new StringBuffer();

    Console.println(">" + id + " " + desc);

    while (n > 0)
    {
      var i: int = 0; var m: int = if (n < lineLength) n else lineLength;

      while (i < m) { lineout.append(selectRandom(cumulativeTable)); i = i + 1; }

      Console.println(lineout.toString()); lineout.setLength(0); n = n - lineLength;
    }
  }  

  // -------------

  private def selectRandom(cumulativeTable: Array[Frequency]): char =
  {
    var i: int = 0; val rv: double = generateRandom(1.0);

    while (i < cumulativeTable.length)
    {
      if (rv < cumulativeTable(i).value) return cumulativeTable(i).key;
      i = i + 1;
    }

    cumulativeTable(i - 1).key;
  }

  // -------------

  private def generateRandom(max: double): double =
  {
    return random.next(max);
  }

  // -------------

  private val random: Random = new Random(42);
}

// -------------------------------

final class Frequency(_key: char, _value: double)
{
  override def toString(): String =
  {
    return "[" + key + ":" + value + "]";
  }

  var key: char = _key; var value: double = _value;
}

// -------------------------------

final class Random(seed: int)
{
  def next(max: double): double = 
  {
    last = (last * IA + IC) % IM; return max * last / IM;
  }

  private val IA = 3877;
  private val IC = 29573;
  private val IM = 139968;

  private var last = seed;
}

