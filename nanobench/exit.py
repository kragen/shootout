# $Id: exit.py,v 1.1 2008-07-21 06:17:38 igouy-guest Exp $

"""
exit status constants
"""
__author__ =  'Isaac Gouy'

OK = 0
ERROR = -1
TIMEOUT = -2
BADOUT = -3


def status(m):
   return m[1]




