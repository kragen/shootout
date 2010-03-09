# The Computer Language Benchmarks Game
# $Id: uselinux.py,v 1.3 2010-03-09 01:49:29 igouy-guest Exp $

try:
   import gtop
except ImportError, err:
   planDesc = 'gtop import failed - measure cpu & elapsed time'
   from planC import measure
else:
   try:
      import affinity
   except ImportError, err:
      from planB import measure
      #planDesc = 'affinity import failed - use all cores'
      planDesc = 'measure cpu & elapsed time & memory & cpu load'
   else:
      from planA import measure
      planDesc = 'measure cpu & elapsed time & memory & cpu load'


# =============================
# global variables
# =============================



nullName = '/dev/null'



# =============================
# initialize & configure
# =============================

import os
from errno import EEXIST
from os.path import join



def linkToSource(directory,filename,dstDir=None,srcFilename=None):
   # beware - read carefully
   src = join(directory,filename) \
      if srcFilename == None else join(directory,srcFilename)

   # tmpdir is $CWD
   dst = join(filename) if dstDir == None else join(dstDir,filename)

   try:
      os.symlink(src,dst)
   except OSError, (e,_):
      if e == EEXIST: pass # OK the symlink already exists - or should it be removed?


def linkToIncludeDir(directory,filename,dstDir=None,srcFilename=None):
   linkToSource(directory,filename)

   
