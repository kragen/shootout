<p>Each program should</p>
<ul>
   <li>define a tree node class and methods, or a tree node record and functions</li>
   <li>allocate a binary tree to 'stretch' memory, check it exists, and deallocate it</li>
   <li>allocate a long-lived binary tree which will live-on while other trees are allocated and deallocated</li>   
   <li>allocate, walk, and deallocate many top-down and bottom-up binary trees
      <ul>
      <li>allocate a tree</li>
      <li>walk the tree nodes, sum and cancel node items (and maybe deallocate the node)</li>
      <li>deallocate the tree</li>
      </ul>      
   </li>
   <li>check that the long-lived binary tree still exists</li>   
</ul>
<br />

<p>There are reference implementations in Oberon-2, C#, and PHP.</p>
<p>Correct output N = 10 is:</p>
<pre>2048     trees of depth 4        check: 15392
512      trees of depth 6        check: 776
128      trees of depth 8        check: 2
32       trees of depth 10       check: 0
OK
</pre>
<br/>

<p>The binary-trees benchmark is adapted from <a href="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_bench/applet/GCBench.java">Hans Boehm's GCBench</a>,
which in turn was adapted from a benchmark by John Ellis and Pete Kovac.</p>
