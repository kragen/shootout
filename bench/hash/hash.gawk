# $Id: hash.gawk,v 1.1 2004-05-19 18:09:55 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];

    for (i = 1; i <= n; i++)
	x[sprintf("%x", i)] = i
    for (i = n; i > 0; i--)
	if (i in x)
	    c++
    print c
}
