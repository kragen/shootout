# $Id: ary.gawk,v 1.1 2004-05-19 18:09:15 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];

    for (i = 0; i < n; i++)
	x[i] = i
    for (j = n-1; j >= 0; j--)
	y[j] = x[j]

    print y[n-1]
}
