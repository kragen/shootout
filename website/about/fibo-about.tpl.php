<p>Each program should be implemented in the <a
  href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=fibo&lang=clean&sort=<?=$Sort;?>">Clean program</a>. All programs must use recursion.</p>

<p>Programs recursively compute Fibonacci numbers using this
  algorithm:</p>
<p>
<pre>
Fib(0) -> 1
Fib(1) -> 1
Fib(N) -> Fib(N-2) + Fib(N-1)
</pre>
</p>


<p>Correct output N = 32 is:
<pre>
3524578
</pre>
</p>
<br/>


<p>This <a href="http://cubbi.org/serious/fibonacci/bench.html">Fibonacci Benchmark</a> specifies that fib(0) = 1.<br/> It may
 be more correct to define fib(0) = 0, although I've seen plenty of
 references that define it either way.</p>

<p>(What do rabbits, spiral patterns found in plants, the shell of the
  nautilus, Greek architecture, and the golden ratio have in common? - 
  The Fibonacci sequence.)</p>