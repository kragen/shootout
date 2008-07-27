# The Computer Language Benchmarks Game
# $Id: measurement.py,v 1.4 2008-07-27 00:05:48 igouy-guest Exp $


__author__ =  'Isaac Gouy'


class Measurement():

   _OK = 0
   _ERROR = -1
   _EMPTY = -2
   _MISSING = -3
   _TIMEDOUT = -4
   _BADOUT = -5


   def __init__(self,arg='_'):
      self.arg = arg
      self.status = self._EMPTY
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

   def setMissing(self):
      self.status = self._MISSING

   def isOkay(self):
      return self.status == self._OK

   def hasError(self):
      return self.status == self._ERROR

   def isEmpty(self):
      return self.status == self._EMPTY

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
         'EMPTY ' if self.isEmpty() else (
         'TIMED OUT ' if self.hasTimedout() else (
         'UNEXPECTED OUTPUT ' if self.hasBadOutput() else 
         'MISSING FILE ' ))))

