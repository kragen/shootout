<h5>The Basic Score</h5>
<p>For each benchmark, the <em>best measurement</em> <strong>B</strong> is the lowest non-zero measurement.</p>
<p>For each language implementation, the measurement <strong>L</strong> for the language implementation is converted to a basic score:</p><pre>basic score = B/L &#215; 100</pre><br/>
<p>The highest possible unweighted score is 100. Missing programs and programs which did not complete the benchmark score 0.</p>

<h5>The Median Score</h5>
<p>Unusually good or bad scores, and missing benchmarks, have a dramatic effect on the mean, so we also show unweighted median scores.</p>
<p>For each language implementation, the median basic scores for CPU time and memory use and lines-of-code (adjusted by a measurement multiplier to make CPU time or memory use or 
lines-of-code more or less important) are summed to give the median score.</p>

<h5>The Mean Score</h5>
<p>The basic score can be adjusted by a benchmark weight (make particular benchmarks more or less important).</p>
<p>For each language implementation, the weighted scores for every benchmark are summed. The CPU time score, memory use score, and lines-of-code score are summed to give a total score.</p>
<p>The total score is divided by the number of non-zero weighted benchmarks to give the mean score.</p>





