<p>Each program should do the <a href="faq.php?sort=<?=$Sort;?>#samething"><b>same&nbsp;thing</b></a>.</p>

<p>Essentially the benchmark is the-same-as the wordcount test in <a
  href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html">
  Timing Trials, or, the Trials of Timing: Experiments with Scripting
  and User-Interface Languages</a> by Brian W. Kernighan and
  Christopher J. Van Wyk.</p>

<p>Each program reads the input from standard input; counts lines, words (whitespace delimited tokens), and characters; and outputs those counts.  Programs should not read more than 4K input at a time. Programs can assume the file ends in a newline, and programs should handle arbitrarily long lines.</p>

<p>Correct output for this 6KB <a href="iofile.php?test=<?=$SelectedTest;?>&lang=<?=$SelectedLang;?>&sort=<?=$Sort;?>&file=input">input file</a> (file content duplicated N = 500 times) is: 
<pre>
12500 68500 3048000
</pre>
</p>
<br/>

<p>(Note that as in the original version, whitespace is
  defined as space, newline and tab characters, which is a little
  different from the Unix <b>wc</b> command.)</p>

