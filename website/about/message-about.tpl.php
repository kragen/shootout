<p>Each program should do the <a href="faq.php?sort=<?=$Sort;?>#samething"><b>same&nbsp;thing</b></a>. Programs may use kernel threads, lightweight threads, cooperative threads&#133;
</p>

<p>Each program counts the number of messages sent between threads:</p>

<ul>
<li>create a chain of 3000 threads such that:

<ul>
<li>each thread
<ul>
<li>can receive an integer message</li>
<li>can store the received message</li>
<li>knows the next thread in the chain</li>
<li>can send the integer message + 1 to the next thread</li>
</ul>
</li>

<li>the last thread in the chain is different, it:
<ul>
<li>can receive an integer message</li>
<li>can store the sum of received messages</li>
<li>there is no next thread</li>
</ul>
</li>
</ul>

<li>N times: send the integer message 0 to the first thread</li>
<li>print the sum of messages received by the last thread</li>
</ul>

<p>Correct output N = 200 is: 
<pre>600000</pre></p><br/>

<p>Similar benchmarks are described in <a href="http://www.sics.se/~joe/ericsson/du98024.html">Performance Measurements of Threads in Java and Processes in Erlang, 1998;</a> and <a href="http://www.sics.se/~joe/ericsson/du98024.html">A Benchmark Test for BCPL Style Coroutines, 2004.</a></p>

<p>(The <a href="benchmark.php?test=process&lang=all&sort=<?=$Sort;?>">threads benchmark</a> is essentially this messages benchmark with a single message send. )</p>