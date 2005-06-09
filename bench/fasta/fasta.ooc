(* The Great Computer Language Shootout
   http://shootout.alioth.debian.org

   contributed by Isaac Gouy (Oberon-2 novice)
*)


MODULE fasta;
IMPORT Shootout, Random, Strings, Out;

CONST
   LineLength = 60;

TYPE
   Frequency = RECORD
      c: CHAR;
      p: LONGREAL;
   END;

   Freqency4 = ARRAY 4 OF Frequency;
   Freqency15 = ARRAY 15 OF Frequency;

VAR
   n: LONGINT;
   homosapiens: Freqency4;
   iub: Freqency15;
   alu: ARRAY 300 OF CHAR;


PROCEDURE SelectRandom(VAR a: ARRAY OF Frequency): CHAR;
VAR
   i: LONGINT;
   r: LONGREAL;
BEGIN
   r := Random.Next(1.0);
   FOR i := 0 TO LEN(a)-1 DO
      IF r < a[i].p THEN RETURN a[i].c; END;
   END;
   RETURN a[LEN(a)-1].c;
END SelectRandom;


PROCEDURE MakeRandomFasta(
   id,desc: ARRAY OF CHAR; VAR a: ARRAY OF Frequency; n: LONGINT);
VAR
   i, m: LONGINT;
BEGIN
   Out.String(">"); Out.String(id); Out.Char(20X); Out.String(desc); Out.Ln;

   WHILE n > 0 DO
      IF n < LineLength THEN m := n; ELSE m := LineLength; END;
      FOR i := 1 TO m DO Out.Char( SelectRandom(a) ); END; Out.Ln;
      DEC(n,LineLength);
   END;
END MakeRandomFasta;


PROCEDURE MakeRepeatFasta(
   id,desc: ARRAY OF CHAR; VAR s: ARRAY OF CHAR; n: LONGINT);
VAR
   j, k, kn, m: LONGINT;
BEGIN
   Out.String(">"); Out.String(id); Out.Char(20X); Out.String(desc); Out.Ln;

   k := 0; kn := Strings.Length(s)-1;
   WHILE n > 0 DO
      IF n < LineLength THEN m := n; ELSE m := LineLength; END;
      j := 1;
      WHILE j <= m DO
         IF k > kn THEN k := 0; END;
         Out.Char(s[k]);
         INC(j); INC(k);
      END;
      Out.Ln;	
      DEC(n,LineLength);
   END;
END MakeRepeatFasta;


PROCEDURE MakeALU(VAR s: ARRAY OF CHAR);
BEGIN
   Strings.Append( "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" ,s);   
   Strings.Append( "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" ,s);
   Strings.Append( "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" ,s);
   Strings.Append( "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" ,s);
   Strings.Append( "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" ,s);
   Strings.Append( "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" ,s);   
   Strings.Append( "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA" ,s);             
END MakeALU;


PROCEDURE MakeCumulative(VAR a: ARRAY OF Frequency);
VAR
   i: LONGINT;
   cp: LONGREAL;
BEGIN
   cp := 0.0;
   FOR i := 0 TO LEN(a) - 1 DO
      cp := cp + a[i].p;
      a[i].p := cp;
   END;
END MakeCumulative;


PROCEDURE MakeIUB(VAR a: Freqency15);
BEGIN
   a[0].c := "a";   a[0].p := 0.27;
   a[1].c := "c";   a[1].p := 0.12;
   a[2].c := "g";   a[2].p := 0.12;
   a[3].c := "t";   a[3].p := 0.27;

   a[4].c := "B";   a[4].p := 0.02;
   a[5].c := "D";   a[5].p := 0.02;
   a[6].c := "H";   a[6].p := 0.02;
   a[7].c := "K";   a[7].p := 0.02;
   a[8].c := "M";   a[8].p := 0.02;
   a[9].c := "N";   a[9].p := 0.02;
  a[10].c := "R";  a[10].p := 0.02;
  a[11].c := "S";  a[11].p := 0.02;
  a[12].c := "V";  a[12].p := 0.02;
  a[13].c := "W";  a[13].p := 0.02;
  a[14].c := "Y";  a[14].p := 0.02;

   MakeCumulative(a);
END MakeIUB;


PROCEDURE MakeHomoSapiens(VAR a: Freqency4);
BEGIN
   a[0].c := "a";   a[0].p := 0.3029549426680;
   a[1].c := "c";   a[1].p := 0.1979883004921;
   a[2].c := "g";   a[2].p := 0.1975473066391;
   a[3].c := "t";   a[3].p := 0.3015094502008;

   MakeCumulative(a);
END MakeHomoSapiens;


BEGIN
   MakeALU(alu);
   MakeIUB(iub);
   MakeHomoSapiens(homosapiens);

   n := Shootout.Argi();
   MakeRepeatFasta('ONE', 'Homo sapiens alu', alu, n*2);
   MakeRandomFasta('TWO', 'IUB ambiguity codes', iub, n*3);
   MakeRandomFasta('THREE', 'Homo sapiens frequency', homosapiens, n*5);
END fasta.
