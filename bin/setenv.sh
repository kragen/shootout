#!/bin/sh

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
