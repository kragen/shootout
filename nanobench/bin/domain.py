# The Computer Language Benchmarks Game
# $Id: domain.py,v 1.5 2008-07-30 01:50:03 igouy-guest Exp $


__author__ =  'Isaac Gouy'


class FileNameParts(object):
   """ 
   self.filename = 'binarytrees.gcc' | self.filename = 'binarytrees.gcc-4.gcc'
   self.name = 'binarytrees' | self.name = 'binarytrees'
   self.ext = 'gcc' | self.ext = 'gcc'
   self.id = None | self.id = '4'
   self.extid = None | self.extid = 'gcc-4'
   self.programName = 'binarytrees.gcc' | self.programName = 'binarytrees.gcc-4.gcc'
   """
   def __init__(self,filename):
      self.filename = filename
      part = filename.split('.')
      self.name = part[0]
      self._lazy_extid = None

      a,_,b = part[1].rpartition('-') 
      if a:
         self.ext = part[2]
         self.id = b
      else:
         self.ext = b
         self.id = ''


   def _extid(self):
      if self._lazy_extid == None: # not initialized rather than initialized to ''
         self._lazy_extid = '-'.join((self.ext, self.id)) if self.isNumbered() else ''
      return self._lazy_extid 

   extid = property(_extid)


   def _programName(self):
      return self.filename

   def _programName_getter(self):
      return self._programName()

   programName = property(_programName_getter)


   def _datName(self):
      return self.programName + '.dat'

   datName = property(_datName)


   def _baseName(self):
      return '.'.join( (self.name, self.extid) ) if self.extid else self.name

   baseName = property(_baseName)


   def _runName(self):
      return self.programName + '_run'

   runName = property(_runName)


   def _logName(self):
      return self.programName + '.log'

   logName = property(_logName)


   def __str__(self):
      return '%s,%s,%s' % (self.name, self.ext, self.id)

   def isNumbered(self):
      return len(self.id) > 0




class LinkNameParts(FileNameParts):
   """ 
   self.filename = 'binarytrees.gcc' | self.filename = 'binarytrees.gcc-4.gcc'
   ext = 'icc'
   self.programName = 'binarytrees.icc' | self.linkname = 'binarytrees.icc-4.icc'
   """
   def __init__(self,filename,ext): 
      FileNameParts.__init__(self,filename)  
      self._lazy_programName = None
      self.ext = ext

   def _programName(self):
      if self._lazy_programName == None: # not initialized rather than initialized to '' 
         self._lazy_programName = \
         '.'.join( (self.name, '-'.join( (self.ext,self.id) ), self.ext) ) \
            if self.isNumbered() else '.'.join( (self.name,self.ext) ) 

      return self._lazy_programName 


   def __str__(self):
      return '%s,%s,%s,%s' % (self.name, self.ext, self.id, self.filename)




class Record(object):

   _OK = 0
   _TIMEDOUT = -1
   _ERROR = -2
   # -3 .. -7 have other uses in the website PHP scripts
   _BADOUT = -10
   _MISSING = -11
   _EMPTY = -12


   def __init__(self,arg='0'):
      self.setEmpty()
      self.argString = arg

   def fromString(self,s):
      a = s.split(',')
      self.arg = int(a[0])
      self.gz = int(a[1])
      self.userSysTime = float(a[2])
      self.maxMem = int(a[3])
      self.status = int(a[4]) 
      self.cpuLoad = a[5]
      return self

   def __str__(self):
      return '%d,%d,%.3f,%d,%d,%s' % (
         self.arg, self.gz, self.userSysTime, self.maxMem, self.status, self.cpuLoad)

   def __cmp__(self,other):
      return \
        -1 if self.arg < other.arg else (
         1 if self.arg > other.arg else (
        -1 if self.status > other.status else (
         1 if self.status < other.status else (
        -1 if self.userSysTime < other.userSysTime else (
         1 if self.userSysTime > other.userSysTime else (
         0 )) )) ))

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

   def setEmpty(self):
      self.arg = 0
      self.gz = 0
      self.userSysTime = 0.0 
      self.maxMem = 0
      self.status = self._EMPTY 
      self.cpuLoad = '%' 

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

   def _getArgString(self):
      return str(self.arg)

   def _setArgString(self,arg):
      self.arg = int(arg)

   argString = property(_getArgString,_setArgString)

