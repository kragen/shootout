# $Id: wordfreq.gawk,v 1.2 2004-07-03 05:36:11 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    delete ARGV;
    FS = "[^A-Za-z][^A-Za-z]*";
}
{
    for (i=1; i<=NF; i++) {
	freq[tolower($(i))]++;
    }
}
END {
    # gawk doesn't have a builtin sort routine
    # so we have to pipe through the shell sort program
    sort = "sort -nr"
    for (word in freq) {
	if (word) {
	    printf "%7d %s\n", freq[word], word | sort
	}
    }
    close(sort)
}
