<p>Each program should be implemented the <a
  href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=heapsort&lang=gcc&sort=<?=$Sort;?>">C program</a>.</p>
<p>Programs implement an in-place heapsort function that takes
  arguments (N, ARY), where N is the number of elements in the array
  ARY, starting from index 1.  ARY is passed by reference.</p>

<p>Correct output N = 1000 is:
<pre>
0.9990640718
</pre>
</p>
<br/>

<p>The heapsort algorithm is from <i>Numerical Recipes in C</i>, section
  9.2, page 247.  Initialize the array with random double-precision floating point numbers using the naive
  (and lightweight) pseudo-random number generator from the <a
  href="benchmark.php?test=random&lang=all&sort=<?=$Sort;?>">random benchmark</a>.</p>

