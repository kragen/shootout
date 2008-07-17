#!/usr/bin/python

# $Id: nanobench.py,v 1.3 2008-07-17 06:42:23 igouy-guest Exp $

"""
nanobench gathers cpu time measurements, samples resident memory usage, and
averages cpu load for the benchmarks game.

nanobench is intended to be a much simplified replacement for minibench.
"""
__author__ =  'Isaac Gouy'


# globals
automake = frozenset()
commandlines = {}
run = { 'maxtime': 120, 'repeat': 5, 'sampledelay': 0.2 }
testvalues = []


def main():
   global automake
   config_file = 'nanobench.conf'

   from sys import argv, exit
   from getopt import getopt, GetoptError

   try:
      options,_ = getopt(argv[1:],'',['help','conf=','range='])

      for o, v in options:
         if o in ('--help'):
            pass
         elif o in ('--conf'):
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

      automake = frozenset( parser.get("build", "automake").split() )
      commandlines.update( parser.items("commandlines") )
      run.update( parser.items("run") )

   except (NoSectionError,NoOptionError), ex:
      print str(ex)
      exit(2)


def targetPrograms():
   """Assumes dat file is only written once all data is available"""
   from os import getcwd, listdir, mkdir
   from os.path import join, isdir, getmtime
   from fnmatch import filter

   path = getcwd()

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
      programs = set(files)

   return frozenset(programs)


     
if __name__ == "__main__":
    main()
    print targetPrograms()


