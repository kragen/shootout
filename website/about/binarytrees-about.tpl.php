<p>Each program should</p>
<ul>
   <li>define a tree node class and methods, a tree node record and procedures, or an algebraic data type and functions, or&#8230;</li>
   <li>allocate a binary tree to 'stretch' memory, check it exists, and deallocate it</li>
   <li>allocate a long-lived binary tree which will live-on while other trees are allocated and deallocated</li>   
   <li>allocate, walk, and deallocate many bottom-up binary trees
      <ul>
      <li>allocate a tree</li>
      <li>walk the tree nodes, checksum node items (and maybe deallocate the node)</li>
      <li>deallocate the tree</li>
      </ul>      
   </li>
   <li>check that the long-lived binary tree still exists</li>   
</ul>

<p>(Note: the left subtrees are heads of the right subtrees, keeping a depth counter in the accessors to avoid duplication is cheating!)</p>

<p>There are reference implementations in OCaml, C#, and PHP.</p>
<br />

<p>Correct output N = 10 is:</p>
<pre>stretch tree of depth 11         check: -1
2048     trees of depth 4        check: -2048
512      trees of depth 6        check: -512
128      trees of depth 8        check: -128
32       trees of depth 10       check: -32
long lived tree of depth 10      check: -1
</pre>
<br/>

<p>The binary-trees benchmark is a simplistic adaptation of <a href="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_bench/applet/GCBench.java">Hans Boehm's GCBench</a>,
which in turn was adapted from a benchmark by John Ellis and Pete Kovac.</p>

<p>Thanks to Christophe Troestler and Einar Karttunen for help with this benchmark.</p>