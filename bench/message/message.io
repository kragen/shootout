/* The Computer Language Shootout
   http://shootout.alioth.debian.org
   Contributed by Gavin Harrison */


create_coro := method(n,
	if(n > 1,
		coro := @create_coro(n-1)
		yield
		coro+1
	,
		yield
		1
	)
)

coro := @create_coro(500)
count := 0
(args at(1) asNumber) repeatTimes(
	yield
	count = coro + count
)

count println
