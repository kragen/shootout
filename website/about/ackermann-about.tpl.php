<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=ackermann&lang=clean&sort=<?=$Sort;?>">Clean program</a>. All solutions must use recursion.</p>
<p>This benchmark is described in the Kernighan and Wyk study <a href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html"> Timing Trials, or, the Trials of Timing: Experiments with Scripting and User-Interface Languages</a>, where they say it will give a language's function call mechanism a workout.  However, this probably isn't so accurate for languages that do tail-call elimination, since they essentially turn recursive tail-calls into iterative loops.</p>

<p>Correct output N = 4 is:
<pre>Ack(3,4): 125
</pre></p><br/>

<p class="a">The <a href="http://pweb.netcom.com/~hjsmith/Ackerman.html">Ackermann function</a> is the simplest example of a well-defined total function which is computable but not primitive recursive. See the article &quot;A function to end all functions&quot; by Gunter Dötzel, Algorithm 2.4, Oct 1991, Pg 16. The function f(x) = A(x, x)
grows much faster than polynomials or exponentials. The definition is:
<pre class="a">1. If x = 0 then A(x, y) = y + 1
2. If y = 0 then A(x, y) = A(x-1, 1)
3. Otherwise,    A(x, y) = A(x-1, A(x, y-1))</pre></p>