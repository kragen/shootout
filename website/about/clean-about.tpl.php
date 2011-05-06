<?=$Version;?>
<p>Home Page: <a href="http://wiki.clean.cs.ru.nl/Clean">Clean</a></p>
<p>Download: <a href="http://wiki.clean.cs.ru.nl/Download_Clean">Download Clean</a></p>
<p><br/>We've made the Clean programs a little more obvious by providing these library functions:</p>
<pre>
import StdEnv<span class="hl sym">,</span> ArgEnv

                                             
<span class="hl slc">// The first commandline arg (if it will convert to Int) otherwise 1
</span>
argi <span class="hl sym">::</span> Int
argi <span class="hl sym">=</span> if <span class="hl sym">(</span>argAsInt &lt;<span class="hl sym">=</span> <span class="hl num">0</span><span class="hl sym">)</span> <span class="hl num">1</span> argAsInt
   where
      argv <span class="hl sym">=</span> getCommandLine
      argAsInt <span class="hl sym">=</span> if <span class="hl sym">(</span>size argv <span class="hl sym">==</span> <span class="hl num">2</span><span class="hl sym">) (</span>toInt argv<span class="hl sym">.[</span><span class="hl num">1</span><span class="hl sym">])</span> <span class="hl num">1</span>


<span class="hl slc">// Round to n decimal places &amp; convert to String 
</span>
toStringWith <span class="hl sym">:: !.</span>Int <span class="hl sym">!.</span>Real <span class="hl sym">-&gt; {#</span>Char<span class="hl sym">}</span>     
toStringWith n a
   <span class="hl sym">#</span> z <span class="hl sym">=</span> <span class="hl num">10.0</span> <span class="hl sym">^(</span>~ <span class="hl sym">(</span>toReal n<span class="hl sym">))</span>   
   <span class="hl sym">#</span> x <span class="hl sym">= (</span><span class="hl num">0.5</span> <span class="hl sym">*</span> z<span class="hl sym">) +</span> abs a
   <span class="hl sym"># (</span>s<span class="hl sym">,</span>exp<span class="hl sym">) =</span> ndigits x z <span class="hl sym">(</span>entier x<span class="hl sym">) (</span>nsign a<span class="hl sym">)</span> <span class="hl num">0</span>
   <span class="hl sym"># (</span>s<span class="hl sym">,</span>exp<span class="hl sym">) =</span> nzeros s exp True
   <span class="hl sym">=</span> s

   where
   nsign x <span class="hl sym">=</span> if <span class="hl sym">(</span>x&lt;<span class="hl num">0.0</span><span class="hl sym">)</span> <span class="hl str">&quot;-&quot;</span> <span class="hl str">&quot;&quot;</span>
      
   ndigits x z i s exp
      <span class="hl sym">|</span> x&lt;z <span class="hl sym">= (</span>s<span class="hl sym">,</span>exp<span class="hl sym">)</span>
      <span class="hl sym">#</span> x <span class="hl sym">= (</span>x <span class="hl sym">-</span> toReal i<span class="hl sym">)*</span><span class="hl num">10.0</span>
      <span class="hl sym">=</span> ndigits x <span class="hl sym">(</span>z<span class="hl sym">*</span><span class="hl num">10.0</span><span class="hl sym">) (</span>entier x<span class="hl sym">)</span> 
         <span class="hl sym">((</span>if <span class="hl sym">(</span>exp <span class="hl sym">== -</span><span class="hl num">1</span><span class="hl sym">)(</span>s <span class="hl sym">+++</span> <span class="hl str">&quot;.&quot;</span><span class="hl sym">)</span> s<span class="hl sym">) +++</span> toString i<span class="hl sym">) (</span>exp<span class="hl sym">-</span><span class="hl num">1</span><span class="hl sym">)</span>

   nzeros s exp point
      <span class="hl sym">|</span> exp &lt; ~n <span class="hl sym">= (</span>s<span class="hl sym">,</span>exp<span class="hl sym">)</span>
      <span class="hl sym">| (</span>exp <span class="hl sym">== -</span><span class="hl num">1</span> <span class="hl sym">&amp;&amp;</span> point<span class="hl sym">) =</span> nzeros <span class="hl sym">(</span>s <span class="hl sym">+++</span> <span class="hl str">&quot;.&quot;</span><span class="hl sym">)</span> exp False
      <span class="hl sym">=</span> nzeros <span class="hl sym">(</span>s <span class="hl sym">+++</span> <span class="hl str">&quot;0&quot;</span><span class="hl sym">) (</span>exp<span class="hl sym">-</span><span class="hl num">1</span><span class="hl sym">)</span> point 
</pre>
