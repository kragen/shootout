# The Computer Language Benchmarks Game
# $Id: nanolib.py,v 1.3 2008-07-30 18:57:16 igouy-guest Exp $




__author__ =  'Isaac Gouy'


import os,logging
from logging.handlers import RotatingFileHandler
from os.path import expanduser, expandvars, isdir, join, normpath

# globals
logger = None

logdirName = 'log'
datdirName = 'dat'
tmpdirName = 'tmp'
symdirName = 'sym'

datdir = None
rootdir = None
symdir = None
cwdir = None


# access variables after initialization
def getLogger(): return logger



def envPath(s):
   return normpath( expandvars( expanduser( os.environ.get(s, ''))))



def chCWD(subdir=None):
   global cwdir,rootdir
   if cwdir:
      os.chdir(cwdir)   
   else:
      cwdir = os.getcwd()

      rootdir = envPath('SITE_ROOT')
      if not isdir(rootdir):
         print 'please set SITE_ROOT in Makefile.site_*'
         sys.exit(0)   

      if subdir and not isdir(subdir): 
         os.mkdir(subdir) 

      os.chdir(subdir if subdir else rootdir)



def configureLogger(logfilemax,loggerDir=None):
   global logger
   # if a logfilemax size was set, log line-by-line to a rotating log file
   # (as well as logging program-run by program-run to stdout)

   if logfilemax:
      f = join(loggerDir,'nano.log') if loggerDir else join('nano.log')
      h = RotatingFileHandler(filename=f,maxBytes=logfilemax,backupCount=1)

      fmt = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
      h.setFormatter(fmt)

      logger = logging.getLogger("nanobench")
      logger.addHandler(h)
      logger.setLevel(logging.DEBUG)


