define main()
{
   variable nl, nw, nc;
   
   nl = 0; nw = 0; nc = 0;
   
   foreach (stdin) using ("line")
     {
	variable line = ();
        nl++;
	nc += strlen (line);
	nw += length (strtok (line));
     }

   fprintf (stdout, "%d %d %d\n", nl, nw, nc);
}

main()
