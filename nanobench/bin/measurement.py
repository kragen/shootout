# The Computer Language Benchmarks Game
# $Id: measurement.py,v 1.1 2008-07-25 01:57:33 igouy-guest Exp $


__author__ =  'Isaac Gouy'


class Measurement():

   _OK = 0
   _ERROR = -1
   _TIMEDOUT = -2
   _BADOUT = -3
   _MISSING = -4

   def __init__(self,arg='_'):
      self.arg = arg
      self.status = self._MISSING
      self.userSysTime = 0.0 
      self.maxMem = 0
      self.cpuLoad = '%'   

   def __str__(self):
      return '%s,%d,%.3f,%d,%s' % (
         self.arg, self.status, self.userSysTime, self.maxMem, self.cpuLoad)

   def setOkay(self):
      self.status = self._OK

   def setError(self):
      self.status = self._ERROR

   def setTimedout(self):
      self.status = self._TIMEDOUT

   def setBadOutput(self):
      self.status = self._BADOUT

   def isOkay(self):
      return self.status == self._OK

   def hasError(self):
      return self.status == self._ERROR

   def hasTimedout(self):
      return self.status == self._TIMEDOUT

   def hasBadOutput(self):
      return self.status == self._BADOUT

   def isMissing(self):
      return self.status == self._MISSING

   def hasExceeded(self,cutoff):
      return self.userSysTime > cutoff

   def statusStr(self):
      return 'OK ' if self.isOkay() else (
         'ERROR ' if self.hasError() else (
         'TIMEDOUT ' if self.hasTimedout() else (
         'UNEXPECTED OUTPUT ' if self.hasBadOutput() else 
         'MISSING ' )))

