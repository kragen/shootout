#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: wordfreq.pike,v 1.2 2004-07-03 05:36:11 bfulgham Exp $
// http://shootout.alioth.debian.org/
// from: Fredrik Noring

void main()
{
    mapping(string:int) dictionary = ([]);
    string buffer = "";

    array(string) f = filter(map(enumerate(128),
				   lambda(int i)
				   {
				       return !('A' <= i && i <= 'Z' ||
						'a' <= i && i <= 'z' ||
						i == ' ') &&
					      sprintf("%c", i);
				   }), `!=, 0);
    array(string) t = allocate(sizeof(f), " ");

    for(;;)
    {
	  string data =
	      buffer + replace(lower_case(Stdio.stdin.read(4096)), f, t);
	  
	  if(!sizeof(data))
	      break;
	  
	  array(string) words = data/" ";

	  if(1 < sizeof(words) && sizeof(words[-1]))
	      buffer = words[-1],
	       words = words[..sizeof(words)-2];
	  else
	      buffer = "";

	  foreach(words, string word)
	      dictionary[word]++;
    }
    
    m_delete(dictionary, "");

    mapping(int:array(string)) revdictionary = ([]);
    array(string) words = indices(dictionary);
    array(int) freqs = values(dictionary);

    for(int i = 0; i < sizeof(dictionary); i++)
	  revdictionary[freqs[i]] += ({ words[i] });

    freqs = sort(indices(revdictionary));
    for(int i = sizeof(freqs)-1; 0 <= i; i--)
    {
	  int freq = freqs[i];
	  words = sort(revdictionary[freq]);
	  
	  for(int j = sizeof(words)-1; 0 <= j; j--)
	      write("%7d %s\n", freq, words[j]);
    }
}
