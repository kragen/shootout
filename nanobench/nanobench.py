#!/usr/bin/python

# $Id: nanobench.py,v 1.4 2008-07-18 06:48:09 igouy-guest Exp $

"""
nanobench gathers cpu time measurements, samples resident memory usage, and
averages cpu load for the benchmarks game - it is not a standalone program.

nanobench is intended to be a simplified replacement for minibench.
"""
__author__ =  'Isaac Gouy'



# globals
make = frozenset()
commandlines = {}
run = { 'maxtime': 120, 'repeat': 5, 'sampledelay': 0.2 }
testvalues = []



def initialize():
   global make
   config_file = 'nanobench.conf'

   from sys import argv, exit
   from getopt import getopt, GetoptError

   try:
      options,_ = getopt(argv[1:],'',['conf=','range='])

      for o, v in options:
         if o in ('--conf'):
            config_file = v
         elif o in ('--range'):
            testvalues.extend( v.split(',') )

   except GetoptError, ex:
      print str(ex)
      exit(2)

   # need to use ConfigParser not SafeConfigParser
   from ConfigParser import ConfigParser, NoSectionError, NoOptionError

   try:
      parser = ConfigParser()
      parser.read(config_file)

      make = frozenset( parser.get("build", "make").split() )
      commandlines.update( parser.items("commandlines") )

      for k,v in parser.items("run"): # type conversions as appropriate
         try: x = int(v)
         except ValueError:
            try: x = float(v)
            except ValueError: x = v
         run[k] = x

   except (NoSectionError,NoOptionError), ex:
      print str(ex)
      exit(2)



def targetPrograms(path):
   """Assume dat file is only written once all data is available."""
   from os import listdir, mkdir
   from os.path import join, isdir, getmtime
   from fnmatch import filter

   # undeleted filenames that might have a file extension
   files = filter( listdir(path), '*.*[!~]' )

   programs = set()
   datdir = join(path,'dat')
   if isdir(datdir):
      for f in files:
         try:
            if getmtime(f) > getmtime( join(datdir,f) ):
               programs.add(f)
         except OSError: # assume - No such file or directory
               programs.add(f)
   else:
      mkdir(datdir)      
      programs = frozenset(files)

   return frozenset(programs)



def cmdTemplate(filename,ext):
   vars = {}
   vars['%X'] = filename + '_run' if ext in make else filename
   vars['%T'] = filename.split('.').pop(0) # We only selected filenames with a .

   s = commandlines[ext]

   from os import environ
   from re import finditer, sub

   for m in finditer('\$[\w]+' ,s):
      value = environ.get( m.group(0).lstrip('$'), '' )
      s = sub('\\'+ m.group(0)+'[\W]', value+' ', s) # eaten the trailing space?

   for m in finditer('\%[XT]' ,s):
      value = vars.get( m.group(0), '' )
      s = sub('\\'+ m.group(0), value, s) 

   return s



def cmdWithArg(s,arg):
   from re import finditer, sub
   for m in finditer('\%A' ,s):
      s = sub('\\'+ m.group(0), arg, s) 
   return s



"""Gracefully adapt to unavailable libgtop2"""
try:
   import gtop
except ImportError:
   from planB import measure # only rusage cpu time
else:
   from planA import measure # cpu load, resident memory and rusage cpu time



def main():
   """Assume $CWD is a program source directory."""
   from os import getcwd, chdir, mkdir
   from os.path import join
   from cStringIO import StringIO

   initialize()
   path = getcwd()
   programs = targetPrograms(path)

   # do the work in a tmp directory
   tmpdir = join(path,'tmp')
   try:
      chdir(tmpdir)
   except OSError: # assume - No such file or directory
      mkdir(tmpdir); chdir(tmpdir)
    
   for filename in programs:
      ext = filename.split('.').pop() # We only selected filenames with a .
      if ext in make:
         pass

      t = cmdTemplate(filename,ext)
      out = StringIO()

      i = run['repeat']
      while i > 0:
         for a in testvalues:
            cmd = cmdWithArg(t,a)
            if not ext in make:
               m = measure(a,cmd.split(),run['sampledelay'],run['maxtime'])
               print >>out, '%s,%d,%.3f,%d,%s' % m

         i = i - 1

      dat = open( join(path,'dat',filename), 'w')
      dat.write( out.getvalue() )
      dat.close()
      out.close()


           
if __name__ == "__main__":
   main()


