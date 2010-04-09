<p>"we have found that the <b>CPU time is rarely the limiting factor</b>; the expressibility of the language
means that most programs are small and spend most of their time in I/O and native run-time code."
</p>

<dl>
<dt><a href="#flawed" name="flawed">&nbsp;<strong>Flawed Benchmarks or Broken Thinking?</strong></a></dt>
<dd>
<dl>

<dt><a href="#broken" name="broken">What are Flawed Benchmarks?</a></dt>
<dd>
<ul>
<li><p>When the measurement techniques don't record the data as claimed, that's broken not flawed - fix it.</p></li>
<li><p>When measured programs are supposed to implement the same algorithm and don't because Wile E. Programmer pushed the boundaries, that's broken not flawed - fix it.</p></li>
<li><p>When measured programs don't strictly implement the same algorithm because they are written in different programming languages which use very different implementation techniques - that's flawed.</p></li>
</ul>
</dd>


<dt><a href="#thinking" name="thinking">What's Broken Thinking?</a></dt>
<dd>
<ul>
<li><p>Generalizing from particular measurements without understanding what limits performance in other situations.</p>
<p>Page load times for this site are limited by - what the other 880 hosted projects are doing with the server, page load time could still average 1.3s even if page generation was instantaneous.</p>
</li>
<li><p>Generalizing from particular measurements without showing the measured programs are somehow representative of other situations.</p>
<p>"The performance of a benchmark, even if it is derived from a real program, <a href="http://www.ccs.neu.edu/home/will/Twobit/bmcrock.temp.html" title="Benchmarks are a crock"><b>may not help</b></a> to predict the performance of similar programs that have different hot spots."</p>
</li>
</ul>
</dd>

<dt><a href="#app" name="app">Your application is <strong>the ultimate benchmark</strong></a></dt>
<dd>
<blockquote><p>"In order to find the optimal cost/benefit ratio, Wirth used a highly intuitive metric,
the origin of which is unknown to me but that may very well be Wirth's own invention. He used <b>the
compiler's self-compilation speed</b> as a measure of the compiler's quality. Considering that Wirth's 
compilers were written in the languages they compiled, and that compilers are substantial and non-trivial
pieces of software in their own right, this introduced a highly practical benchmark that directly
contested a compiler's complexity against its performance. Under the self compilation speed benchmark,
only those optimizations were allowed to be incorporated into a compiler that accelerated it by so much
that the intrinsic cost of the new code addition was fully compensated." <br/><a href="http://www.ics.uci.edu/~franz/Site/pubs-pdf/BC03.pdf">Oberon: The Overlooked Jewel</a> (pdf) Michael Franz, in L. Boszormenyi, J. Gutknecht, G. Pomberger "The School of Niklaus Wirth" 2000.
</p></blockquote>
<blockquote><p>"Overall Performance<b>: PHP is rarely the bottleneck</b>" <br/><a href="http://talks.php.net/show/drupal08/7">Simple is Hard, DrupalCon 2008</a> (HTML slides) Rasmus Lerdorf</p></blockquote>
<blockquote><p>"We measure three specific areas of JavaScript runtime behavior: 1) functions and code; 2) heap-allocated objects and data; 3) events and handlers. We find that the benchmarks are <b>not representative</b> of many real websites and that conclusions reached from measuring the benchmarks may be misleading." <br/><a href="http://research.microsoft.com/en-us/projects/jsmeter/">JSMeter: Characterizing Real-World Behavior of JavaScript Programs</a></p></blockquote>
</dd>

</dl>
</dd>



<dt><a href="#comparison" name="comparison">&nbsp;<strong>Flawed Comparisons</strong></a></dt>
<dd>
<dl>
<dd><p>Programming language implementations are compared against each other as though
 the designers intended them to be used for the exact same purpose - that just isn't so.
</p></dd>

<dt><a href="#scope" name="scope">Different design intentions - <b>scope</b></a></dt>
<dd><blockquote><p>"Lua is a tiny and simple language, partly because it does not try to do what C is already 
good for, such as sheer performance, low-level operations, or interface with third-party 
software. Lua relies on C for those tasks."<br />
<a href="http://www.inf.puc-rio.br/~roberto/book/">Programming in Lua</a>, preface
</p></blockquote>

<blockquote><p>"Most (all?) large systems developed using Erlang make heavy use of C for low-level code, leaving Erlang to manage the parts which tend to be complex in other languages, like controlling systems spread across several machines and implementing complex protocol logic."<br />
<a href="http://www.erlang.org/faq/introduction.html#1.4">Frequently Asked Questions about Erlang</a>
</p></blockquote>
</dd>

<dt><a href="#scale" name="scale">Different design intentions - <b>scale</b></a></dt>
<dd><blockquote><p>"Lua is not intended for building huge programs, where many programmers are involved
for long periods. Quite the opposite, Lua aims at small to medium programs, usually part
 of a larger system, typically developed by one or a few programmers, or even by non 
 programmers. Therefore, Lua avoids too much redundancy and artificial restrictions."<br />
 <a href="http://www.inf.puc-rio.br/~roberto/book/">Programming in Lua</a>, page 142
</p></blockquote>

<blockquote><p>"Ada was originally designed with three overriding concerns: program reliability and maintenance,
programming as a human activity, and efficiency &#8230; emphasis was placed on program readability over ease of writing &#8230; Like many other human activities, the development of programs is becoming ever more decentralized and
distributed. Consequently, the ability to assemble a program from independently produced software
components continues to be a central idea in the design."<br />
 <a href="http://www.adapower.com/rm95/RM-0-3.html">Ada Reference Manual</a>, Introduction, Design Goals
</p></blockquote>

</dd>

<dt><a href="#domain" name="domain">Different design intentions - <b>domain</b></a></dt>
<dd>
<blockquote><p>'Our system [Erlang] was originally designed for building telecoms switching systems.
Telecoms switching systems have demanding requirements in terms
of reliability, fault-tolerance etc. Telecoms systems are expected to operate
"forever", they should exhibit soft real-time behaviour, and they should behave
reasonably in the presence of software and hardware errors.' 
<br /><a href="http://www.sics.se/~joe/thesis/armstrong_thesis_2003.pdf">Making reliable distributed systems in the presence of software errors</a>, page 13. (840KB pdf)
</p></blockquote>

<blockquote><p>"In return for learning a new language, the user is rewarded by the
ability to write short, clear programs that are guaranteed to work well on thousands of machines
in parallel. Ironically - but vitally - the user need know nothing about parallel programming; the
language and the underlying system take care of all the details.<br/><br/>
It may seem paradoxical to use an interpreted language in a high-throughput environment, but
we have found that the CPU time is rarely the limiting factor; the expressibility of the language
means that most programs are small and spend most of their time in I/O and native run-time code." 
<br /><a href="http://labs.google.com/papers/sawzall.html">Interpreting the Data: Parallel Analysis with Sawzall</a>, page 27.
</p></blockquote>
</dd>
</dl>
</dd>
</dl>
