# $Id: wc.mawk,v 1.1 2004-05-19 18:13:51 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

# this program modified from:
#   http://cm.bell-labs.com/cm/cs/who/bwk/interps/pap.html
# Timing Trials, or, the Trials of Timing: Experiments with Scripting
# and User-Interface Languages</a> by Brian W. Kernighan and
# Christopher J. Van Wyk.

# this version is a little more efficient than the original via
# use of NR

BEGIN { delete ARGV }
{
    nc += length($0) + 1
    nw += NF
}
END { print NR, nw, nc }
