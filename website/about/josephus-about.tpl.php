<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=josephus&lang=java&sort=<?=$Sort;?>">Java program</a>.</p>

<p>Each program simulates the Josephus problem, for&nbsp;M&nbsp;=&nbsp;2&nbsp;to&nbsp;10</p>

<ul>
<li>create a list of sequential integers 1 to N </li>

<li>until list length < M 
<ul>
<li>remove the first M-1 items & add them to the list end</li>
<li>remove the Mth item</li>
</ul>
</li>
<li>print the remaining M-1 list items, tab-separated, in ascending-order</li>
</ul>

<p>Correct output N = 41 is:
<pre>
   19
   16   31
   11   15   37
   12   21   22   34
   13   21   27   34   39
   5    20   22   27   31   36
   6    9    14   21   22   30   41
   1    2    5    11   12   28   30   31
   4    13   15   19   22   23   31   35   36
</pre></p><br/>


<p>The original Josephus problem is explained in Eric W. Weisstein. "Josephus Problem." From <a href="http://mathworld.wolfram.com"><i>MathWorld</i></a>--A Wolfram Web Resource.<br/><a href="http://mathworld.wolfram.com/JosephusProblem.html">http://mathworld.wolfram.com/JosephusProblem.html</a></p>

