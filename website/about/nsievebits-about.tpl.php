<p>Each program should count the prime numbers from 2 to M, using the same na&#239;ve Sieve of Eratosthenes algorithm:</p>
<ul>
  <li>create an array of M <strong>bit flags</strong></li>
  <li>for each index number
     <ul>
     <li>if the flag value at that index is true
      <ul>
      <li>set all the flag values at multiples of that index false</li>
      <li>increment the count</li>
      </ul>
     </li>
     </ul>
   </li>
</ul>

<p>Calculate 3 prime counts, for M = 2<sup>N</sup> &#215; 10000, 2<sup>N-1</sup> &#215; 10000, and 2<sup>N-2</sup> &#215; 10000. Correct output N = 2 is:</p>
<pre>
Primes up to    40000    4203
Primes up to    20000    2262
Primes up to    10000    1229
</pre>
<br />

<p>A variation on the <a href="benchmark.php?test=nsieve&amp;lang=all&amp;sort=<?=$Sort;?>">nsieve benchmark</a>.</p>