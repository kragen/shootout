<p>The reported "Java 6 steady state" program CPU secs and program Elapsed secs are <strong>averages</strong> that approximate steady state performance.</p>

<p>Each program performs the same calculation 66 times, the measurements are made in the same way as all the other time measurements, but before display they are divided by 66 to give averages that minimize the influence of mixed-mode method interpretation and <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr"><strong>on-stack-replacement</strong></a>.</p>

<p><a href="<?=CORE_SITE;?>help.php#java"><strong>FAQ: What about Java?</strong></a></p>

<pre>
$ /usr/local/src/jdk1.6.0_18/bin/java -server -XX:+PrintCompilation -XX:-PrintGC fannkuchredux 12
  1%      fannkuchredux::fannkuch @ 68 (276 bytes)
  1       java.lang.Math::max (11 bytes)
  1%  made not entrant  (2)  fannkuchredux::fannkuch @ 68 (276 bytes)
3968050
Pfannkuchen(12) = 65
88.443213617
  2       fannkuchredux::fannkuch (276 bytes)
  2%      fannkuchredux::fannkuch @ 91 (276 bytes)
  3%      fannkuchredux::fannkuch @ 111 (276 bytes)
3968050
Pfannkuchen(12) = 65
91.85444456
3968050
Pfannkuchen(12) = 65
90.611090816
3968050
Pfannkuchen(12) = 65
90.736423516
3968050
Pfannkuchen(12) = 65
90.870581883
3968050
Pfannkuchen(12) = 65
90.861219422
3968050
Pfannkuchen(12) = 65
90.611711336
3968050
Pfannkuchen(12) = 65
90.736936381
3968050
Pfannkuchen(12) = 65
91.041401088
3968050
Pfannkuchen(12) = 65
90.862677571
</pre>
