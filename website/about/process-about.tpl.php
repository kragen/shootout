<p>Each program should do the <a href="faq.php?sort=<?=$Sort;?>#samething"><b>same&nbsp;thing</b></a>.
</p>

<p>Each program counts the number of created process/threads, by incrementing an integer message sent between the process/threads:
</p>

<ul>
<li>take 2 command line args N 1</li>
<li>create a chain of N processes/threads such that:

<ul>
<li>each process, thread
<ul>
<li>can receive an integer message</li>
<li>can store the received message</li>
<li>knows the next process/thread in the chain</li>
<li>can send the integer message + 1 to the next process, thread</li>
</ul>
</li>

<li>the last process/thread... in the chain is different, it:
<ul>
<li>can receive an integer message</li>
<li>can store the received message</li>
<li>there is no next process/thread</li>
</ul>
</li>
</ul>

<li>send the integer message 0 to the first process/thread</li>
<li>print the message received by the last process/thread</li>
</ul>

<p>Correct output N = 3000, M = 1 is: 
<pre>3000</pre></p><br/>


<p>With a large number of threads this becomes <a href="http://www.mozart-oz.org/documentation/apptut/node9.html#chapter.concurrency.cheap">Death by Concurrency</a>.</p>

<p>(In some languages the same program (with different command-line arguments) might be used for both this process benchmark and the <a href="benchmark.php?test=message&lang=all&sort=<?=$Sort;?>">message benchmark</a>.)</p>