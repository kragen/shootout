<p>"we have found that the <b>CPU time is rarely the limiting factor</b>; the expressibility of the language
means that most programs are small and spend most of their time in I/O and native run-time code."
</p>

<dl>
<dt><a href="#flawed" name="flawed">&nbsp;<strong>Flawed Benchmarks</strong></a></dt>
<dd>
<dl>
<dt><a href="#your" name="your">Are <strong>your programs</strong> even like these benchmarks?</a></dt>
<dd><ul>  
  <li><p>Do your programs startup and finish within a few seconds, like these benchmarks?</p></li>
  <li><p>Are your programs tiny, like these benchmarks?</p></li>
  <li><p>Do your programs avoid library use, like these benchmarks?</p></li>
</ul></dd>

<dt><a href="#bogus" name="bogus"><strong>"benchmarking without analysis is bogus"</strong></a></dt>
<dd>
<p>"The performance of a benchmark, even if it is derived from a real program, may not help to predict the performance of similar programs that have different hot spots."</p>
<ul>  
  <li><p><a href="http://www.ccs.neu.edu/home/will/Twobit/bmcrock.temp.html">Benchmarks are a crock</a></p></li>
</ul>

<p>"Generally, we can get accurate measurements for durations that are either very short (less than around 10 millisecond) or very long (greater than around 1 second), even on heavily loaded machines. Times between around 10 milliseconds and 1 second require special care to measure accurately."</p>
<ul>  
  <li><p><a href="http://csapp.cs.cmu.edu/public/ch9-preview.pdf">Computer Systems: A Programmer's Perspective, Chapter 9</a> (pdf)</p></li>

  <li><p><a href="http://www.lst.inf.ethz.ch/teaching/lectures/ws06/51/slides/class19.pdf">Measuring Program Performance</a> (pdf slides)</p></li>
</ul>


<p>"Most likely, if the performance differences between the alternatives are large, a statistically rigorous method will not alter the overall picture nor affect the general conclusions obtained using prevalent methods. However, for relatively small performance differences (that are within the margin of experimental error) not using statistical rigor may lead to incorrect conclusions." </p>
<ul>  
  <li><p><a href="http://itkovian.net/base/files/papers/oopsla2007-georges-presentation.pdf">Statistically Rigorous Java Performance Evaluation</a> (pdf slides)</p></li>
  <li><p><a href="http://buytaert.net/files/oopsla07-georges.pdf">Statistically Rigorous Java Performance Evaluation</a> (pdf paper)</p></li>
</ul>

<p>We can learn <em>something</em> about a particular language implementation from benchmarking - if we already know a great deal about the implementation and carefully analyze the results:</p>
<ul>  
  <li><p><a href="http://openmap.bbn.com/~kanderso/performance/postscript/fannkuch.ps">Performing Lisp Analysis of the FANNKUCH Benchmark</a> (55KB postscript)</p></li>
  <li><p><a href="http://www-128.ibm.com/developerworks/java/library/j-jtp02225.html?ca=drs-j0805#4.0">Java theory and practice: Anatomy of a flawed microbenchmark. Is there any other kind?</a></p></li>
</ul>
<p>Many benchmark suites are designed to help language implementors optimize compiler designs:</p>
<ul>  
  <li><p><a href="http://www.cse.unsw.edu.au/~dons/nobench.html">nobench performance comparisons between different Haskell systems</a></p></li>
  <li><p><a href="http://nenya.ms.mff.cuni.cz/projects/mono/index.phtml#fft_scimark">Performance regressions in daily development versions of Mono</a></p></li>
  <li><p><a href="http://sbcl-test.boinkor.net/bench/">Version-to-version Steel Bank Common Lisp performance</a></p></li>
</ul>
<p>We should always question how useful a benchmark is for our specific purpose:</p>
<ul>  
  <li><p><a href="http://www-faculty.cs.uiuc.edu/~zilles/papers/health.pdf">Benchmark <tt>Health</tt> Considered Harmful</a> (pdf)</p></li>
</ul>
<p>There's more to programming language comparison than CPU time, memory use, and program length - but other aspects are less easy to measure, and so are less often measured.</p>
<ul>
  <li><p><a href="http://www.cis.udel.edu/~silber/470STUFF/article.pdf">An Empirical Comparison of Seven Programming Languages</a> (pdf)</p>
<p>Note: After reading the "Comparison Validity" section at the foot of pages 24-25, you might decide that it doesn't seem reasonable to compare <i>independently measured programming time</i> for one group of languages against <i>programming time reported by program authors</i> for another group of languages, <i>etc etc</i></p>
</li>
</ul>
</dd>

<dt><a href="#app" name="app"><b>"your application is the <strong>ultimate benchmark</strong>"</b></a></dt>
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
<blockquote><p>"<strong>Overall Performance</strong><b>: PHP is rarely the bottleneck</b>" <br/><a href="http://talks.php.net/show/drupal08/7">Simple is Hard, DrupalCon 2008</a> (HTML slides) Rasmus Lerdorf</p></blockquote>
</dd>

</dl>
</dd>



<dt><a href="#comparison" name="comparison">&nbsp;<strong>Flawed Comparisons</strong></a></dt>
<dd>
<dl>
<dd><p>Programming language implementations are compared against each other as though
 the designers intended them to be used for the exact same purpose - that just isn't so.
</p></dd>

<dt><a href="#scope" name="scope"><b>Different design intentions - scope</b></a></dt>
<dd><blockquote><p>"Lua is a tiny and simple language, partly because it does not try to do what C is already 
good for, such as sheer performance, low-level operations, or interface with third-party 
software. Lua relies on C for those tasks."<br />
<a href="http://www.inf.puc-rio.br/~roberto/book/">Programming in Lua</a>, preface
</p></blockquote>

<blockquote><p>"Most (all?) large systems developed using Erlang make heavy use of C for low-level code, leaving Erlang to manage the parts which tend to be complex in other languages, like controlling systems spread across several machines and implementing complex protocol logic."<br />
<a href="http://www.erlang.org/faq/t1.html#AEN43">Frequently Asked Questions about Erlang</a>
</p></blockquote>
</dd>

<dt><a href="#scale" name="scale"><b>Different design intentions - scale</b></a></dt>
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

<dt><a href="#domain" name="domain"><b>Different design intentions - domain</b></a></dt>
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
