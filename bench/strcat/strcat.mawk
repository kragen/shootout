# $Id: strcat.mawk,v 1.1 2004-05-19 18:13:34 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];

    str = ""
    for (i = 0; i < n; i++)
	str = str "hello\n"

    print length(str)
}
