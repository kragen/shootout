#!/usr/bin/ruby
# -*- mode: ruby -*-
# $Id: heapsort.ruby,v 1.1 2004-05-19 18:10:10 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

IM = 139968
IA =   3877
IC =  29573

$last = 42.0
def gen_random (max) (max * ($last = ($last * IA + IC) % IM)) / IM end

def heapsort(n, ra)
    j = i = rra = 0
    l = (n >> 1) + 1
    ir = n

    while (1) do
	if (l > 1) then
	    rra = ra.at(l -= 1)
	else
	    rra = ra.at(ir)
	    ra[ir] = ra.at(1)
	    if ((ir -= 1) == 1) then
		ra[1] = rra
		return
	    end
	end
	i = l
	j = l << 1
	while (j <= ir) do
	    if ((j < ir) and (ra.at(j) < ra.at(j+1))) then
		j += 1
	    end
	    if (rra < ra.at(j)) then
		ra[i] = ra.at(j)
		j += (i = j)
	    else
		j = ir + 1
	    end
	end
	ra[i] = rra
    end
end

N = Integer(ARGV.shift || 1)
ary = []
for i in 1 .. N
    ary[i] = gen_random(1.0)
end

heapsort(N, ary)

printf "%.10f\n", ary.at(N)
