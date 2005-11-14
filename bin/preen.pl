#!/usr/bin/perl -w

my @scripts = ( "gawk", "mawk", "bash", "rep", "lua", "newlisp",
	     "php", "perl", "python", "psyco", "pike", "ruby",
	     "guile", "mzscheme", "slang", "tcl", "xemacs", "javascript", 
	     "regina", "groovy", "swiprolog");

my @files;

foreach $lang (@scripts)
{
	#print "Checking $lang\n";
	push @files, `find . -name *.$lang`;
}

print "I found:\n";
foreach $i (@files)
{
	chomp($i);
	if (! -x $i)
	{
		print "$i\n";
		chmod 0755, $i or die "Could not chmod $file: $!\n";
		system ("touch -f $i") == 0 or die "Could not touch $file: $!!\n";
	}
}

print "... done.\n";

