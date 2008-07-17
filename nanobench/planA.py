# $Id: planA.py,v 1.1 2008-07-17 06:18:41 igouy-guest Exp $

"""
measure with libgtop2
"""
__author__ =  'Isaac Gouy'


from subprocess import Popen
import os, time, thread, signal, gtop

_timedout = False; _maxMem = -1

def measure(commandline,sampleDelay,maxTime):
   global _maxMem, _timedout

   def sampleOrTimeout(p,t,timeRemaining):
      global _maxMem, _timedout
      while timeRemaining > 0:
         if p.poll(): break # if program exited exit

         mem = gtop.proc_mem(p.pid).resident 
         _maxMem = max(mem/1024, _maxMem) 
   
         timeRemaining = timeRemaining - t
         time.sleep(t)
      else:
         _timedout = True
         os.kill(p.pid,signal.SIGTERM)
         if not p.poll():
            os.kill(p.pid,signal.SIGKILL)   
            p.poll()


   try:
      # gtop cpu is since machine boot, so we need a before measurement
      cpus0 = gtop.cpu().cpus 

      # spawn the program in a child process
      p = Popen(commandline)

      # start a thread to sample the program's resident memory use
      thread.start_new_thread(sampleOrTimeout,(p,sampleTime,maxTime))

      # wait for program exit status and resource usage
      rusage = os.wait3(0)

      # gtop cpu is since machine bootrusage[1], so we need an after measurement
      cpus1 = gtop.cpu().cpus 


      # summarize measurements 
      status = -2 if _timedout else rusage[1] if rusage[1] == os.EX_OK else -1
      utime_stime = rusage[2][0] + rusage[2][1]

      load = map( 
         lambda t0,t1: 
            int(round( 
               ((t1.sys-t0.sys)+(t1.user-t0.user))*100.0/(t1.total-t0.total) 
            ))
         ,cpus0 ,cpus1 )

      load.sort(reverse=1)
      load = ("% ".join([str(i) for i in load]))+"%"

   except OSError, (err,detail): 
      print "OSError(%s): %s" % (err,detail)
      status = -1; utime_stime = -1.0; load = "%" 

   return (status, utime_stime, _maxMem, load)






