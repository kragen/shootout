<p>Each program should be implemented the <a
  href="faq.php?sort=<?=$Sort;?>#sameway"><b>same&nbsp;way</b></a> - the same way as this <a href="benchmark.php?test=objinst&lang=java&sort=<?=$Sort;?>">Java program</a>.</p>
<p>The objects benchmark measures the speed of object creation in OO languages. It measures a mixture of base class and a derived class object creation.</p>
<p>Each program should:</p>
<ul>
<li>create a <i>Toggle</i> object</li>
<li>activate the object 5 times and print the object's boolean state each time</li>
<li>create N <i>Toggle</i> objects</li>
<li>create an <i>NthToggle</i> object</li>
<li>activate the object 8 times and print the object's boolean state each time</li>
<li>create N <i>NthToggle</i> objects</li>
</ul>
<p>Correct output is:
<pre>
false
true
false
true
false
true
true
false
false
false
true
true
true
</pre>
</p>
<br/>
<p>The base class <i>Toggle</i> toggles it's boolean state each time it is activated. The derived class <i>NthToggle</i> toggles it's boolean state the Nth time it is activated.</p>
<p>The derived <i>NthToggle</i> class should:</p>
<ul>
<li>inherit the boolean state from <i>Toggle</i></li>
<li>override the <i>Toggle</i> activate method, to toggle on the Nth activation</li>
<li>use the <i>Toggle</i> constructor</li>
<li>inherit the <i>Toggle</i> value method</li>
</ul>
<p>(These classes are also used in the <a href="benchmark.php?test=methcall&lang=all&sort=<?=$Sort;?>">methods benchmark</a>.)</p>
<p>This benchmark needs to be re-designed a little to avoid the creation of invariant objects.</p>