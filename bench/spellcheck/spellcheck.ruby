#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: spellcheck.ruby,v 1.1 2004-05-19 18:13:26 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

dict = Hash.new
file = open("Usr.Dict.Words")
while file.gets()
    dict[$_.chomp!] = 1
end
file.close()

count = word = 0
while STDIN.gets()
    unless dict.has_key? $_.chomp!
	puts $_
    end
end
