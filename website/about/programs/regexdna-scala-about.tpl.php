<p>What does -Xrunhprof show?</p>
<pre>SITES BEGIN (ordered by live bytes) Sat Oct 21 11:06:53 2006
          percent          live          alloc'ed  stack class
 rank   self  accum     bytes objs     bytes  objs trace name
    1 43.33% 43.33%  26476024    2 131226240    11 302180 char[]
    2 39.29% 82.61%  24006928    2 166524304    41 302013 char[]
    3 16.36% 98.98%  10000016    1  10000016     1 302042 char[]

CPU SAMPLES BEGIN (total = 6691) Sat Oct 21 11:06:53 2006
rank   self  accum   count trace method
   1 18.74% 18.74%    1254 302018 java.lang.Object.&lt;init&gt;
   2 15.27% 34.02%    1022 302164 java.lang.Object.&lt;init&gt;
   3 14.32% 48.33%     958 302159 java.lang.String.&lt;init&gt;
   4 14.26% 62.59%     954 302165 java.lang.Object.&lt;init&gt;
   5 13.68% 76.27%     915 302156 java.lang.AbstractStringBuilder.&lt;init&gt;
   6  3.92% 80.18%     262 302012 java.lang.String.&lt;init&gt;
   7  3.86% 84.04%     258 302017 java.lang.Object.&lt;init&gt;
   8  3.72% 87.76%     249 302016 java.lang.Object.&lt;init&gt;
   9  3.38% 91.14%     226 302009 java.lang.AbstractStringBuilder.&lt;init&gt;
  10  1.55% 92.69%     104 302074 java.util.regex.Pattern$Branch.match
</pre>
