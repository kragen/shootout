<p>The reported "Java 6 steady state" program CPU secs and program Elapsed secs are <strong>averages</strong> that approximate steady state performance.</p>

<p>Each program performs the same calculation 66 times, the measurements are made in the same way as all the other time measurements, but before display they are divided by 66 to give averages that minimize the influence of mixed-mode method interpretation and <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr"><strong>on-stack-replacement</strong></a>.</p>

<p><a href="faq.php#dynamic"><strong>FAQ: What about Java?</strong></a></p>

<pre>
$ java -server -XX:+PrintCompilation -XX:-PrintGC nbody_test 50000000 10
-0.169075164
  1       NBodySystem::advance (374 bytes)
  1%      nbody_test::dotest @ 40 (82 bytes)
-0.169059907
25.030
  2       nbody_test::dotest (82 bytes)
-0.169075164
-0.169059907
29.790
-0.169075164
-0.169059907
24.906
-0.169075164
-0.169059907
24.812
-0.169075164
-0.169059907
24.802
-0.169075164
-0.169059907
24.836
-0.169075164
-0.169059907
24.817
-0.169075164
-0.169059907
24.817
-0.169075164
-0.169059907
24.839
-0.169075164
-0.169059907
24.818
</pre>
