<p><strong>Note</strong>: we're thinking about a better way to start client & server within our measurement framework.</p>

<p>Each program (M = 6400, REPLY_SIZE = 64) should
<ul>
<li>open a TCP/IP socket</li>
<li>fork a client process that connects back to the socket
<ul>
<li>M*N times the client process should
<ul>
<li>write a request to the socket</li>
<li>read a reply from the socket</li>
<li>count the replies, and sum the bytes in the replies</li>
</ul>
<li>close the socket</li>
<li>print the count and sum</li>
</li>
</ul>
</li><li>the server process should
<ul>
<li>read a request from the socket</li>
<li>write a reply to the socket</li>
</ul>
</li>
</ul>
</p><p>Correct output N = 10 is:
<pre>
replies: 64000  bytes: 4096000
</pre>
</p>
<br/>

<p>The only difference between the tcp-echo, tcp-request-reply, and tcp-stream programs, should be the values for M and REPLY_SIZE.</p>
