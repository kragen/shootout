<p>Originally the synchronize benchmark was a <a
  href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> test of pre-emptive kernel thread synchronization using a mutex and a condition variable.</p>

<p>Now it includes so many producer-consumer programs implemented with cooperative lightweight threads and other forms of concurrency, it has become a <a
  href="faq.php?sort=<?=$Sort;?>#samething"><b>same&nbsp;thing</b></a> test.</p>

<p>Correct output N = 1000 is:
<pre>
1000 1000
</pre>
</p>
<br/>


<p>The original benchmark specification:
<pre>
 producer thread:
   for i = 1 through n:
     lock mutex to enter critical section
     while count not equal zero wait for condition variable
     put value of i into data buffer
     increment count
     signal condition that resource is ready (data buffer full)
     increment produced

 consumer thread:
   repeat: 
     lock mutex to enter critical section
     while count equal zero wait for condition variable
     retrieve value of i from data buffer
     decrement count
     signal condition that resource is ready (data buffer empty)
     increment consumed

 main thread:
   start producer
   start consumer
   join threads
   print values of produced and consumed
</pre>
</p>


<p><b>Please Note:</b> this test is due for an overhaul.</p>