#!/bin/sh

ulimit -s unlimited

# Groovy support
JAVA_HOME=/usr/lib/j2sdk1.4.2_05
export JAVA_HOME

# Eiffel Support
SmartEiffel=../loadpath.se
export SmartEiffel

# Poplog support
poplogroot=/usr/lib/poplog
usepop=$poplogroot/current-poplog
poplocal=$poplogroot
local=$poplocal/local

export poplogroot usepop poplocal local

. $usepop/pop/com/poplog.sh

if [ -f /opt/shootout/shootout/bench/Include/poplog ]
then
    poplib=/opt/shootout/shootout/bench/Include/poplog
else
    poplib=$poplocal/local/setup/Poplib
fi

export poplib

# support Intel C++
PATH=/opt/intel/cc/9.0/bin:$PATH
LD_LIBRARY_PATH=/opt/intel/cc/9.0/lib:$LD_LIBRARY_PATH
MANPATH=/opt/intel/cc/9.0/man:$MANPATH

# support Intel Fortran
PATH=/opt/intel/fc/9.0/bin:$PATH
LD_LIBRARY_PATH=/opt/intel/fc/9.0/lib:$LD_LIBRARY_PATH
MANPATH=/opt/intel/fc/9.0/man:$MANPATH

# support GCL
GCL_ANSI=1

# support CHICKEN
CHICKEN_REPOSITORY=/usr/share/chicken

# support XDS (C)
PATH=/opt/xds_x86/bin:$PATH
XDSDIR=/opt/xds_x86

export PATH LD_LIBRARY_PATH MANPATH GCL_ANSI CHICKEN_REPOSITORY XDSDIR
