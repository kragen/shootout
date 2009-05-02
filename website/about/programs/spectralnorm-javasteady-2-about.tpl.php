<p>The reported "*Java 6 steady state" program CPU secs and program Elapsed secs are <strong>approximate averages</strong>.</p>

<p>Each program performs the same calculation 20 times, the measurements are made in the same way as all the other time measurements, but before display they are divided by 20 to give <strong>approximate averages</strong> that minimize the influence of <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#warmup">mixed-mode method interpretation and on-stack-replacement</a>.</p>

<p><a href="faq.php#dynamic"><strong>FAQ: What about Java dynamic compilation?</strong></a></p>

<pre>
$ java -server -XX:+PrintCompilation -XX:-PrintGC spectralnorm 5500
  1       spectralnorm$Approximate::eval_A (21 bytes)
  2       spectralnorm$Approximate::MultiplyAv (60 bytes)
  1%      spectralnorm$Approximate::MultiplyAv @ 19 (60 bytes)
  2%      spectralnorm$Approximate::MultiplyAtv @ 19 (60 bytes)
  3       spectralnorm$Approximate::MultiplyAtv (60 bytes)
1.274224153
4.066s
1.274224153
3.938s
  4  !    spectralnorm::spectralnormGame (203 bytes)
1.274224153
3.953s
</pre>
