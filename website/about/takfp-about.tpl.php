<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a>  &#8212;  the same way as this <a href="benchmark.php?test=takfp&lang=java&sort=<?=$Sort;?>">Java program</a>.</p>

<p>Each program calculates a recursive, floating-point, TAK function:
<pre>
TAK(x,y,z)
  y < x   = TAK(TAK(x-1.0,y,z),TAK(y-1.0,z,x),TAK(z-1.0,x,y))
  y >= x  = z
</pre>
</p><br/>
<p>
Calculate TAK(N&#215;3.0, N&#215;2.0, N&#215;1.0). Correct output N = 7 is: 
<pre>14.0</pre></p><br/>
<p>Correct output N = 8 is:
<pre>9.0</pre></p><br/>
<p>Correct output N = 9 is:
<pre>18.0</pre></p><br/>
<p>Correct output N = 10 is:
<pre>11.0</pre></p><br/>

<p>The tak benchmark is described in <a href="http://www.dreamsongs.com/NewFiles/Timrep.pdf">Performance and Evaluation of Lisp Systems</a>, Richard P. Gabriel, 1985, page 81. (1.1MB pdf)</p>


<p>For more information see Eric W. Weisstein, "TAK Function." From <a href="http://mathworld.wolfram.com"><i>MathWorld</i></a>--A Wolfram Web Resource.<br/><a href="http://mathworld.wolfram.com/TAKFunction.html">http://mathworld.wolfram.com/TAKFunction.html</a></p>

