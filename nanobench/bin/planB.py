# $Id: planB.py,v 1.1 2008-07-24 05:41:27 igouy-guest Exp $

"""
measure without libgtop2
"""
__author__ =  'Isaac Gouy'

import exit


def measure(arg,commandline,delay,maxtime,outFile=None,errFile=None,inFile=None):

   from subprocess import Popen
   import os, cPickle, time, threading, signal

   r,w = os.pipe()
   forkedPid = os.fork()

   if forkedPid: # read pickled measurements from the pipe
      os.close(w); rPipe = os.fdopen(r); r = cPickle.Unpickler(rPipe)
      measurements = r.load()
      rPipe.close()
      os.waitpid(forkedPid,0)
      return measurements

   else: 
      # Sample thread will be destroyed when the forked process _exits
      class Sample(threading.Thread):
         def __init__(self,program):
            threading.Thread.__init__(self)
            self.setDaemon(1)
            self.p = program
            self.maxMem = 0
            self.timedout = False     
            self.start()      
         def run(self):
            remaining = maxtime
            while remaining > 0:


               time.sleep(delay)
               remaining -= delay
            else:
               self.timedout = True
               os.kill(self.p, signal.SIGTERM)
               #os.kill(self.p, signal.SIGKILL)            


      # only write pickles to the pipe
      os.close(r); wPipe = os.fdopen(w, 'w'); w = cPickle.Pickler(wPipe)




      try:
         # spawn the program in a separate process
         p = Popen(commandline,stdout=outFile,stderr=errFile,stdin=inFile)

         # start a thread to sample the program's resident memory use
         t = Sample( program = p.pid )

         # wait for program exit status and resource usage
         rusage = os.wait3(0)

      except (OSError,ValueError), (_,e):
         status = exit.ERROR; utime_stime = 0; load = "%"
         print e, commandline

      else:



         # summarize measurements 
         status = exit.TIMEOUT if t.timedout else rusage[1] \
            if rusage[1] == os.EX_OK else exit.ERROR
         utime_stime = rusage[2][0] + rusage[2][1]














   
      finally:
         w.dump( (arg, status, utime_stime, t.maxMem, '%') )
         wPipe.close()

      # Sample thread will be destroyed when the forked process _exits
      os._exit(0)

