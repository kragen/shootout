<p>This is a <strong>contest</strong> - different algorithms may be used.</p>

<p>You are expected to use your program to find all 2098 solutions of the puzzle and <strong>diff that output against our </strong><a href="http://shootout.alioth.debian.org/download/meteor-output.txt"><strong>237KB output file</strong> (Save Target As… Save Link As…)</a> <strong><em>before</em> you contribute your program.</strong></p>


<p>The Meteor Puzzle board is made up of 10 rows of 5 hexagonal Cells. There are 10 puzzle pieces to be placed on the board, we'll number them 0 to 9. Each puzzle piece is made up of 5 hexagonal Cells. As different algorithms may be used to generate the puzzle solutions we require that the solutions be printed in a standard order and format. Working down the board from top to bottom, and along each row left to right, take the number of the piece placed in each cell on the board, and create a string from all 50 numbers, for example the first puzzle solution we show would be represented by </p><pre>00001222012661126155865558633348893448934747977799</pre>
<p>The Meteor Puzzle solutions should be sorted in ascending order based on these 50 character strings. Each solution should then be printed in a format that mimics the hexagonal board, like this</p><pre>0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

</pre>
<p>Check the <a href="http://shootout.alioth.debian.org/download/meteor-output.txt">237KB output file (Save Target As… Save Link As…)</a> for the exact format we expect.</p>

<h3>Hints</h3>
<p>  </p>
<p>The Meteor Puzzle and 3 Java puzzle solvers are described in <a href="http://www-128.ibm.com/developerworks/java/library/j-javaopt/">"Optimize your Java application's performance"</a>.</p>
