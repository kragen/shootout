# The Computer Language Benchmarks Game
# $Id: data.py,v 1.1 2008-07-27 06:55:07 igouy-guest Exp $


__author__ =  'Isaac Gouy'


class Record():

   _OK = 0
   _TIMEDOUT = -1
   _ERROR = -2
   # -3 .. -7 have other uses in the website PHP scripts
   _BADOUT = -10
   _MISSING = -11
   _EMPTY = -12


   def __init__(self,arg='_'):
      self.arg = arg
      self.gz = 0
      self.userSysTime = 0.0 
      self.maxMem = 0
      self.status = self._EMPTY 
      self.cpuLoad = '%' 
     

   def __str__(self):
      return '%s,%d,%d,%.3f,%d,%s' % (
         self.arg, self.gz, self.userSysTime, self.maxMem, self.status, self.cpuLoad)

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

