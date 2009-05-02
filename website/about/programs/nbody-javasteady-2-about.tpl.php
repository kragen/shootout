<p>The reported "*Java 6 steady state" program CPU secs and program Elapsed secs are <strong>approximate averages</strong>.</p>

<p>Each program performs the same calculation 20 times, the measurements are made in the same way as all the other time measurements, but before display they are divided by 20 to give <strong>approximate averages</strong> that minimize the influence of mixed-mode method interpretation and <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr">on-stack-replacement</a>.</p>

<p><a href="faq.php#dynamic"><strong>FAQ: What about Java dynamic compilation?</strong></a></p>

<pre>
$ java -server -XX:+PrintCompilation -XX:-PrintGC nbody 50000000
-0.169075164
  1       NBodySystem::advance (374 bytes)
  1%      nbody::program_main @ 49 (102 bytes)
-0.169059907
23.728s
  2       nbody::program_main (102 bytes)
-0.169075164
-0.169059907
23.668s
-0.169075164
-0.169059907
23.705s
</pre>
