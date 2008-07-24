# $Id: exit.py,v 1.1 2008-07-24 05:41:27 igouy-guest Exp $

"""
exit status constants
"""
__author__ =  'Isaac Gouy'

OK = 0
ERROR = -1
TIMEOUT = -2
BADOUT = -3
FAIL = -4

def isOk(m):
   return m[1] == OK

def isError(m):
   return m[1] == ERROR

def isTimeout(m):
   return m[1] == TIMEOUT

def isBadout(m):
   return m[1] == BADOUT

def isFailure(m):
   return m[1] == FAIL




