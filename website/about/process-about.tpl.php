<p>Each program should do the <a href="faq.php?sort=<?=$Sort;?>#samething"><b>same&nbsp;thing</b></a>. Programs may use kernel threads, lightweight threads, cooperative threads&#133;
</p>

<p>Each program counts the number of created threads, by incrementing an integer message sent between the threads:
</p>

<ul>
<li>create a chain of N threads such that:

<ul>
<li>each thread
<ul>
<li>can receive an integer message</li>
<li>can store the received message</li>
<li>knows the next thread in the chain</li>
<li>can send the integer message + 1 to the next thread</li>
</ul>
</li>

<li>the last thread... in the chain is different, it:
<ul>
<li>can receive an integer message</li>
<li>can store the received message</li>
<li>there is no next thread</li>
</ul>
</li>
</ul>

<li>send the integer message 0 to the first thread</li>
<li>print the message received by the last thread</li>
</ul>

<p>Correct output N = 3000 is: 
<pre>3000</pre></p><br/>


<p>With a large number of threads this becomes <a href="http://www.mozart-oz.org/documentation/apptut/node9.html#chapter.concurrency.cheap">Death by Concurrency</a>.</p>

<p>(The threads benchmark is essentially the <a href="benchmark.php?test=message&lang=all&sort=<?=$Sort;?>">messages benchmark</a> with a single message send.)</p>