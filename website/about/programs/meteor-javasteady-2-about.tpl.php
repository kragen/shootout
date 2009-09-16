<p>The reported "*Java 6 steady state" program CPU secs and program Elapsed secs are <strong>averages</strong> that approximate steady state performance.</p>

<p>Each program performs the same calculation 20 times, the measurements are made in the same way as all the other time measurements, but before display they are divided by 20 to give averages that minimize the influence of mixed-mode method interpretation and <a href="http://www.ibm.com/developerworks/java/library/j-benchmark1.html#osr"><strong>on-stack-replacement</strong></a>.</p>

<p><a href="faq.php#dynamic"><strong>FAQ: What about Java dynamic compilation?</strong></a></p>

<pre>
$ java -server -XX:+PrintCompilation -XX:-PrintGC meteor_test 2098 10
  1       meteor_test$Board::badRegion (115 bytes)
  2       meteor_test$Board::calcBadIslands (225 bytes)
  3       meteor_test::getMask (4 bytes)
  4       meteor_test::markBad (39 bytes)
  1%      meteor_test$Board::calcAlwaysBad @ 29 (151 bytes)
  5       meteor_test$Board::genAllSolutions (211 bytes)
  6       meteor_test$Board::hasBadIslands (174 bytes)
  7       meteor_test::getFirstOne (79 bytes)
  8       meteor_test$Soln::pushPiece (39 bytes)
  9       meteor_test$Soln::popPiece (16 bytes)
 10       meteor_test$Soln::setCells (124 bytes)
 11       meteor_test$Soln::spin (85 bytes)
 12       java.lang.Object::<init> (1 bytes)
 13       meteor_test$Soln::init (29 bytes)
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.275
 14       meteor_test$Piece::setCoordList (63 bytes)
 15       meteor_test$Piece::setOkPos (137 bytes)
 16       meteor_test$Board::calcAlwaysBad (151 bytes)
 17       meteor_test$Soln::lessThan (125 bytes)
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.134
 18       meteor_test$Piece::genAllOrientations (216 bytes)
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.129
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.127
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.125
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.131
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.125
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.128
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.125
 19       meteor_test$IslandInfo::<init> (32 bytes)
 20       meteor_test$Soln::<init> (39 bytes)
 21       meteor_test$Board::recordSolution (124 bytes)
 22       meteor_test$Soln::isEmpty (13 bytes)
2098 solutions found

0 0 0 0 1 
 2 2 2 0 1 
2 6 6 1 1 
 2 6 1 5 5 
8 6 5 5 5 
 8 6 3 3 3 
4 8 8 9 3 
 4 4 8 9 3 
4 7 4 7 9 
 7 7 7 9 9 

9 9 9 9 8 
 9 6 6 8 5 
6 6 8 8 5 
 6 8 2 5 5 
7 7 7 2 5 
 7 4 7 2 0 
1 4 2 2 0 
 1 4 4 0 3 
1 4 0 0 3 
 1 1 3 3 3 

0.125
</pre>
