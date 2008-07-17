# $Id: planB.py,v 1.1 2008-07-17 06:18:41 igouy-guest Exp $

"""
measure without libgtop2
"""
__author__ =  'Isaac Gouy'


from subprocess import Popen
import os, time, thread, signal

_timedout = False

def measure(commandline,sampleTime,maxTime):
   global _maxMem, _timedout

   def sampleOrTimeout(p,t,timeRemaining):
      global _maxMem, _timedout
      while timeRemaining > 0:
         if p.poll(): break # if program exited exit
   
         timeRemaining = timeRemaining - t
         time.sleep(t)
      else:
         _timedout = True
         os.kill(p.pid,signal.SIGTERM)
         if not p.poll():
            os.kill(p.pid,signal.SIGKILL)   
            p.poll()





   try:
      # spawn the program in a child process
      p = Popen(commandline)

      # start a thread to sample the program's resident memory use
      thread.start_new_thread(sampleOrTimeout,(p,sampleTime,maxTime))

      # wait for program exit status and resource usage
      rusage = os.wait3(0)


      # summarize measurements 
      status = -2 if _timedout else rusage[1] if rusage[1] == os.EX_OK else -1
      utime_stime = rusage[2][0] + rusage[2][1]


   except OSError, (err,detail): 
      print "OSError(%s): %s" % (err,detail)
      status = -1; utime_stime = -1.0

   return (status, utime_stime, -1, "%")






