# $Id: regexmatch.gawk,v 1.1 2004-05-19 18:11:23 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];
    delete ARGV;
}

{ phones[p++] = $0; }

END {
    for (i=0; i<n; i++) {
	for (j=0; j<p; j++) {
	    line = phones[j];
	    if (match(line, /(^|[^0-9])(\([0-9][0-9][0-9]\)|[0-9][0-9][0-9]) [0-9][0-9][0-9][ -][0-9][0-9][0-9][0-9]($|[^0-9])/)) {
		m1 = substr(line, RSTART, RLENGTH);
		num = ""
		if (match(m1, /[0-9][0-9][0-9] [0-9][0-9][0-9][ -][0-9][0-9][0-9][0-9]/)) {
		    if (substr(m1, RSTART-1, 1) == "(") {
			break;
		    }
		    if (x = split(substr(m1, RSTART, RLENGTH), parts, /[ -]/)) {
			num = "(" parts[1] ") " parts[2] "-" parts[3];
		    }
		} else if (match(m1, /\([0-9][0-9][0-9]\) [0-9][0-9][0-9][ -][0-9][0-9][0-9][0-9]/)) {
		    if (x = split(substr(m1, RSTART, RLENGTH), parts, /[ -]/)) {
			num = parts[1] " " parts[2] "-" parts[3];
		    }
		}
		if (i == (n-1)) {
		    count++;
		    printf("%d: %s\n", count, num);
		}
	    }
	}
    }
}
