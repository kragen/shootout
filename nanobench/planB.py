# $Id: planB.py,v 1.2 2008-07-18 16:22:56 igouy-guest Exp $

"""
measure without libgtop2
"""
__author__ =  'Isaac Gouy'



def measure(arg,commandline,delay,maxTime):
   from subprocess import Popen
   import os, cPickle, time, thread, signal

   r,w = os.pipe()
   main = os.fork()

   if main: # read pickled measurements from the pipe
      os.close(w); rPipe = os.fdopen(r); r = cPickle.Unpickler(rPipe)
      measurements = r.load()
      rPipe.close()
      return measurements

   else: 
      global _maxMem, _timedout; _maxMem = 0; _timedout = False

      def sample(program):
         """sample thread will be destroyed when the forked process _exits,
            use globals to pass data from the thread to the forked process."""
         global _maxMem, _timedout

         remaining = maxTime
         while remaining > 0:


            time.sleep(delay)
            remaining = remaining - delay
         else:
            _timedout = True
            os.kill(program, signal.SIGTERM)
            #os.kill(program, signal.SIGKILL)


      # only write pickles to the pipe
      os.close(r); wPipe = os.fdopen(w, 'w'); w = cPickle.Pickler(wPipe)




      # spawn the program in a separate process
      p = Popen(commandline)

      # start a thread to sample the program's resident memory use
      thread.start_new_thread(sample,(p.pid,))

      # wait for program exit status and resource usage
      rusage = os.wait3(0)




      # summarize measurements 
      status = -2 if _timedout else rusage[1] if rusage[1] == os.EX_OK else -1
      utime_stime = rusage[2][0] + rusage[2][1]


 










      load = "%"

      w.dump( (arg, status, utime_stime, _maxMem, load) )
      wPipe.close()
      os._exit(0)

