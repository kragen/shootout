#!/bin/bash

# Split the file named $1 into multiple files at any line marked
#    SPLITFILE=newfilename
# and then rename each file as the given newfilename

# exit code 0 if the file named $1 was split
# exit code 1 if the file named $1 was not split

# Isaac Gouy 30 May 2005


csplit &>/dev/null -f tmp $1 '%SPLITFILE%' '{1}' '/SPLITFILE/' '{*}'

if [ -f ${PWD}/tmp00 ]; then
   # $1 was split

   for each in $(ls ${PWD}/tmp*)
   do
      line=$(sed -n '/SPLITFILE/p' $each)
      suffix=${line##*SPLITFILE=}
      name=${suffix%% *}
      echo "splitfile " $name
      mv -f $each ${PWD}/$name
   done
   exit 0

else
   # $1 was not split

   exit 1
fi
