# $Id: reversefile.mawk,v 1.1 2004-05-19 18:12:18 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN { delete ARGV }
{ x[NR] = $0 }
END { for (i = NR; i >= 1; i--)
    print x[i]
}
