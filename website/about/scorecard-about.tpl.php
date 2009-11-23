<p><br/>Read <a href="http://portal.acm.org/citation.cfm?id=5666.5673"><strong>"How not to lie with statistics: the correct way to summarize benchmark results" (pdf)</strong></a>.</p>

<p>For each benchmark, <strong>B</strong> is the best measurement; for each language implementation, the best measurement <strong>L</strong> is then normalized to <strong><sup>L</sup>/<sub>B</sub></strong></p>

<p><strong>GM</strong> is the Weighted Geometric Mean of those <strong><sup>L</sup>/<sub>B</sub></strong> ratios.

<p><strong>missing</strong> : Language implementations with more than a couple of Timeouts (at the largest workload) distort the ranking - so they have been excluded. They can still be <a href="benchmark.php?test=all&amp;lang=gpp&amp;lang2=java"><strong>compared directly</strong></a> against another language implementation.</p>

<p><br/>There are other ways to analyse and present this data: ask <a href="fastest.php?d=<?=$DataSet?>">Which programming languages have the fastest programs?</a> or look for patterns in <a href="shapes.php?d=<?=$DataSet?>">Code-used Time-used Shapes</a> or take the <a href="summarydata.php?d=<?=$DataSet?>">Summary Data</a> and do your own analysis!</p>







