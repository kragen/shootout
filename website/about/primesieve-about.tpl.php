<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=primesieve&lang=java&sort=<?=$Sort;?>">Java program</a>.

<p>Count the prime numbers from 2 to N, finding each prime number with Eratosthenes Sieve:
<ul>
  <li>for each number
     <ul>
     <li>if the number is unmarked, mark all multiples of the number and increment the count</li>
     </ul>
   </li>
  <li>print the count</li>
</ul>
</p>

<p>Correct output N = 8192 is:
<pre>
Count: 1028
</pre>
</p>
<br/>

<p>Eric W. Weisstein. "Sieve of Eratosthenes." From <a href="http://mathworld.wolfram.com"><i>MathWorld</i></a>--A Wolfram Web Resource.<br/><a href="http://mathworld.wolfram.com/SieveofEratosthenes.html">http://mathworld.wolfram.com/SieveofEratosthenes.html</a></p>