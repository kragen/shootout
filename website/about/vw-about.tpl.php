<p>Code size measurements are misleading for Smalltalk because source files are usually only used to archive or transfer code. Smalltalk code is created, stored and run in a Smalltalk <em>image</em>. We show Smalltalk source code in a verbose <em>chunk file</em> format used to archive or transfer source code between Smalltalk <em>images</em>.</p>
<p><a href="http://users.ipa.net/~dwighth/smalltalk/byte_aug81/design_principles_behind_smalltalk.html">"Design Principles Behind Smalltalk" by Daniel Ingalls</a></p>
<?=$Version;?>
<p>Home Page: <a href="http://smalltalk.cincom.com/prodinformation/index.ssp?content=vwfactsheet">Cincom Smalltalk&#8482; VisualWorksl&#174; Environment Data Sheet</a></p>
<p>Download: <a href="http://www.cincomsmalltalk.com/userblogs/cincom/blogView?content=smalltalk">VisualWorksl&#174; Non-Commercial</a></p>
<p></br>We've made the Smalltalk code a little more generic by abstracting out these implementation specific details:</p>
<pre>
Object subclass: #Tests   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!Tests class methodsFor: 'platform'!arg   ^CEnvironment commandLine last asNumber! !
!Tests class methodsFor: 'platform'!stdin   ^Stdin! !
!Tests class methodsFor: 'platform'!stdout   ^Stdout! !

!LimitedPrecisionReal methodsFor: 'platform'!asStringWithDecimalPlaces: anInteger   ^(self asFixedPoint: anInteger) printString copyWithout: $s! !

!LimitedPrecisionReal methodsFor: 'platform'!printOn: aStream withName: aString   aStream  nextPutAll: (self asStringWithDecimalPlaces: 9);      nextPut: Character tab; nextPutAll: aString; nextPut: Character lf.! !

!Integer methodsFor: 'platform'!asPaddedString: aWidth   | s |
   s := WriteStream on: (String new: 10).
   self printOn: s paddedWith: $  to: aWidth base: 10.
   ^s contents ! !
</pre>
