#!/bin/bash
# Isaac Gouy 29 May 2005, 13 June 2005
# directory locations relative to /shootout

echo "##########################"
echo "STARTING CASCADING DELETE"
echo "##########################"

d=website/code/
ds=bench/

# Some implementations share source code
# Intel C uses the same source file as gcc, etc
# We'll use 2 parallel arrays to represent the map
#
# Synchronize with /shootout/bin/make_links

declare -a alias
declare -a key

alias[0]=sbcl
key[0]=cmucl

alias[1]=gcl
key[1]=cmucl

alias[2]=hipe
key[2]=erlang

alias[3]=nhc98
key[3]=ghc

alias[4]=hugs
key[4]=ghc

alias[5]=icc
key[5]=gcc

alias[6]=icpp
key[6]=gpp

alias[7]=g95
key[7]=ifc

alias[8]=kaffe
key[8]=java

alias[9]=gcj
key[9]=java

alias[10]=gij
key[10]=java

alias[11]=sablevm
key[11]=java

alias[12]=mzc
key[12]=mzscheme

alias[13]=ocamlb
key[13]=ocaml


### remove .log and .code with no source file    

for each in $(ls $d*log)
do
   prefix=${each%.log}
   name=${prefix##$d} 
 
   prog=${name#*-}
   lang=${prog%%-*}
   id=${prog##*-}   
   test=${name%%-*}

   if [ $prog != $id ]; then
      source=$test.$prog.$lang
      p1=$prog
      p2=$prog.$lang
   else
      source=$test.$lang
      p1=$prog
      p2=$prog
   fi


   if [ ! -f $ds$test/$source ]; then

      # check for an alias 

      source2=""
      lang2=$lang   
         
      let i=0
      let n=${#alias[*]}
      while [ $i -lt $n ]; do

         if [ $lang = ${alias[$i]} ]; then
            lang2=${key[$i]}
            
            if [ $prog != $id ]; then
               source2=$test.$lang2-$id.$lang2
            else
               source2=$test.$lang2
            fi            
         fi
         let i=i+1
      done        

      if [ -z "$source2" ] || [ ! -f $ds$test/$source2 ]; then      
         # remove .log file
         rm $each
         cvs rm $each
         echo "cascade delete "$each

         # remove .code file
         if [ -f ${prefix}.code ]; then 
            rm ${prefix}.code
            cvs rm ${prefix}.code
            echo "cascade delete "${prefix}.code
         fi
         

         # remove tmp files
         rm -f $ds$test/tmp/${p1}_*
         echo "cascade delete $ds$test/tmp/${p1}_*"

         rm -f $ds$test/tmp/$test.${p2}_*
         echo "cascade delete $ds$test/tmp/$test.${p2}_*"

         rm -f $ds$test/tmp/$test.${p2}.*
         echo "cascade delete $ds$test/tmp/$test.${p2}.*"


         # remove data directory files
         rm -f $ds$test/data/*${lang2}-${id}*
         echo "cascade delete $ds$test/data/*${lang2}-${id}*"        
      fi
   fi
done
