# The Computer Language Benchmarks Game
# $Id: usewin32.py,v 1.4 2010-03-10 22:32:21 igouy-guest Exp $

from planBwin32 import measure
planDesc = 'measure cpu & elapsed time & memory & cpu load'



# =============================
# global variables
# =============================



nullName = 'nul'



# =============================
# initialize & configure
# =============================

import os
from errno import EEXIST
from os.path import join
from shutil import copyfile


def linkToSource(directory,filename,dstDir=None,srcFilename=None):
   # beware - read carefully
   src = join(directory,filename) \
      if srcFilename == None else join(directory,srcFilename)

   # tmpdir is $CWD
   dst = join(filename) if dstDir == None else join(dstDir,filename)

   try:
      copyfile(src,dst) ### COPY INSTEAD OF SYMLINK
   except OSError, (e,_):
      if e == EEXIST: pass # OK the file already exists - or should it be removed?


def linkToIncludeDir(directory,filename,dstDir=None,srcFilename=None):
   pass
   # just specificy the absolute paths for include files
   # on the program command line


