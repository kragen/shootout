%!/usr/bin/env slsh
% The Great Computer Language Shootout
% http://shootout.alioth.debian.org/
%
% contributed by John E Davis

static variable IM = 139968;
static variable IA = 3877;
static variable IC = 29573;
static variable Last = 42;

static define random (max)
{
   Last = (Last * IA + IC) mod IM;
   (max * Last) / IM;
}

static define select_random (table, n)
{
   variable p = table.prob;
   variable ch = table.ch;
   variable a = Char_Type[n];
   _for (0, n-1, 1)
   {
      variable i = ();
      variable r = random (1.0);
      a[i] = ch[where (r < p)[0]];
   }
   return a;
}

static define make_random_fasta (id, desc, table, n)
{
   () = fprintf (stdout, ">%s %s\n", id, desc);
   variable width = 60;
   variable todo = n;
   while (todo >= width)
   {
      () = fwrite (select_random (table, width), stdout);
      () = fputs ("\n", stdout);
      todo -= width;
   }
   if (todo)
   {
      () = fwrite (select_random (table, todo), stdout);
      () = fputs ("\n", stdout);
   }
}

static define make_repeat_fasta (id, desc, s, n)
{
   () = fprintf (stdout, ">%s %s\n", id, desc);
   variable width = 60;
   variable todo = n;
   variable len = strlen (s);
   while (len < n)
   {
      s = strcat (s, s);
      len *= 2;
   }
   variable i = [0:width-1];
   while (todo >= width)
   {
      () = fputs (s[i], stdout);
      () = fputs ("\n", stdout);
      i += width;
      todo -= width;
   }
   !if (todo) return;

   i = i[0];
   () = fputs (s[[i:i+todo-1]], stdout);
   () = fputs ("\n", stdout);
}

static define make_table ()
{
   variable n = _NARGS/2;
   variable t = struct 
   {
      ch, prob
   };
   t.ch = Char_Type[n];
   t.prob = Double_Type[n];
   _for (n-1, 0, -1)
   {
      variable i = ();
      t.prob[i] = ();
      t.ch[i] = ();
   }
   t.prob = cumsum (t.prob);
   return t;
}

static variable IUB = 
   make_table (('a', 0.27), ('c', 0.12), ('g', 0.12), ('t', 0.27),
               ('B', 0.02), ('D', 0.02), ('H', 0.02), ('K', 0.02),
               ('M', 0.02), ('N', 0.02), ('R', 0.02), ('S', 0.02),
               ('V', 0.02), ('W', 0.02), ('Y', 0.02));
static variable Homosapiens =
   make_table (('a', 0.3029549426680), ('c', 0.1979883004921),
      ('g', 0.1975473066391), ('t', 0.3015094502008));

static variable ALU = 
   "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG" +
   "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA" +
   "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT" +
   "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA" +
   "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG" +
   "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC" +
   "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";

define slsh_main ()
{
   variable n = 1000;
   if (__argc > 1) n = integer (__argv[1]);
   make_repeat_fasta ("ONE","Homo sapiens alu",ALU,n*2);
   make_random_fasta ("TWO", "IUB ambiguity codes",IUB,n*3);
   make_random_fasta ("THREE","Homo sapiens frequency",Homosapiens,n*5);
}
