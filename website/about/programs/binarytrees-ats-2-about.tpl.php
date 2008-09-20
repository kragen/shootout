<p>"In this example, a linear datatype (dataviewtype) is declared
for representing binary trees. This allows a binary tree to be
freed immediately after its use. So in this case, the GC of ATS
essentially serves as a recycling center for memory: The GC is
not running. Instead, the program itself fetches the needed memory
from the GC and then returns it back. This is a compelling example
for showing <strong>the power of linear types</strong>.</p>

<p>The concurrency part in this example is standard: for each depth
(below the maximum depth), a thread is created to compute the
value of the check function, and the main thread is waiting at
the end to print out these values. Given the measurements, the
thread scheduler seems to have done a decent job here."
</p>
