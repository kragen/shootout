<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=fasta&lang=lua&sort=<?=$Sort;?>">Lua program</a>.</p>

<p>Each program generates 5 random DNA sequence fragments, and writes them line-by-line in <a href="http://en.wikipedia.org/wiki/Fasta_format">FASTA format</a>.</p>


<p>Correct output N = 1000 is in this 16KB 
<a href="iofile.php?test=<?=$SelectedTest;?>&lang=<?=$SelectedLang;?>&sort=<?=$Sort;?>&file=output">output file</a>.</p>

<p>Random DNA sequences can be based on a variety of <a href="http://www.scmbb.ulb.ac.be/pub/jvanheld/courses/regulatory_sequence_analysis/pdf_files/random_models.pdf">Random Models</a> (554KB pdf). You can use Markov chains or independently distributed nucleotides to <a href="http://rsat.scmbb.ulb.ac.be/rsat/random-seq_form.cgi">generate random DNA sequences online</a>.</p>
