#!/bin/bash
# Isaac Gouy 30 June 2005


if [ ${PWD}/reset -nt ${PWD}/tmp ]; then
   rm -f -R  ${PWD}/tmp
fi 
