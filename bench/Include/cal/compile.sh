#!/bin/bash

#this will take a CAL file, copy it to an appropriately named file, 
#create a workspace declaration for it, and compile it to create 
#a .jar with the same name. The jar will have with a main called <benchmark>.main
#to run this script you should have the unpacked Quark 1.5 distribution on your path

if [ $# != 1 ]; then
    echo "Usage $0 <calbenchmark>"
    exit 1
fi

#create directory structure for source and workspace decl. 
mkdir -p cal/src/CAL "cal/src/Workspace Declarations"

#copy the cal source file to the src dir and capitalize the first letter of the file
bname=`basename $1 .cal`
uname=`echo $bname | sed 's/\(^\| \)./\U&/g'`
cp $bname.cal cal/src/CAL/$uname.cal

#create a workspace file for just this benchmark
cat > "cal/src/Workspace Declarations/cal.$bname.cws" << END
StandardVault $uname
import StandardVault cal.libraries.cws
END

#compile the benchmark
QUARK_CP=cal/src QUARK_JAVACMD=java quarkc.sh cal.$bname.cws -main  $uname.main $bname.main $bname.jar
