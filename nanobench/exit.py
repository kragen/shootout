# $Id: exit.py,v 1.2 2008-07-21 19:46:37 igouy-guest Exp $

"""
exit status constants
"""
__author__ =  'Isaac Gouy'

OK = 0
ERROR = -1
TIMEOUT = -2
BADOUT = -3

def isOk(m):
   return m[1] == OK

def isError(m):
   return m[1] == ERROR

def isTimeout(m):
   return m[1] == TIMEOUT

def isBadout(m):
   return m[1] == BADOUT




