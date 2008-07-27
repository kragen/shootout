# The Computer Language Benchmarks Game
# $Id: domain.py,v 1.1 2008-07-27 17:22:10 igouy-guest Exp $


__author__ =  'Isaac Gouy'


class FileNameParts():
   """ 
   self.filename = 'binarytrees.gcc' | self.filename = 'binarytrees.gcc-4.gcc'
   self.name = 'binarytrees' | self.name = 'binarytrees'
   self.ext = 'gcc' | self.ext = 'gcc'
   self.extid = None | self.extid = 'gcc-4'
   self.id = None | self.id = '4'
   """
   def __init__(self,filename):
      self.filename = filename

      ps = filename.split('.')
      self.name = ps[0]

      a,_,b = ps[1].rpartition('-') 
      if a:
         self.ext = ps[2]
         self.extid = ps[1]
         self.id = b
      else:
         self.ext = b
         self.extid = None
         self.id = None

   def isNumbered(self):
      return self.id != None

   def __str__(self):
      return '%s,%s,%s' % (self.name, self.ext, self.id)



class LinkNameParts(FileNameParts):
   """ 
   self.filename = 'binarytrees.gcc' | self.filename = 'binarytrees.gcc-4.gcc'
   newExt = 'icc'
   self.linkname = 'binarytrees.icc' | self.linkname = 'binarytrees.icc-4.icc'
   """
   def __init__(self,fp,newext):
      self.filename = fp.filename
      self.name = fp.name
      self.ext = fp.ext
      self.extid = fp.extid
      self.id = fp.id
      self.newext = newext
      self.linkname = \
         '.'.join( (self.name, '-'.join( (newext,self.id) ), newext) ) \
            if self.isNumbered() else '.'.join( (self.name,newext) )

   def __str__(self):
      return '%s,%s,%s,%s' % (self.name, self.ext, self.id, self.linkname)



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
      return '%s,%d,%.3f,%d,%d,%s' % (
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

