<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> &#8212; the same way as this <a href="benchmark.php?test=fasta&lang=lua&sort=<?=$Sort;?>">Lua program</a>.</p>


<p>Each program should
<ul>
  <li>encode the expected cumulative probabilities for 2 alphabets</li>
  <li>generate DNA sequences, by weighted random selection from the alphabets (using the pseudo-random number generator from the <a href="benchmark.php?test=random&lang=all&sort=<?=$Sort;?>">random benchmark</a>)</li>
  <li>generate DNA sequences, by copying from a given sequence</li>
  <li>write 5 sequences line-by-line in <a href="http://en.wikipedia.org/wiki/Fasta_format">FASTA format</a></li>
</ul>
</p>

<p>Correct output N = 1000 is in this 16KB 
<a href="iofile.php?test=<?=$SelectedTest;?>&lang=<?=$SelectedLang;?>&sort=<?=$Sort;?>&file=output">output file</a>.</p>

<p>We'll use the generated FASTA file as input for other benchmarks (The <a href="benchmark.php?test=revcomp&lang=all&sort=<?=$Sort;?>">reverse-complement benchmark</a>).</p>

<p>Random DNA sequences can be based on a variety of <a href="http://www.scmbb.ulb.ac.be/pub/jvanheld/courses/regulatory_sequence_analysis/pdf_files/random_models.pdf">Random Models</a> (554KB pdf). You can use Markov chains or independently distributed nucleotides to <a href="http://rsat.scmbb.ulb.ac.be/rsat/random-seq_form.cgi">generate random DNA sequences online</a>.</p>
