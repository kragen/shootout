#!/bin/sh

# Poplog support
poplogroot=/usr/lib/poplog
usepop=$poplogroot/current.poplog
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
PATH=/opt/intel_cc_80/bin:$PATH
LD_LIBRARY_PATH=/opt/intel_cc_80/lib:$LD_LIBRARY_PATH
MANPATH=/opt/intel_cc_80/man:$MANPATH

# support GCL
GCL_ANSI=1

export PATH LD_LIBRARY_PATH MANPATH GCL_ANSI
