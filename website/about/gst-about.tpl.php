<p><a href="http://users.ipa.net/~dwighth/smalltalk/byte_aug81/design_principles_behind_smalltalk.html">"Design Principles Behind Smalltalk" by Daniel Ingalls</a></p>
<?=$Version;?>
<p>Home Page: <a href="http://www.gnu.org/software/smalltalk/smalltalk.html">http://www.gnu.org/software/smalltalk/smalltalk.html</a></p>
<p>Download: <a href="http://www.gnu.org/software/smalltalk/smalltalk.html">http://www.gnu.org/software/smalltalk/smalltalk.html</a></p>
<p></br>We've made the Smalltalk code a little more generic by abstracting out these implementation specific details, these are read from the command line before each script:</p>
<pre>
Object subclass<span class="sym">: #</span>Tests   instanceVariableNames<span class="sym">:</span> <span class="str">''</span>   classVariableNames<span class="sym">:</span> <span class="str">''</span>   poolDictionaries<span class="sym">:</span> <span class="str">''</span>   category<span class="sym">:</span> <span class="str">'Shootout'</span><span class="sym">!</span>

<span class="sym">!</span>Tests class methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>arg   <span class="sym">^</span>Smalltalk arguments first asInteger<span class="sym">! !!</span>Tests class methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>stdin   <span class="sym">^</span>FileStream stdin<span class="sym">! !</span>

<span class="sym">!</span>Tests class methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>stdinSpecial   <span class="sym">^</span><span class="kwa">self</span> stdin bufferSize<span class="sym">:</span> <span class="num">4096</span><span class="sym">! ! !</span>Tests class methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>stdout   <span class="sym">^</span>FileStream stdout<span class="sym">! !</span>

<span class="sym">!</span>Tests class methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>stdoutSpecial
   <span class="sym">^</span><span class="kwa">self</span> stdout bufferSize<span class="sym">:</span> <span class="num">4096</span><span class="sym">! !</span>

<span class="sym">!</span>Float methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>asStringWithDecimalPlaces<span class="sym">:</span> anInteger   <span class="sym">|</span> n s <span class="sym">|</span>
   n <span class="sym">:=</span> <span class="num">0.5</span>d <span class="sym">* (</span><span class="num">10</span> raisedToInteger<span class="sym">:</span> anInteger negated<span class="sym">).</span>
   s <span class="sym">:= ((</span><span class="kwa">self</span> sign <span class="sym">&lt;</span> <span class="num">0</span><span class="sym">)</span> ifTrue<span class="sym">: [</span><span class="kwa">self</span> <span class="sym">-</span> n<span class="sym">]</span> ifFalse<span class="sym">: [</span><span class="kwa">self</span> <span class="sym">+</span> n<span class="sym">])</span> printString<span class="sym">.</span>
   <span class="sym">^</span>s copyFrom<span class="sym">:</span> <span class="num">1</span> to<span class="sym">: (</span>s indexOf<span class="sym">: $.) +</span> anInteger <span class="sym">! !</span>

<span class="sym">!</span>Float methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>printOn<span class="sym">:</span> aStream withName<span class="sym">:</span> aString   aStream  nextPutAll<span class="sym">: (</span><span class="kwa">self</span> asStringWithDecimalPlaces<span class="sym">:</span> <span class="num">9</span><span class="sym">);</span>      nextPut<span class="sym">:</span> Character tab<span class="sym">;</span> nextPutAll<span class="sym">:</span> aString<span class="sym">;</span> nextPut<span class="sym">:</span> Character lf<span class="sym">.! !</span>

<span class="sym">!</span>Integer methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>asPaddedString<span class="sym">:</span> width
   <span class="sym">|</span> s <span class="sym">|</span>
   s <span class="sym">:=</span> <span class="kwa">self</span> printString<span class="sym">.</span>
   <span class="sym">^(</span>String new<span class="sym">: (</span>width <span class="sym">-</span> s size<span class="sym">)</span> withAll<span class="sym">: $ ),</span> s <span class="sym">! !!</span>Integer methodsFor<span class="sym">:</span> <span class="str">'platform'</span><span class="sym">!</span>asFloatD   <span class="sym">^</span><span class="kwa">self</span> asFloat<span class="sym">! !</span>
</pre>
