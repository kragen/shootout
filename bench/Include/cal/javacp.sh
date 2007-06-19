#!/bin/sh

# the root folder for execution
ROOTDIR="`dirname "$0"`"

# Delegate to set-javacp-base.sh for setting up the basic classpath (without adding in either CAL resources or Car-jars)
. $ROOTDIR/set-javacp-base.sh

# Do the same with set-javacp-extended.sh if it exists.
if test -f $ROOTDIR/set-javacp-extended.sh
then
   . $ROOTDIR/set-javacp-extended.sh
fi

# Uncomment the following line to run with Car-jars.
# carjar=foo

# If we are to run with Car-jars, delegate to set-javacp-carjar.bat for adding the Car-jars to the classpath.
# Otherwise, add an entry for the debug folder, in order to make the test CAL scripts available.

if test ! -z "$carjar"
then
   . $ROOTDIR/set-javacp-carjar.sh
else
   JAVACP_PATH=$ROOTDIR/bin/cal/release:$ROOTDIR/bin/cal/debug:$JAVACP_PATH
fi

if test -z "$QUARK_JAVACMD"
then
   QUARK_JAVACMD=java
fi

$QUARK_JAVACMD -server -Xbatch -Xmx256m $QUARK_VMARGS -cp $JAVACP_PATH $*
