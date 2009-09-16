<p>The reported "*Java 6 steady state" program CPU secs and program Elapsed secs are <strong>averages</strong> that approximate steady state performance.</p>

<p>Each program performs the same calculation 20 times, the measurements are made in the same way as all the other time measurements, but before display they are divided by 20 to give averages that minimize the influence of mixed-mode method interpretation and <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr"><strong>on-stack-replacement</strong></a>.</p>

<p><a href="faq.php#dynamic"><strong>FAQ: What about Java dynamic compilation?</strong></a></p>

<pre>
$ java -server -XX:+PrintCompilation -XX:-PrintGC spectralnorm_test 5500 10
  1       spectralnorm_test$Approximate::eval_A (21 bytes)
  1%      spectralnorm_test$Approximate::MultiplyAv @ 19 (60 bytes)
  2%      spectralnorm_test$Approximate::MultiplyAtv @ 19 (60 bytes)
  2       spectralnorm_test$Approximate::MultiplyAv (60 bytes)
  3       spectralnorm_test$Approximate::MultiplyAtv (60 bytes)
1.274224153
4.103
1.274224153
3.955
  4  !    spectralnorm_test::spectralnormGame (203 bytes)
1.274224153
3.991
1.274224153
3.973
  5       spectralnorm_test$Approximate::run (110 bytes)
1.274224153
4.005
1.274224153
3.994
1.274224153
3.965
---   n   java.lang.Thread::currentThread (static)
1.274224153
3.969
1.274224153
3.969
1.274224153
3.969
</pre>
