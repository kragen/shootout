# The Computer Language Benchmarks Game
# $Id: planBwin32.py,v 1.6 2010-03-10 22:32:21 igouy-guest Exp $

"""
measure with win32 but not CPU affinity
"""
__author__ =  'Isaac Gouy'


from domain import Record

try:
   #from win32process import GetProcessMemoryInfo
   from win32api import GetTickCount
   from win32event import WaitForSingleObject
   from win32job import CreateJobObject, AssignProcessToJobObject, \
      QueryInformationJobObject, JobObjectBasicAccountingInformation, \
      TerminateJobObject, JobObjectExtendedLimitInformation
except ImportError, err:
   print 'please install Python Win32 Extensions'
   print 'see http://sourceforge.net/projects/pywin32/'
   sys.exit(0)

from subprocess import Popen

# for QueryPerformanceCounter elapsed time measurement
from ctypes.wintypes import LARGE_INTEGER, FILETIME
from ctypes import windll
from ctypes import byref


#ten million - the number of 100-nanosecond units in one second
nanosecs100 = 10000000.0


def taskManagerCpuTimes():
   idle = FILETIME(); sys = FILETIME(); usr = FILETIME()
   i = 0.0; s = 0.0; u = 0.0
   if windll.kernel32.GetSystemTimes(byref(idle),byref(sys),byref(usr)):
      i = (idle.dwHighDateTime<<32 | idle.dwLowDateTime) / nanosecs100
      s = (sys.dwHighDateTime<<32 | sys.dwLowDateTime) / nanosecs100
      u = (usr.dwHighDateTime<<32 | usr.dwLowDateTime) / nanosecs100
   return (i,s,u)
   
def taskManagerCpuLoad(before,after,totalusr):
   idle = after[0] - before[0]
   kernel = after[1] - before[1]
   usr = after[2] - before[2]
   # Ignore kernel times for an approximate indication of
   # % CPU usage similar to what's shown by Task Manager
   return str( int( 100.0 * totalusr/(idle+usr) )) + '%'




def measure(arg,commandline,delay,maxtime,
      outFile=None,errFile=None,inFile=None,logger=None,affinitymask=None):

      m = Record(arg)

      # For % CPU usage
      cpu0 = taskManagerCpuTimes()

      ### Use a JobObject so we capture data for child processes as well
      hJob = CreateJobObject(None,'proctree')

      # For elapsed time try QueryPerformanceCounter otherwise use GetTickCount
      freq = LARGE_INTEGER()
      isCounter = windll.kernel32.QueryPerformanceFrequency(byref(freq))
      if isCounter:
         t0 = LARGE_INTEGER(); t = LARGE_INTEGER()
         windll.kernel32.QueryPerformanceCounter(byref(t0))
      else: # the number of milliseconds since windows started
         t0 = GetTickCount()



      try:
         # spawn the program in a separate process
         p = Popen(commandline,stdout=outFile,stderr=errFile,stdin=inFile)
         hProcess = int(p._handle)
         AssignProcessToJobObject(hJob,hProcess)

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
            # terminate any child processes as well
            TerminateJobObject(hJob,-1)
            m.setTimedout()
         elif p.poll() == 0:
            m.setOkay()


            ### Use a JobObject so we capture data for child processes as well
            times = QueryInformationJobObject(hJob,JobObjectBasicAccountingInformation)
            #ten million - the number of 100-nanosecond units in one second
            totalusr = times['TotalUserTime'] / nanosecs100
            totalsys = times['TotalKernelTime'] / nanosecs100
            m.userSysTime = totalusr + totalsys


            ### "VM Size" seems the more appropriate measure
            ###
            # corresponds to Peak Mem Usage in Task Manager
            # mem = GetProcessMemoryInfo(hProcess)
            # m.maxMem = mem['PeakWorkingSetSize'] / 1024

            # corresponds to VM Size in Task Manager
            mem = QueryInformationJobObject(hJob,JobObjectExtendedLimitInformation)
            m.maxMem = mem['PeakJobMemoryUsed'] / 1024


            m.cpuLoad = taskManagerCpuLoad(cpu0, taskManagerCpuTimes(), totalusr)

         elif p.poll() == 2:
            m.setMissing()
         else:
            m.setError()



      except (OSError,ValueError), (e,err):
         if logger: logger.error('%s %s',e,err)
         m.setError()

      finally:
         hJob.Close()
         return m