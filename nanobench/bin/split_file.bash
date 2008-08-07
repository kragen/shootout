#!/bin/bash

# Split the file named $1 into multiple files at any line marked
#    SPLITFILE=newfilename
# and then rename each file as the given newfilename

# exit code 0 if the file named $1 was split
# exit code 1 if the file named $1 was not split

# Isaac Gouy 30 May 2005, 13 March 2008



if egrep -q 'SPLITFILE' $1 
then
   csplit &>/dev/null -f tmp $1 '/SPLITFILE/' '{*}'

   if [ -f ${PWD}/tmp01 ]; then
      # $1 was split

      # we only care about stuff after SPLITFILE marker
      rm -f ${PWD}/tmp00

      for each in $(ls ${PWD}/tmp*)
      do
         line=$(sed -n '/SPLITFILE/p' $each)                           
         suffix=${line##*SPLITFILE=}                  
         name=${suffix%% *}
         
         # if the name is a path ensure the directory exists
         dir=${name%/*}
         if [ $dir != $name ]; then         
            mkdir -p ${PWD}/$dir
         fi
         
         echo "splitfile " $name
         sed '/SPLITFILE/d' $each > ${PWD}/$name
         rm -f $each
      done
      exit 0
   else
      rm -f ${PWD}/tmp00
      exit 0
   fi

else
   # $1 didn't contain SPLITFILE

   exit 0
fi
