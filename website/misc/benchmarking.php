<table>

<tr><td><h3 class="rev"><a class="arev" href="#conclusions" name="conclusions">&nbsp;Beware Flawed Conclusions</a></h3></td></tr>
<tr><td>
<p>The performance of your whole application matters; the performance of highly tuned benchmark code doesn't matter.</p>
<p>Quality of profiling tools, ease of programming, and the amount of time you have available for tuning, can be far more important for application performance than the language implementation.</p>
<p>Highly tuned benchmark code provides a very limited indication of likely application performance.</p>
</td></tr>

<tr><td><h3 class="rev"><a class="arev" href="#flawed" name="flawed">&nbsp;Flawed Benchmarks</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#your" name="your">Are <strong>your programs</strong> even like these benchmarks?</a></td></tr>
<tr><td>
<ul>  
  <li><p>Do your programs startup and finish within a few seconds, like these benchmarks?</p></li>
  <li><p>Are your programs tiny, like these benchmarks?</p></li>
  <li><p>Do your programs avoid library re-use, like these benchmarks?</p></li>
</ul> 
</td></tr>


<tr class="b"><td><a class="ab" href="#bogus" name="bogus"><strong>"benchmarking without analysis is bogus"</strong></a></td></tr>
<tr><td>
<p>We can learn <em>something</em> about a particular language implementation from benchmarking - if we already know a great deal about the implementation and carefully analyze the results:</p>
<ul>  
  <li><p><a href="http://openmap.bbn.com/~kanderso/performance/postscript/fannkuch.ps">"Performing Lisp Analysis of the FANNKUCH Benchmark"</a> (55KB postscript)</p></li>
  <li><p><a href="http://www-128.ibm.com/developerworks/java/library/j-jtp02225.html?ca=drs-j0805#4.0">Java theory and practice: Anatomy of a flawed microbenchmark. Is there any other kind?</a></p></li>
  <li><p><a href="http://www.dreamsongs.com/NewFiles/Timrep.pdf">Performance and Evaluation of Lisp Systems</a>, Richard P. Gabriel, 1985 (1.1MB pdf)</p></li>
  <li><p><a href="http://h21007.www2.hp.com/dspp/tech/tech_TechDocumentDetailPage_IDX/1,1701,2155,00.html">Writing micro-benchmarks for Java&#x2122; HotSpot JVM</a></p></li>
</ul>
<p>Many benchmark suites are designed to help language implementors optimize compiler designs:</p>
<ul>  
  <li><p><a href="http://www.research.att.com/~orost/bench_plus_plus/paper.html">The Bench++ Benchmark Suite</a></p></li>
  <li><p><a href="http://ali-www.cs.umass.edu/DaCapo/gcbm.html">The DaCapo Benchmark Suite</a></p></li>
</ul>
</td></tr>


<tr class="b"><td><a class="ab" href="#app" name="app"><strong>"your application is the ultimate benchmark"</strong></a></td></tr>
<tr><td>
<blockquote><p>"In order to find the optimal cost/benefit ratio, Wirth used a highly intuitive metric, 
the origin of which is unknown to me but that may very well be Wirth's own invention. He used <strong>the 
compiler's self-compilation speed</strong> as a measure of the compiler's quality. Considering that Wirth's 
compilers were written in the languages they compiled, and that compilers are substantial and non-trivial 
pieces of software in their own right, this introduced a highly practical benchmark that directly
contested a compiler's complexity against its performance. Under the self compilation speed benchmark,
only those optimizations were allowed to be incorporated into a compiler that accelerated it by so much
that the intrinsic cost of the new code addition was fully compensated." <a href="http://www.ics.uci.edu/~franz/pubs-pdf/BC03.pdf"><br/>Oberon: The Overlooked Jewel</a> page 4. (73KB pdf)
</p></blockquote>
</td></tr>


<tr><td><h3 class="rev"><a class="arev" href="#comparison" name="comparison">&nbsp;Flawed Comparisons</a></h3></td></tr>
<tr><td><p>Programming language implementations are compared against each other as though
 the designers intended them to be used for the exact same purpose - that just isn't so.
</p></td></tr>

<tr class="b"><td><a class="ab" href="#scope" name="scope"><strong>Different design intentions - scope</strong></a></td></tr>
<tr><td>
<blockquote><p>"Lua is a tiny and simple language, partly because it does not try to do what C is already 
good for, such as sheer performance, low-level operations, or interface with third-party 
software. Lua relies on C for those tasks."<br />
<a href="http://www.inf.puc-rio.br/~roberto/book/">Programming in Lua</a>, preface
</p></blockquote>

<blockquote><p>" Most (all?) large systems developed using Erlang make heavy use of C for low-level code, leaving Erlang to manage the parts which tend to be complex in other languages, like controlling systems spread across several machines and implementing complex protocol logic."<br />
<a href="http://www.erlang.org/faq/t1.html#AEN43">Frequently Asked Questions about Erlang</a>
</p></blockquote>
</td></tr>

<tr class="b"><td><a class="ab" href="#scale" name="scale"><strong>Different design intentions - scale</strong></a></td></tr>
<tr><td>
<blockquote><p>"Lua is not intended for building huge programs, where many programmers are involved 
for long periods. Quite the opposite, Lua aims at small to medium programs, usually part
 of a larger system, typically developed by one or a few programmers, or even by non 
 programmers. Therefore, Lua avoids too much redundancy and artificial restrictions."<br />
 <a href="http://www.inf.puc-rio.br/~roberto/book/">Programming in Lua</a>, page 142
</p></blockquote>

<blockquote><p>"Ada was originally designed with three overriding concerns: program reliability and maintenance,
programming as a human activity, and efficiency &#8230; emphasis was placed on program readability over ease of writing &#8230; Like many other human activities, 
the development of programs is becoming ever more decentralized and
distributed. Consequently, the ability to assemble a program from independently produced software
components continues to be a central idea in the design."<br />
 <a href="http://www.adapower.com/rm95/RM-0-3.html">Ada Reference Manual</a>, Introduction, Design Goals
</p></blockquote>
</td></tr>

<tr class="b"><td><a class="ab" href="#domain" name="domain"><strong>Different design intentions - domain</strong></a></td></tr>
<tr><td>
<blockquote><p>'Our system [Erlang] was originally designed for building telecoms switching systems.
Telecoms switching systems have demanding requirements in terms
of reliability, fault-tolerance etc. Telecoms systems are expected to operate
“forever,” they should exhibit soft real-time behaviour, and they should behave
reasonably in the presence of software and hardware errors.' 
<br /><a href="http://www.sics.se/~joe/thesis/armstrong_thesis_2003.pdf">Making reliable distributed systems in the presence of software errors</a>, page 13. (840KB pdf)
</p></blockquote>
</td></tr>


</table>
