<p>Each program should calculate the Ackermann function using the same na&#239ve recursive-algorithm
<pre>
A(x,y)
  x = 0     = y+1
  y = 0     = A(x-1,1)
  otherwise = A(x-1, A(x,y-1))
</pre>
</p><br/>
<p>
Calculate A(3,N). Correct output N = 4 is:
<pre>A(3,4): 125
</pre></p><br/>


<p>The Ackermann benchmark is described in <a href="http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html">Timing Trials, or, the Trials of Timing: Experiments with Scripting and User-Interface Languages</a>.</p>

<p>For more information see Eric W. Weisstein, "Ackermann Function." From <a href="http://mathworld.wolfram.com"><i>MathWorld</i></a>--A Wolfram Web Resource.<br/><a href="http://mathworld.wolfram.com/AckermannFunction.html">http://mathworld.wolfram.com/AckermannFunction.html</a></p>