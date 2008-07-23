# $Id: planA.py,v 1.9 2008-07-23 02:47:24 igouy-guest Exp $

"""
measure with libgtop2
"""
__author__ =  'Isaac Gouy'

import exit


def measure(arg,commandline,delay,maxtime,outFile=None,errFile=None,inFile=None):

   from subprocess import Popen
   import os, cPickle, time, threading, signal, gtop

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
               mem = gtop.proc_mem(self.p).resident
               self.maxMem = max(mem/1024, self.maxMem)
               time.sleep(delay)
               remaining -= delay
            else:
               self.timedout = True
               os.kill(self.p, signal.SIGTERM)
               #os.kill(self.p, signal.SIGKILL)            


      # only write pickles to the pipe
      os.close(r); wPipe = os.fdopen(w, 'w'); w = cPickle.Pickler(wPipe)

      # gtop cpu is since machine boot, so we need a before measurement
      cpus0 = gtop.cpu().cpus 

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
         # gtop cpu is since machine boot, so we need an after measurement
         cpus1 = gtop.cpu().cpus 

         # summarize measurements 
         status = exit.TIMEOUT if t.timedout else rusage[1] \
            if rusage[1] == os.EX_OK else exit.ERROR
         utime_stime = rusage[2][0] + rusage[2][1]

         try:
            load = map( 
               lambda t0,t1: 
                  int(round( 
                     100.0 * (1.0 - float(t1.idle-t0.idle)/(t1.total-t0.total))
                  ))
               ,cpus0 ,cpus1 )

            load.sort(reverse=1)
            load = ("% ".join([str(i) for i in load]))+"%"

         except ZeroDivisionError: # too fast
            load = "%"
   
      finally:
         w.dump( (arg, status, utime_stime, t.maxMem, load) )
         wPipe.close()

      # Sample thread will be destroyed when the forked process _exits
      os._exit(0)

