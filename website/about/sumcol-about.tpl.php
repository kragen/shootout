<p>Each program should be implemented the <a
  href="faq.php?sort=<?=$Sort;?>#sameway"><strong>same&nbsp;way</strong></a> - the same way as this <a href="benchmark.php?test=sumcol&amp;lang=icon&amp;sort=<?=$Sort;?>">Icon program</a>.</p>
<p>The sum-file benchmark measures line-oriented I/O and string conversion.</p>
<p>Each program should:</p>
<ul>
<li>read integers from stdin, one line at a time</li>
<li>print the sum of those integers</li>
</ul>

<p>Correct output for this 6KB <a href="iofile.php?test=<?=$SelectedTest;?>&amp;lang=<?=$SelectedLang;?>&amp;sort=<?=$Sort;?>&amp;file=input">input file</a> is:</p>
<pre>
500
</pre>
<br />

<p>Programs should use built-in line-oriented I/O functions rather than custom-code. No line will exceed 128 characters, including newline. Reading one line at a time, the programs should run in constant space.</p>





