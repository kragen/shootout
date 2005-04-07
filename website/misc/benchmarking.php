<table>
<tr><td><h3 class="rev">&nbsp;Flawed Benchmarks</h3></td></tr>

<tr class="b"><td>Are your programs even like these benchmarks?</td></tr>
<tr><td>
<ul>  
  <li><p>Do your programs startup and finish within a few seconds, like these benchmarks?</p></li>
  <li><p>Are your programs as-tiny-as these benchmarks?</p></li>
  <li><p>Do your programs avoid library re-use like these benchmarks?</p></li>
  <li><p>Is this how you would code the benchmark program?</p></li>
  <li><p>Would you time the program or time a block of code inside the program?</p></li>
</ul> 
</td></tr>


<tr class="b"><td><strong>"benchmarking without analysis is bogus"</strong></td></tr>
<tr><td>
<p>We can learn <em>something</em> about a particular language implementation from benchmarking - if we already know a great deal about the implementation and carefully analyze the results:</p>
<ul>  
  <li><p><a href="http://openmap.bbn.com/~kanderso/performance/postscript/fannkuch.ps">"Performing Lisp Analysis of the FANNKUCH Benchmark"</a> (55KB postscript)</p></li>
  <li><p><a href="http://www-128.ibm.com/developerworks/java/library/j-jtp02225.html?ca=drs-j0805#4.0">Java theory and practice: Anatomy of a flawed microbenchmark. Is there any other kind?</a></p></li>
  <li><p><a href="http://www.dreamsongs.com/NewFiles/Timrep.pdf">Performance and Evaluation of Lisp Systems</a>, Richard P. Gabriel, 1985 (1.1MB pdf)</p></li>
  <li><p><a href="http://www.research.att.com/~orost/bench_plus_plus/paper.html">The Bench++ Benchmark Suite</a></p></li>
  <li><p><a href="http://h21007.www2.hp.com/dspp/tech/tech_TechDocumentDetailPage_IDX/1,1701,2155,00.html">Writing micro-benchmarks for Java™ HotSpot JVM</a></p></li>
</ul>
</td></tr>


<tr class="b"><td><strong>"your application is the ultimate benchmark"</strong></td></tr>
<tr><td>
<blockquote>"In order to find the optimal cost/benefit ratio, Wirth used a highly intuitive metric, 
the origin of which is unknown to me but that may very well be Wirth's own invention. He used <strong>the 
compiler's self-compilation speed</strong> as a measure of the compiler's quality. Considering that Wirth's 
compilers were written in the languages they compiled, and that compilers are substantial and non-trivial 
pieces of software in their own right, this introduced a highly practical benchmark that directly
contested a compiler's complexity against its performance. Under the self compilation speed benchmark,
only those optimizations were allowed to be incorporated into a compiler that accelerated it by so much
that the intrinsic cost of the new code addition was fully compensated." <a href="http://www.ics.uci.edu/~franz/pubs-pdf/BC03.pdf"><br/>Oberon: The Overlooked Jewel</a> page 4. (73KB pdf)</blockquote>
</td></tr>


<tr><td><h3 class="rev">&nbsp;Flawed Comparisons</h3></td></tr>

<tr class="b"><td>Compilers versus Interpreters</td></tr>
<tr><td>
<p>On some benchmarks compiled programs are 10,000 times faster - in practice, 
we'd just call compiled library-code from the interpreted language.</p>
</td></tr>

</table>
