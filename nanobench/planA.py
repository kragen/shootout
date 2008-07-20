# $Id: planA.py,v 1.5 2008-07-20 18:41:47 igouy-guest Exp $

"""
measure with libgtop2
"""
__author__ =  'Isaac Gouy'



def measure(arg,commandline,delay,maxtime,outFile=None,errFile=None):

   from subprocess import Popen, STDOUT
   import os, cPickle, time, thread, signal, gtop

   r,w = os.pipe()
   main = os.fork()

   if main: # read pickled measurements from the pipe
      os.close(w); rPipe = os.fdopen(r); r = cPickle.Unpickler(rPipe)
      measurements = r.load()
      rPipe.close()
      return measurements

   else: 
      # use a child process to make sure the sample thread is 
      # destroyed - which will happen when the child process _exits
      global _maxMem, _timedout; _maxMem = 0; _timedout = False

      def sample(program):         
         # use globals to pass data from the thread to the forked process
         global _maxMem, _timedout

         remaining = maxtime
         while remaining > 0:
            mem = gtop.proc_mem( program ).resident
            _maxMem = max(mem/1024, _maxMem)
            time.sleep(delay)
            remaining = remaining - delay
         else:
            _timedout = True
            os.kill(program, signal.SIGTERM)
            #os.kill(program, signal.SIGKILL)


      # only write pickles to the pipe
      os.close(r); wPipe = os.fdopen(w, 'w'); w = cPickle.Pickler(wPipe)

      # gtop cpu is since machine boot, so we need a before measurement
      cpus0 = gtop.cpu().cpus 

      try:
         # spawn the program in a separate process
         p = Popen(commandline,stdout=outFile,stderr=errFile)

         # start a thread to sample the program's resident memory use
         thread.start_new_thread(sample,(p.pid,))

         # wait for program exit status and resource usage
         rusage = os.wait3(0)

      except (OSError,ValueError), (_,e):
         status = -1; utime_stime = 0; load = "%"
         print e, commandline

      else:
         # gtop cpu is since machine boot, so we need an after measurement
         cpus1 = gtop.cpu().cpus 

         # summarize measurements 
         status = -2 if _timedout else rusage[1] if rusage[1] == os.EX_OK else -1
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
         w.dump( (arg, status, utime_stime, _maxMem, load) )
         wPipe.close()

      os._exit(0)

