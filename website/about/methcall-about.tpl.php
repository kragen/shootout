<p>Each program should be implemented the <a href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=methcall&lang=java&sort=<?=$Sort;?>">Java program</a>.</p>

<p>The methods benchmark measures the speed of method calls in OO languages.  It measures a mixture of base class and derived class method calls.</p>

<p>Each program should:</p>
<ul>
<li>create a <i>Toggle</i> object</li>
<li>call the object's activate method N times</li>
<li>print the object's boolean state</li>
<li>create an <i>NthToggle</i> object</li>
<li>call the object's activate method N times</li>
<li>print the object's boolean state</li>
</ul>

<p>Correct output is:
<pre>
true
false
</pre>
</p>
<br/>


<p>The base class <i>Toggle</i> toggles it's boolean state each time it is activated. The derived class <i>NthToggle</i> toggles it's boolean state the Nth time it is activated.</p>
<p>The derived <i>NthToggle</i> class should:</p>
<ul>
<li>inherit the boolean state from <i>Toggle</i></li>
<li>override the <i>Toggle</i> activate method, to toggle on the Nth activation</li>
<li>re-use the <i>Toggle</i> constructor</li>
<li>inherit the <i>Toggle</i> value method</li>
</ul>


<p>(These classes are also used in the <a href="benchmark.php?test=objinst&lang=all&sort=<?=$Sort;?>">objects benchmark</a>.)</p>