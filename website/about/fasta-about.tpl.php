<p><strong>diff</strong> program output N = 1000 with this 10KB <a href="iofile.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;file=output">output file</a> to check your program is correct before contributing.
</p>

<p>Each program should</p>
<ul>
  <li>encode the expected cumulative probabilities for 2 alphabets</li>
  <li>generate DNA sequences, by weighted random selection from the alphabets (using the pseudo-random number generator from the <a href="benchmark.php?test=random&amp;lang=all&amp;sort=<?=$Sort;?>">random benchmark</a>)</li>
  <li>generate DNA sequences, by copying from a given sequence</li>
  <li>write 3 sequences line-by-line in <a href="http://en.wikipedia.org/wiki/Fasta_format">FASTA format</a></li>
</ul>

<p>We'll use the generated FASTA file as input for other benchmarks (<a href="benchmark.php?test=revcomp&amp;lang=all&amp;sort=<?=$Sort;?>">reverse-complement</a>, <a href="benchmark.php?test=knucleotide&amp;lang=all&amp;sort=<?=$Sort;?>">k-nucleotide</a>).</p>

<p>Random DNA sequences can be based on a variety of <a href="http://www.scmbb.ulb.ac.be/pub/jvanheld/courses/regulatory_sequence_analysis/pdf_files/random_models.pdf">Random Models</a> (554KB pdf). You can use Markov chains or independently distributed nucleotides to <a href="http://rsat.scmbb.ulb.ac.be/rsat/random-seq_form.cgi">generate random DNA sequences online</a>.</p>
