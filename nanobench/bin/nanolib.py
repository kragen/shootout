# The Computer Language Benchmarks Game
# $Id: nanolib.py,v 1.1 2008-07-28 22:01:58 igouy-guest Exp $




__author__ =  'Isaac Gouy'


import logging
from logging.handlers import RotatingFileHandler
from os.path import join

# globals
logger = None



def configureLogger(loggerDir,logfilemax):
   global logger
   # if a logfilemax size was set, log line-by-line to a rotating log file
   # (as well as logging program-run by program-run to stdout)
   if logfilemax:
      f = join(loggerDir,'nano.log')
      h = RotatingFileHandler(filename=f,maxBytes=logfilemax,backupCount=1)

      fmt = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
      h.setFormatter(fmt)

      logger = logging.getLogger("nanobench")
      logger.addHandler(h)
      logger.setLevel(logging.DEBUG)
