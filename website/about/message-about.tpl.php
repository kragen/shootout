<p>Each program should do the <a href="faq.php?sort=<?=$Sort;?>#samething"><b>same&nbsp;thing</b></a>.
</p>


<ul>
<li>take 2 command line args L N </li>
<li>create a chain of L processes/threads such that:

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
<li>can store the sum of received messages</li>
<li>there is no next process/thread</li>
</ul>
</li>
</ul>

<li>N times: send the integer message 0 to the first process/thread</li>
<li>print the sum of messages received by the last process/thread</li>
<li>exit</li>

</ul>
