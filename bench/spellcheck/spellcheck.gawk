# $Id: spellcheck.gawk,v 1.1 2004-05-19 18:13:26 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    delete ARGV;
    while (getline < "Usr.Dict.Words") {
	dict[$0] = 1;
    }
}
{
    if (!dict[$1]) {
	print $1
    }
}
