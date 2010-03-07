# The Computer Language Benchmarks Game
# $Id: planBwin32.py,v 1.3 2010-03-07 02:52:46 igouy-guest Exp $

"""
measure with win32 but not CPU affinity
"""
__author__ =  'Isaac Gouy'


try:
   from win32process import GetProcessTimes, GetProcessMemoryInfo
   from win32api import GetTickCount, GetSystemInfo
   from win32event import WaitForSingleObject
except ImportError, err:
   print 'please install Python Win32 Extensions'
   print 'see http://sourceforge.net/projects/pywin32/'
   sys.exit(0)
   
   
from domain import Record
from subprocess import Popen

# for QueryPerformanceCounter
from ctypes.wintypes import LARGE_INTEGER
from ctypes import windll
from ctypes import byref



def measure(arg,commandline,delay,maxtime,
      outFile=None,errFile=None,inFile=None,logger=None,affinitymask=None):

      m = Record(arg)



      # For elapsed time try QueryPerformanceCounter otherwise use GetTickCount
      freq = LARGE_INTEGER()
      isCounter = windll.kernel32.QueryPerformanceFrequency(byref(freq))
      if isCounter:
         t0 = LARGE_INTEGER()
         t = LARGE_INTEGER()
         windll.kernel32.QueryPerformanceCounter(byref(t0))
      else: # the number of milliseconds since windows started
         t0 = GetTickCount()



      try:
         # spawn the program in a separate process
         p = Popen(commandline,stdout=outFile,stderr=errFile,stdin=inFile)
         hProcess = int(p._handle)

         # wait for program exit status - time out in milliseconds
         waitexit = WaitForSingleObject(hProcess,maxtime*1000)



         # For elapsed time try QueryPerformanceCounter otherwise use GetTickCount
         if isCounter:
            windll.kernel32.QueryPerformanceCounter(byref(t))
            m.elapsed = (t.value - t0.value) / float(freq.value)
         else: # the number of milliseconds since windows started
            t = GetTickCount()
            m.elapsed = (t - t0) / 1000.0



         if waitexit != 0:
            p.terminate()
            m.setTimedout()
         elif p.poll() == 0:
            m.setOkay()

            times = GetProcessTimes(hProcess)
            # ten million - the number of 100-nanosecond units in one second
            m.userSysTime = (times['UserTime'] + times['KernelTime'])/10000000.0

            # seems to correspond to Peak Mem Usage K in Task Manager
            mem = GetProcessMemoryInfo(hProcess)
            m.maxMem = mem['PeakWorkingSetSize'] / 1024

            m.cpuLoad = "%"

         elif p.poll() == 2:
            m.setMissing()
         else:
            m.setError()



      except (OSError,ValueError), (e,err):
         if logger: logger.error('%s %s',e,err)
         m.setError()

      finally:
         return m