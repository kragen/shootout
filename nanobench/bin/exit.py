# The Computer Language Benchmarks Game
# $Id: exit.py,v 1.2 2008-07-24 19:27:24 igouy-guest Exp $

"""
exit status constants
"""
__author__ =  'Isaac Gouy'

OK = 0
ERROR = -1
TIMEOUT = -2
BADOUT = -3
MISSING = -4

def isOk(m):
   return m[1] == OK

def isError(m):
   return m[1] == ERROR

def isTimeout(m):
   return m[1] == TIMEOUT

def isBadout(m):
   return m[1] == BADOUT

def isMissing(m):
   return m[1] == MISSING




