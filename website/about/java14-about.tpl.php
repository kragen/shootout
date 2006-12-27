<?=$Version;?>
<p>Home Page: <a href="http://www.sun.com/">http://www.sun.com/</a></p>
<p>Download: <a href="http://www.sun.com/">http://www.sun.com/</a></p>
<blockquote>"Remember how HotSpot works. It starts by running your program with an interpreter. When it discovers that some method is "hot" -- that is, executed a lot, either because it is called a lot or because it contains loops that loop a lot -- it sends that method off to be compiled. After that one of two things will happen, either the next time the method is called the compiled version will be invoked (instead of the interpreted version) or the currently long running loop will be replaced, while still running, with the compiled method. The latter is known as "on stack replacement" and exists in the 1.3/1.4 HotSpot based systems."</blockquote>
<p><a href="http://java.sun.com/docs/hotspot/PerformanceFAQ.html#B1">Benchmarking the Java HotSpot VM</a></p>

<blockquote>"Hundreds of separate classes need to be loaded by the JVM before it can start executing even the simplest application code. This startup cost generally makes the Java platform better suited to long-running, server-type applications than for frequently used small programs." <br /><a href="http://www-128.ibm.com/developerworks/java/library/j-dyn0429/">Classes and class loading</a></blockquote>
