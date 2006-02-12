<?   // Copyright (c) Isaac Gouy 2004-2006 ?>

<div>
<p class="rs"><? printf('%s GMT', gmdate("d M Y, l, g:i a", $Changed)) ?></p>
<p>This FAQ is short. You can read it really quickly.</p>
</div>

<!-- WHAT CAN I LEARN HERE? /////////////////////////////////////////////// -->
<table class="div">
<tr><td><h3 class="rev"><a class="arev" href="#learn" name="learn">&nbsp;What can I learn from this FAQ?</a></h3></td></tr>
<tr><td>
<p><em>The Computer Language Shootout</em> has a <strong>very narrow focus</strong>.</p>

<p>We are only trying to show the performance of various programming language implementations, on a limited number of <a href="miscfile.php?file=benchmarking&amp;title=Flawed Benchmarks" title="Flawed benchmarks - Are there any other kind?"><strong>flawed benchmarks</strong></a>.</p>

<p>We <strong>are not</strong> trying to</p>
<ul>
<li>compare different algorithms</li>
<li>showcase the capabilities of different languages</li>
<li>compare programming language productivity</li>
<li>contest programmer effort and sneaky tricks</li>

<li><em>etc etc</em></li>
</ul>
</td></tr>

<tr class="b"><td><a class="ab" href="#contents" name="contents">What else?</a></td></tr>
<tr><td>
<p><a href="#help"><strong>Where can I discuss&#8230; contribute&#8230;?</strong></a></p>
<p><a href="#where"><strong>Where can I see&#8230;?</strong></a></p>
<p><a href="#means"><strong>What does &#8230; mean?</strong></a></p>
<p><a href="#measure"><strong>How did you measure&#8230;?</strong></a></p>
<p><a href="#whydont"><strong>Why don't you &#8230;?</strong></a></p>
<p><a href="#when"><strong>Who&#8230;?</strong> <strong>When&#8230;?</strong> <strong>Why&#8230;?</strong></a></p>
</td></tr>

</table>


<table class="div">
<tr><td><h3 class="rev"><a class="arev" href="#help" name="help">&nbsp;Where can I discuss&#8230; contribute&#8230;?</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#talk" name="talk">Where can I discuss&#8230;?</a></td></tr>
<tr><td><p>Discuss the benchmarks or ask for help in the <a href="http://alioth.debian.org/forum/?group_id=30402" title="Find Help, Share Opinions"><strong>discussion&nbsp;forums</strong></a>.</p></td></tr>

<tr class="b"><td><a class="ab" href="#contributeprogram" name="contributeprogram">Where do I contribute a program?</a></td></tr>
<tr><td>
<p><strong>Before</strong> working on a benchmark program:</p>
<ul>
<li>browse the current benchmarks - <a href="http://shootout.alioth.debian.org/"><strong>Start:</strong> on the homepage</a></li>
<li>read the benchmark description</a></li>
<li>read some of the programs</a></li>
<li>read <a href="#implement"><strong>"How should I implement&#8230;?"</strong></a></li>
</ul>
<p>Then follow these detailed instructions <a href="#contribute"><strong>"How do I contribute a program?"</strong></a></p>
<p>Be Respectful! Don't ridicule other people's programs - just contribute a better program yourself.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#contributebenchmark" name="contributebenchmark">Where do I contribute a new benchmark?</a></td></tr>
<tr><td>
<p><strong>Before</strong> working on a new benchmark</p>
<ul>
<li>browse the current benchmarks - <a href="http://shootout.alioth.debian.org/"><strong>Start:</strong> on the homepage</a></li>
<li>read the benchmark descriptions</a></li>
<li>read <a href="#newbench"><strong>"How can I contribute a new benchmark?"</strong></a></li>
</ul>
</td></tr>

<tr class="b"><td><a class="ab" href="#report" name="report">Where can I report bugs&#8230; request features?</a></td></tr>
<tr><td>
<p>Tell us about content mistakes, inconsistencies, bad installs <em>etc</em> - <a href="https://alioth.debian.org/tracker/?atid=411002&amp;group_id=30402&amp;func=browse"><strong>Report a Bug</strong></a>.</p> 
<p>Tell us about the latest language updates <em>etc</em> - add a <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><strong>Feature Request</strong></a>.</p> 
</td></tr>

<tr class="b"><td>&nbsp;</td></tr>
<tr><td>
<p>Change the things you don't like - <em>convince us</em> that the change is a worthwhile improvement and then <em>expect to do all the work</em>.</p>
<p><strong>Be Nice!</strong> Maybe we'll reject the program. Maybe we'll decide not to add the new benchmark. Maybe we'll prefer our own opinions. Maybe we'll decide not to change something.</p>
</td></tr>

</table>


<!-- HOW SHOULD I IMPLEMENT ...? /////////////////////////////////////// -->

<table class="div">

<tr><td><h3 class="rev"><a class="arev" href="#implement" name="implement">&nbsp;How should I implement&#8230;?</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#correct" name="correct">How much effort should I put into getting the program correct?</a></td></tr>
<tr><td>
<p>Do design-iteration on your machine, or in a language newsgroup. Only Contribute Programs which give <strong>correct results</strong> on your machine - <strong>diff</strong> the program output with the provided output file. (Don't make-unnecessary-work for the committers.)</p>
<p>Leave it a couple of days, and then see if there are any <strong>minor improvements</strong> that you'd like to make, before you Contribute Programs to the Computer Language Shootout.</p> 
</td></tr>

<tr class="b"><td><a class="ab" href="#implementp" name="implementp">How should I implement programs for the Shootout?</a></td></tr>
<tr><td>
<p>We prefer <strong>plain vanilla programs</strong> - after all we're trying to compare language implementations not programmer effort and skill.</p> 
<p>We also have a weakness for idiosyncratic, elegant, clever programs; and when they are too elegant to meet the requirements of the benchmark we <em>might</em> still show them in the <a href="faq.php#alternative">'Interesting Alternative Programs'</a> section.</p> 
</td></tr>

<tr class="b"><td><a class="ab" href="#datainput" name="datainput">How should I implement data-input?</a></td></tr>
<tr><td>
<p>Programs are measured across a range of input-values; programs are expected to either take a <strong>single command-line parameter</strong> or read text from <strong>stdin</strong>.</p> 
<p>(Look at what the other programs do.)</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#dataoutput" name="dataoutput">How should I implement data-output?</a></td></tr>
<tr><td>
<p>Programs should write to <strong>stdout</strong>. Program output is redirected to a log-file and compared to the expected output.</p> 
<p>(Look at what the other programs do.)</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#brag" name="brag">How should I identify my program?</a></td></tr>
<tr><td><p>Include a header comment in the program like this:</p>
<pre>
/* The Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by &#8230;
   modified by &#8230;
*/
</pre>
</td></tr>

<tr class="b"><td><a class="ab" href="#implementlist" name="implementlist">How should I implement&#8230;?</a></td></tr>
<tr><td>
<ol>
<li>Keep to the spirit-of-the-specification not just the wording.</li>
<li>Write the program to be as-fast-as possible.</li>
<li>Write the program to conserve memory as-much-as possible.</li>
<li>Write the program as-if lines of code were not being measured.</li>
</ol>     
<br />
</td></tr>

<tr class="b"><td><a class="ab" href="#split" name="split">How should I implement multiple source code files?</a></td></tr>
<tr><td>
<p>We use a simple script to <strong>split a single source file</strong> into multiple target source files.</p>
<p>One of the target source files <em>must</em> have the same filename as the original single source file, and is expected to be the 'main' program.</p>
<p>For example, the <a href="benchmark.php?test=nbody&amp;lang=se">Eiffel <em>nbody.e</em> source file</a> will be split into 3 target source files - <em>nbody.e, body.e, nbody_system.e</em> - 
each new target source file will start from the <strong>comment line</strong> which included the SPLITFILE=<em>target-filename</em> directive and run to the line preceding the next
 SPLITFILE=<em>target-filename</em> directive or end-of-file.</p>
<p>So, the new target source file <em>body.e</em> will start with the line
<pre>-- SPLITFILE=body.e</pre><br/>
<p>and end with the empty line following</p>
<pre>end -- class BODY</pre>

</td></tr>

<tr class="b"><td><a class="ab" href="#unroll" name="unroll">How should I implement loops?</a></td></tr>
<tr><td><p>Don't manually unroll loops!</p> 
</td></tr>

<tr class="b"><td><a class="ab" href="#promo" name="promo">How should I advertise my company, services, website&#8230;?</a></td></tr>
<tr><td><p><strong>We'll remove any promos</strong> that you add as comment text, so please don't waste our time.</p> 
</td></tr>
</table>


<table class="div">

<tr><td><h3 class="rev"><a class="arev" href="#contribute" name="contribute">&nbsp;How do I contribute a program?</a></h3></td></tr>

<tr><td>
<p>There are many contributors and few committers - a little more time spent by contributors saves committers a great deal more time.</p>
<p>Please don't contribute patch-files. Do attach full source-code from tested programs.</p>
<p>Before contributing programs</p>
<ol>
<li>read the <a href="miscfile.php?file=license&amp;title=revised BSD license" title="Read the revised BSD license"><strong>Revised&nbsp;BSD&nbsp;license</strong></a> - all contributed programs are published under this revised BSD license.</li>
<li>read <a href="faq.php#implement"><strong>How should I implement&#8230;?</strong></a></li>
<li>login with an Alioth id <em>is not required</em> but login allows you to make updates after contributing a program - <a href="http://alioth.debian.org/account/register.php"><strong>create an Alioth id</strong></a>.</li>
</ol>

<br />
<p>Follow these instructions <strong>step-by-step</strong></p>
<ol>
<li>Start from the bottom. Upload &amp; <strong>Attach</strong> the program source-code file - do this first because it's easy to forget.</li>
<li>Be sure to click the Upload &amp; Attach <strong>check box</strong> - it's easy to forget.</li>
<li>Say in the <strong>Description</strong> how this program fixes an error or is faster or was missing or &#8230; Give us reasons to accept your program.</li>
<li>Each <strong>Summary</strong> text <em><strong>must</strong></em> be unique! Follow this convention:<br />  
language, benchmark, your-name, date, (version)<br />
<em>Ruby nsieve Glenn Parker 2005-03-28</em><br />
</li>
<li><strong>Category</strong>: select the language implementation</li>
<li><strong>Group</strong>: select the benchmark</li>
<li>click the Submit button</li>
</ol>

<p>Now <strong>start from the bottom</strong> of the
   <a href="https://alioth.debian.org/tracker/?func=add&amp;group_id=30402&amp;atid=411646"  title="Contribute Programs - Submit New">
   <strong>Contribute Programs Submit-New</strong></a> form and work your way up.
</p>
</td></tr>


<tr class="b"><td><a class="ab" href="#status" name="status">How can I track what happens to the program I contributed?</a></td></tr>
<tr><td>
<p>Browse <a href="https://alioth.debian.org/tracker/?func=browse&amp;group_id=30402&amp;atid=411646" title="Browse Contribute Programs"><strong>Contribute Programs</strong></a></p>

<p>Check the <strong>Resolution</strong> field, and check the <strong>State</strong> field</p>
<ul>
<li><em>Open items</em> are new contributions</li>
<li><em>Pending items</em> have been added to CVS</li>
<li><em>Closed items</em> are being shown on the website</li>
</ul>

</td></tr>

<tr class="b"><td><a class="ab" href="#mycontribution" name="mycontribution">When will you include my contribution?</a></td></tr>

<tr><td>
<p>When we can! We already spend way-too-much personal-time on this website. Things get-done when they get-done.</p>
<p>Maybe you'd like to <a href="#chores">help us with the chores</a>?</p>
<p>Normally, contributed programs will be measured and included on the website once or twice each week.</p>
<p>The simplest way to find out when new measurements have been made is to subscribe to <a href="<?=CORE_SITE;?>feeds/rss.xml"><img src="<?=IMAGE_PATH;?>orangexml.gif" alt="Really Simple Syndication" title="Really Simple Syndication" /></a> - our <a href="<?=CORE_SITE;?>feeds/rss.xml">RSS feed</a>.</p>
<p>My Yahoo! users can add our feed by clicking <a href="http://add.my.yahoo.com/rss?url=<?=CORE_SITE;?>feeds/rss.xml"><img src="<?=IMAGE_PATH;?>addtomyyahoo4.gif" width="91" height="17" border="0" alt="Add to My Yahoo!"></a></p>
</td></tr>

<tr class="b"><td><a class="ab" href="#newbench" name="newbench">How can I contribute a new benchmark?</a></td></tr>
<tr><td>
<p>Do all the work!</p>
<ul>
<li>Understand that benchmarks must be reasonable across a wide range of programming languages</li>
<li>Identify what's missing or wrong with the current benchmarks</li>
<li>Define a new benchmark and give some background information</li>
<li>Provide implementations in an interpreted language, a JIT language, and a compiled language</li>
</ul>
<p>We will accept <strong>and reject</strong> benchmarks in a capricious, unfair, biased fashion.</p>
</td></tr>

<tr><td>
<p>Browse <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><strong>Feature Requests</strong></a> with Category <strong>New Benchmark</strong> to see if it's already been suggested.</p>
</td></tr>



<tr class="b"><td><a class="ab" href="#chores" name="chores">How can I help with <strong>the chores</strong>?</a></td></tr>
<tr><td>
<p>We need volunteers to</p>
<ol>
<li>Browse <a href="https://alioth.debian.org/tracker/?func=browse&amp;group_id=30402&amp;atid=411646" title="Browse Contribute Programs"><strong>Contribute Programs</strong></a> for <em>Open items</em></li>
<li>check the <em>Open item</em> programs do what's required</li>
<li>add acceptable <em>Open item</em> programs to CVS</li>
<li>update the status of accepted <em>Open items</em> to <em>Pending</em></li>
</ol>
<p>And we need them to</p>
<ol>
<li>remove slower less-elegant programs from CVS</li>
<li>update the status of removed <em>Closed items</em> to <em>Deleted</em></li>
</ol>

<p>And other chores listed in the <a href="miscfile.php?file=committerfaq&amp;title=Committer&nbsp;FAQ" title="Committer FAQ"><strong>Committer FAQ</strong></a>.</p>
<p>Do you have the necessary programming language knowledge?<br />
Do you want to help with the chores?</p>
<p>Contact us! Contact one of the <strong>Project Admins</strong> - listed on the GForge project page under <a href="http://alioth.debian.org/projects/shootout/"  title="Contact one of the Project Admins"><strong>Developer Info</strong></a>.</p>

</td></tr>


</table>




<!-- WHERE CAN I? ////////////////////////////////////////////////// -->
<table class="div">
<tr><td><h3 class="rev"><a class="arev" href="#where" name="where">&nbsp;Where can I see&#8230;?</a></h3></td></tr>


<tr class="b"><td><a class="ab" href="#seemore" name="seemore">Where can I see more about a <strong>Timeout</strong> or <strong>Error</strong>?</a></td></tr>
<tr><td>
<p>Sometimes a program may produce correct results, within the timeout, for smaller workloads - so check the data on the <a href="http://shootout.alioth.debian.org/debian/fulldata.php?test=ackermann&amp;p1=gcc-3&amp;p2=gcc-3&amp;p3=gcc-3&amp;p4=gcc-3#cputable" title="full data"><strong>full data page</strong></a>.</p>
<p>You may find information about an Error in the 'build &amp; benchmark results' section of the program page.</p>
</td></tr>


<tr class="b"><td><a class="ab" href="#version" name="version">Where can I see which language version was used?</a></td></tr>
<tr><td>
<p>You can see information about the language implementation, including the version number, at the bottom of each <a href="http://shootout.alioth.debian.org/debian/benchmark.php?test=all&amp;lang=gcc#about" title="about the C gcc language"><strong>language comparison page</strong></a>.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#options" name="options">Where can I see which compiler and runtime options were used?</a></td></tr>
<tr><td>
<p>You can see the build commands and runtime commands on each program page in the 
<a href="http://shootout.alioth.debian.org/debian/benchmark.php?test=ackermann&amp;lang=gcc&amp;id=3#log" title="build &amp; benchmark results"><strong>build &amp; benchmark results</strong></a> section.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#arch" name="arch">Where can I see what other people think about the Language Shootout?</a></td></tr>
<tr><td><p>Google! Here's some <a href="http://groups-beta.google.com/group/comp.lang.functional/msg/ddb2894d9e3d8024?hl=en" title="comp.lang.functional"><strong>sensible criticism</strong></a> of the original Shootout.</p></td></tr>

<tr class="b"><td><a class="ab" href="#downsource" name="downsource">Where can I see more?</a></td></tr>
<tr><td><p>The <strong>project is hosted</strong> by <a href="http://alioth.debian.org/projects/shootout"  title="The Great Computer Language Shootout project page on Alioth GForge at Debian.org">Alioth&nbsp;GForge Debian.org</a>.</p></td></tr>

<tr><td><p>You can <a href="http://alioth.debian.org/scm/?group_id=30402"  title="Browse the Great Computer Language Shootout CVS tree">browse the CVS tree</a>.</p>
<p>Build dependencies include - <a href="http://packages.debian.org/stable/libs/libgtop1">libgtop</a>, <a href="http://search.cpan.org/~mjh/GTop-0.16/GTop.pod">GTop</a>, libXau, and <a href="http://packages.debian.org/stable/perl/libbsd-resource-perl">BSD::Resource</a> </p>
</td></tr>

</table>



<!-- WHAT DOES ... MEAN? /////////////////////////////////////////////// -->
<table class="div">
<tr><td><h3 class="rev"><a class="arev" href="#means" name="means">&nbsp;What does &#8230; mean?</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#alternative" name="alternative">What does Interesting Alternative Program mean?</a></td></tr>
<tr><td>
<p>"Interesting Alternative Program" means that the program doesn't implement the benchmark according to the arbitrary and idiosyncratic rules of the Computer Language Shootout - but <strong>we simply couldn't resist</strong> showing the program.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#id" name="id">What do #2 #3 mean?</a></td></tr>
<tr><td>
<p>Nothing - they are arbitrary suffixes that identify a specific program.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#fullcpu" name="fullcpu">What does Full CPU Time mean?</a></td></tr>
<tr><td>
<p>Full CPU Time means <strong>program run-time</strong> including program <strong>startup time</strong>. So for Java that includes the time to startup a JVM.</p>

<p>You can see the <strong>enormous difference in startup time</strong> between languages on the <a href="benchmark.php?test=hello&amp;lang=all" title="Compare performance on the startup benchmark">startup benchmark</a>.</p>
</td></tr>

</table>






<!-- HOW DID YOU MEASURE...? /////////////////////////////////////////////// -->



<table class="div">

<tr><td><h3 class="rev"><a class="arev" href="#measure" name="measure">&nbsp;How did you measure&#8230;?</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#pretest" name="pretest">How did you measure?</a></td></tr>
<tr><td>
<p>Each program was run once pre-test to reduce cache effects. Program output is redirected to a log-file and compared to the expected output.</p>
<p>Each program was then run 3 times with program output redirected to /dev/null. We show the lowest measured CPU time and the highest memory usage, from the 3 runs.</p>
<p>The variation between cpu times is different for different languages and for different benchmarks. 
<em>The coefficient of variation</em> for 100 measurements of nbody ranged from 0.029% (Lua) to 0.074% (Oberon2) to 0.092% (C#); 
and for 100 measurements of fasta ranged from 0.009% (Lua) to 0.088% (C#) to 0.655% (Oberon2).</p>
<p>Don't sweat the small stuff - differences in cpu time of a few % are illusory.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#measurecpu" name="measurecpu">How did you measure <strong>CPU time?</strong></a></td></tr>

<tr><td><p>Each program was run as a child-process of a Perl script. We take the script child-process usr+sys time, before forking the child-process and after the child-process exits.</p>
<p>(<a href="http://packages.debian.org/stable/interpreters/libbsd-resource-perl" title="Debian package 'perl BSD::Resource - BSD process resource limit and priority'">BSD::Resource::times</a>)[2,3] does seem to provide better resolution than Perl times() builtin function or <a href="http://www.danlj.org/mkj/lad/info/time.html#SEC10" title="Measuring Program Resource Use: The GNU time Command">GNU time</a>, for example measuring the same program:</p>
<pre>Perl times() builtin function
16.650
16.660
16.640

BSD::Resource::times
16.659
16.656
16.655

GNU time version 1.7
16.62
16.61
16.60

Bash time builtin command
16.624
16.628
16.638

</pre>

<p>We use (<a href="http://packages.debian.org/stable/interpreters/libbsd-resource-perl" title="Debian package 'perl BSD::Resource - BSD process resource limit and priority'">BSD::Resource::times</a>)[2,3]</p>

<p>The Full CPU time <em>includes</em> program startup time. You can see the <strong>enormous difference in startup time</strong> between languages on the <a href="benchmark.php?test=hello&amp;lang=all" title="Compare performance on the startup benchmark">startup benchmark</a>.</p>
</td></tr>



<tr class="b"><td><a class="ab" href="#memory" name="memory">How did you measure <strong>memory usage?</strong></a></td></tr>

<tr><td><p>In a very approximate and unreliable way. We sampled the child-process resident memory size (VmRSS) multiple times a second. We identified the main thread by checking for SIGCHLD being registered as the exit_signal in the second to last field of /proc/{pid}/stat.</p>
<p>There's a race condition. When the program completes quickly, this sampling technique will fail.</p>       
</td></tr>


<tr class="b"><td><a class="ab" href="#codelines" name="codelines">How did you measure <strong>lines-of-code?</strong></a></td></tr>

<tr><td>
<p>In a haphazard and approximate way - blank lines and comments were removed, and then we counted the lines that remain.</p>
<p>We reserve the right to format the code entries as we see fit, whatever the lines-of-code count may be.</p> 
</td></tr>


<tr class="b"><td><a class="ab" href="#machine" name="machine">What machine are you running the programs on?</a></td></tr>
<tr><td>
<p>We use a single-processor 2.2Ghz AMD&#8482; Sempron&#8482; machine with 512 MB of RAM and a 40GB IDE disk drive; and a single-processor 2Ghz Intel<sup>&#174;</sup> Pentium<sup>&#174;</sup> 4 machine with 512MB of RAM and an 80GB IDE disk drive.</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#os" name="os">What OS are you using on the test machine?</a></td></tr>

<tr><td>
<p>We use <strong>Debian Linux&#8482;</strong> 'unstable', Kernel 2.6.8-1-k7 and <strong>Gentoo Linux&#8482;</strong> 2005.1 stage 3, gentoo-sources-2.6.13-r5, Reiserfs</p>
</td></tr>


</table>




<!-- WHY DON"T YOU INCLUDE...? /////////////////////////////////////////////// -->



<table class="div">
<tr><td><h3 class="rev"><a class="arev" href="#whydont" name="whydont">&nbsp;Why don't you&#8230;?</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#contest" name="contest">Why don't you accept every program that gives the correct result?</a></td></tr>
<tr><td>
<p>We are trying to show the performance of various programming language implementations - so we ask that contributed programs not only give the 
correct result, but also <strong>use the same algorithm</strong> to calculate that result.</p>
<p>Doug Bagley used both <em>same way</em> (same algorithm) and <em>same thing</em> (same result) benchmarks - so in many cases the performance
 differences were simply better algorithms.</p>
<p>After hearing many arguments, it seems <em>to me</em> that we should think of <em>same way</em> (same algorithm) tests as <strong>benchmarks</strong>, and
 we should think of <em>same thing</em> (same result) tests as <strong>contests</strong>.</p>
<p>At present, we are only trying to show benchmarks.</p>
</td></tr>


<tr class="b"><td><a class="ab" href="#acceptable" name="acceptable">Why don't you include my favourite language?</a></td></tr>
<tr><td><p>Is the language implementation</p>
<ul>
<li><strong>Used?</strong> There are way too many dead languages and unused new languages - see <a href="http://people.ku.edu/~nkinners/LangList/Extras/langlist.htm">The Language List</a> and <a href="http://www.levenez.com/lang/">Computer Languages History</a></li>
<li><strong>Interesting?</strong> Is there something significant and interesting about the language, and will that be revealed by these simple benchmark programs?</li>
</ul>
<p>We will accept <strong>and reject</strong> languages in a capricious, unfair, biased fashion.</p>
</td></tr>


<tr class="b"><td><a class="ab" href="#acceptablemore" name="acceptablemore">Why don't you include my favourite language?</a></td></tr>
<tr><td>
<p>Can the language implementation be used to write most of our benchmark programs?</p> 
<p><strong>Must have</strong></p>
<ol>
<li>A <a href="http://packages.debian.org/unstable/" title="Debian packages">Debian package</a> (either from Debian itself, or the primary authors of the language)
or a <a href="http://packages.gentoo.org/categories/" title="Gentoo ebuilds">Gentoo ebuild</a> or build and install with <code>./configure &amp;&amp; make &amp;&amp; make install</code> and a default target of <code>/usr/local.</code></li>
<li>Command-line argument handling.</li>
<li>32-bit Integers.</li>
<li>Double precision floating point numbers.</li>
<li>Line-oriented read &amp; write from stdin &amp; stdout.</li>
<li>Documentation.</li>
</ol>

<p><strong>Should have</strong></p>
<ol>
<li>Buffered stdio.</li>
<li>Dynamic hash tables and sequences (arrays or lists).</li>
<li>Exception handling.</li>
<li>Regular Expressions (preferably Perl compatible).</li>
<li>Concurrency (threads, coroutines, &#8230;)</li>
<li>TCP/IP Sockets.</li>
</ol>
</td></tr>

<tr class="b"><td><a class="ab" href="#please" name="please">Please will you include my favourite language?</a></td></tr>
<tr><td>
<p>Maybe we will when you write many benchmark programs in your favourite language, and contribute them to "The Computer Language Shootout" :-)</p>
</td></tr>

<tr><td>
<p>Browse <span><a class="arevSandbox" title="Alpha benchmarks and more language implementations" href="<?=SANDBOX_SITE;?>index.php" >&nbsp;The&nbsp;Sandbox&nbsp;</a></span> website to see if your favourite language is already shown.</p>
<p>Browse <a href="https://alioth.debian.org/tracker/index.php?group_id=30402&amp;atid=411005"><strong>Feature Requests</strong></a> with Category <strong>New Language</strong> to see if it's already been suggested.
You'll see that several languages have been <em>suggested</em> but no one has contributed programs yet.</p>
</td></tr>

</table>


<!-- WHEN? /////////////////////////////////////////////////////////////////// -->

<table class="div">
<tr><td><h3 class="rev"><a class="arev" href="#when" name="when">&nbsp;Who&#8230;? When&#8230;? Why&#8230;?</a></h3></td></tr>

<tr class="b"><td><a class="ab" href="#start" name="start">Who started "The Great Computer Language Shootout"?</a></td></tr>
<tr><td><p>Doug Bagley created <a href="http://web.archive.org/web/20040401204425/www.bagley.org/~doug/shootout/index2.shtml" title="Doug Bagley's website from the Internet Archive">"The Great Computer Language Shootout"</a>, and it was active until 2001.</p>
<p>Aldo Calpini ported that to create <a href="http://dada.perl.it/shootout/" title="The Computer Language Shootout for MS Windows programming languages">"The Great Win32 Computer Language Shootout"</a> - it was last updated June 2003.</p>

<p>In mid-2004 <strong>Brent Fulgham revived</strong> <a href="http://web.archive.org/web/20040611035744/http://shootout.alioth.debian.org/" title="Brent Fulgham's website from the Internet Archive">"The Great Computer Language Shootout"</a> here on Alioth&nbsp;Debian.org</p>
<p>In the following months, things started to change. First, the website was redesigned showing the original benchmarks in a new way, look back at the 2001 <span><a class="arevOld" title="Look back at the Old 2001 Doug Bagley Benchmarks" href="<?=OLD_SITE;?>index.php" >&nbsp;Old Doug Bagley Benchmarks&nbsp;</a></span>.</p>
<p>Benchmarks were deprecated, new benchmarks were added; and we continue to experiment on <span><a class="arevSandbox" title="Alpha benchmarks and more language implementations" href="<?=SANDBOX_SITE;?>index.php" >&nbsp;The&nbsp;Sandbox&nbsp;</a></span>
 website.</p>
<p>In late-2005 Isaac Gouy started to experiment with the <span><a class="arevGP4" title="Browse the Gentoo : Intel&#174; Pentium&#174; Computer Language Shootout" href="<?=GP4_SITE;?>index.php" >&nbsp;Gentoo&nbsp:&nbsp;Intel&#174;&nbsp;Pentium&#174;&nbsp;4&nbsp;</a></span> website. Who knows where it 
        will end?</p>
</td></tr>

<tr class="b"><td><a class="ab" href="#ack" name="ack">Who has contributed?</a></td></tr>
<tr><td><p>So many people that we have an <a href="miscfile.php?file=acknowledgements&amp;title=acknowledgements" title="Acknowledgements to those who have contributed to The Great Computer Language Shootout">acknowledgements page</a>!</p></td></tr>

<tr class="b"><td><a class="ab" href="#similar" name="similar">Who's working on similar projects?</a></td></tr>
<tr><td><p>Jack Andrews has started <a href="http://shootin.sourceforge.net/" title="Jack Andrew's shootin">"the shootin"</a>, 
and Adam Chlipala has started <a href="http://www.softwarescrutiny.net/ss/intro/" title="Adam Chlipala's Software Scrutiny">"Software Scrutiny"</a>.</p></td></tr>


<tr class="b"><td><a class="ab" href="#finish" name="finish">When will the Language Shootout be finished?</a></td></tr>
<tr><td>
<p>Never. There will always be new languages, new versions of languages, more sensible benchmarks, faster more-elegant programs, new operating systems, better graphics&#8230; And the project team will change over time, and the measurements and presentation will change with them.</p>
</td></tr>


<tr class="b"><td><a class="ab" href="#whydo" name="whydo">Why are you doing this?</a></td></tr>
<tr><td><p>To learn and to <strong>have fun</strong>.</p><p>We will continue as long as the fun holds out.</p></td></tr>

</table>







