#!/bin/bash
# Isaac Gouy 20 March 2006
# directory locations relative to /shootout
#
d=website/code/
db=./bench/
dbin=./bin

for each in $(ls $d*code)
do
   echo "testing $each"
   prefix=${each%.code}
   name=${prefix##$d} 
# 
   prog=${name#*-}
   lang=${prog%%-*}
   id=${prog##*-}   
   test=${name%%-*}
#
   if [ $prog != $id ]; then
      p2=$prog.$lang
   else
      p2=$prog
   fi
#
   gzbytes=$(php $dbin/gzsize.php < $each)
   echo $prog $gzbytes > $db$test/tmp/$test.${p2}.gzc
done

for each in $(ls $db)
do
   if [ -d $db$each/tmp ]; then
      rm -f $db$each/data/gzc.tab
      for g in $(ls $db$each/tmp/*.gzc)
      do
         a=$(cut -f1 -d' ' $g)
         b=$(cut -f2 -d' ' $g)
         echo $a $b >> $db$each/data/gzc.tab
      done
   fi
done
