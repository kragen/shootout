<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=nsieve&lang=csharp&sort=<?=$Sort;?>">C# program</a>.

<p>Count the prime numbers from 2 to M, finding each prime number with a na&#239ve implementation of the Sieve of Eratosthenes:
<ul>
  <li>create an array of M <b>bit flags</b></li>
  <li>for each index number
     <ul>
     <li>if the flag value at that index is true</li>
     <ul>
     <li>set all the flag values at multiples of that index false</li>
     <li>increment the count</li>
     </ul>
     </li>
     </ul>
   </li>
</ul>
</p>

<p>Calculate 3 prime counts, for M = 2<sup>N</sup> &#215; 10000, 2<sup>N-1</sup> &#215; 10000, and 2<sup>N-2</sup> &#215; 10000. Correct output N = 2 is:
<pre>
Primes up to    40000    4203
Primes up to    20000    2262
Primes up to    10000    1229
</pre>
</p>
<br/>


<p>A variation on the <a href="benchmark.php?test=nsieve&lang=all&sort=<?=$Sort;?>">nsieve benchmark</a>.</p>