<?=$Version;?>

<p>The reported "*Java 6 steady state" program CPU secs and program Elapsed secs are <strong>approximate averages</strong>.</p>

<p>Each program performs the same calculation 20 times, for example:</p>

<pre>
   <span class="hl kwa">public static</span> <span class="hl kwb">void</span> <span class="hl kwd">main</span><span class="hl sym">(</span><span class="hl kwc">String</span><span class="hl sym">[]</span> args<span class="hl sym">){</span>
      <span class="hl kwa">for</span> <span class="hl sym">(</span><span class="hl kwb">int</span> i<span class="hl sym">=</span><span class="hl num">0</span><span class="hl sym">;</span> i<span class="hl sym">&lt;</span><span class="hl num">19</span><span class="hl sym">; ++</span>i<span class="hl sym">)</span> binarytrees<span class="hl sym">.</span><span class="hl kwd">program_main</span><span class="hl sym">(</span>args<span class="hl sym">,</span>false<span class="hl sym">);</span>

      binarytrees<span class="hl sym">.</span><span class="hl kwd">program_main</span><span class="hl sym">(</span>args<span class="hl sym">,</span>true<span class="hl sym">);</span>
   <span class="hl sym">}</span>
</pre>

<p>The "*Java 6 steady state" program CPU secs and program Elapsed secs measurements are made in the same way as all the other time measurements, but before display they are divided by 20 to give <strong>approximate averages</strong>.</p>


<p></p>
