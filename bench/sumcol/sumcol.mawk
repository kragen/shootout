# $Id: sumcol.mawk,v 1.1 2004-05-19 18:13:43 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN { delete ARGV; tot = 0 }
{ tot += $1 }
END { print tot }
