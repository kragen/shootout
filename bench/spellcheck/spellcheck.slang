define main()
{
   variable dict = Assoc_Type[Int_Type, 0];
   foreach (fopen("Usr.Dict.Words", "r")) using ("wsline")
     {
	variable word = ();
	dict[word] = 1;
     }
   foreach (stdin) using ("wsline")
     {
	word = ();
	!if (dict[word])
	  () = fprintf (stdout, "%s\n", word);
     }
}

main();
