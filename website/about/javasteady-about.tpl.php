<?=$Version;?>

<p>The reported "Java 6 steady state" program CPU secs and program Elapsed secs are <strong>averages</strong> that approximate steady state performance - see <a href="help.php#dynamic"><strong>Help: What about Java?</strong></a></p>

<p>Each program performs the same calculation 66 times, for example -</p>

<pre>
   <span class="hl kwa">public static</span> <span class="hl kwb">void</span> <span class="hl kwd">main</span><span class="hl sym">(</span><span class="hl kwc">String</span><span class="hl sym">[]</span> args<span class="hl sym">){</span>
      <span class="hl kwa">for</span> <span class="hl sym">(</span><span class="hl kwb">int</span> i<span class="hl sym">=</span><span class="hl num">0</span><span class="hl sym">;</span> i<span class="hl sym">&lt;</span><span class="hl num">65</span><span class="hl sym">; ++</span>i<span class="hl sym">)</span> binarytrees<span class="hl sym">.</span><span class="hl kwd">program_main</span><span class="hl sym">(</span>args<span class="hl sym">,</span>false<span class="hl sym">);</span>
      binarytrees<span class="hl sym">.</span><span class="hl kwd">program_main</span><span class="hl sym">(</span>args<span class="hl sym">,</span>true<span class="hl sym">);</span>
   <span class="hl sym">}</span>
</pre>

<p>The "Java 6 steady state" program CPU secs and program Elapsed secs measurements are made in the same way as all the other time measurements, but before display they are divided by 66 to give <strong>approximate averages</strong> that minimize the influence of mixed-mode method interpretation and <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr"><strong>on-stack-replacement</strong></a>, for example -</p>

<pre>
$ java -server -XX:+PrintCompilation -XX:-PrintGC binarytrees_test 20 10
  1       java.lang.Object::<init> (1 bytes)
  2       binarytrees_test$TreeNode::bottomUpTree (42 bytes)
  3       binarytrees_test$TreeNode::<init> (10 bytes)
  4       binarytrees_test$TreeNode::<init> (20 bytes)
  5       binarytrees_test$TreeNode::itemCheck (33 bytes)
stretch tree of depth 21	 check: -1
  6       binarytrees_test$TreeNode::access$000 (6 bytes)
  7       binarytrees_test$TreeNode::access$100 (5 bytes)
  1%      binarytrees_test::program_main @ 108 (240 bytes)
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
21.318
  8       binarytrees_test::program_main (240 bytes)
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
15.977
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
16.393
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
16.030
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
15.889
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
15.512
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
15.567
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
15.107
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
16.046
stretch tree of depth 21	 check: -1
2097152	 trees of depth 4	 check: -2097152
524288	 trees of depth 6	 check: -524288
131072	 trees of depth 8	 check: -131072
32768	 trees of depth 10	 check: -32768
8192	 trees of depth 12	 check: -8192
2048	 trees of depth 14	 check: -2048
512	 trees of depth 16	 check: -512
128	 trees of depth 18	 check: -128
32	 trees of depth 20	 check: -32
long lived tree of depth 20	 check: -1
15.169
</pre>
