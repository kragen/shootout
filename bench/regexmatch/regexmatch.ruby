#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: regexmatch.ruby,v 1.1 2004-05-19 18:11:27 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

re = Regexp.new(
    '(?:^|[^\d\(])' +			# must be preceeded by non-digit
    '(?:\((\d\d\d)\)|(\d\d\d))' +	# match 1 or 2: area code is 3 digits
    '[ ]' +				# area code followed by one space
    '(\d\d\d)' +			# match 3: prefix of 3 digits
    '[ -]' +				# separator is either space or dash
    '(\d\d\d\d)' +			# match 4: last 4 digits
    '\D'				# must be followed by a non-digit
)

NUM = Integer(ARGV[0] || 1)

phones = STDIN.readlines

count = m = line = iter = 0
for iter in 1..NUM
    for line in phones
	if m = re.match(line)
	    num = '(' + (m[1] || m[2]) + ') ' + m[3] + '-' + m[4];
	    if iter == NUM
		count += 1
		puts "#{count}: #{num}"
	    end
	end
    end
end
