\ adapted from a program in the gforth distribution 
\ modified and annotated by doug bagley
\ $Id: ann.sieve.forth,v 1.1 2004-05-19 18:12:28 bfulgham Exp $

\ note on annotations:
\ "ps:" is what to expect on parameter stack at given point

\ find and count all primes from 2 to 8192

decimal

variable ITER

\ GETARG
\ if last command arg is a number use it as
\ number of iterations
: getarg
    argc @ 1-
    \ ps: index_of_last_argv
    arg s>number drop dup
    \ ps: argv[1] argv[1]
    1 <
    \ ps: argv[1] (argv[1]<1)
    if
    \ ps: argv[1]
	\ arg was < 1 so default to 1
	drop 1
	\ ps: 1
    then
    ITER !
    ;
\ END GETARG

getarg

\ we search for primes up to this SIZE
8192 constant SIZE

\ Flags is an array of chars of length SIZE
\ we'll mark all non-prime indexes in this array as false
\ the remaining indexes will be prime numbers
create Flags SIZE allot

\ EndFlags points to end of array Flags
Flags SIZE + constant EndFlags

\ FLAGMULTS
\ flag all multiples of n in array as not prime
\ array has address range: fromaddr toaddr
\ starting value for fromaddr should be
\   arraystart n n + +
: flagmults ( n toaddr fromaddr -- )
    do
	\ ps: n
	0 i
	\ ps: n 0 i
	c!
	\ ps: n		(Flags[i] = 0)
	dup
	\ ps: n n
    +loop
    \ ps: n		(n is added to loop index)
    ;
\ END FLAGMULTS


\ PRIMES
\ find all primes from 2 to SIZE
: primes  ( -- n )
\ fill array Flags with 1's
    Flags SIZE 1 fill
    0 2
    \ ps: (Count=0) (Prime=2)
    \ index i ranges from Flags to EndFlags
    EndFlags Flags
    \ ps: Count Prime EndFlags Flags
    do
	\ ps: Count Prime
	i c@
	\ ps: Count Prime (Flags[i])
	\ If the current Flags[i] is true (i.e. i is prime)
	if
	\ ps: Count Prime
	    dup
	    \ ps: Count Prime Prime
	    i +
	    \ ps: Count Prime (NewIndex=i+Prime)
	    dup EndFlags
	    \ ps: Count Prime NewIndex NewIndex EndFlags
	    <
	    \ ps: Count Prime NewIndex (NewIndex<EndFlags)
	    \ If we aren't at end of flags array yet
	    if
	    \ ps: Count Prime NewIndex
		EndFlags
		\ ps: Count Prime NewIndex EndFlags
		swap
		\ ps: Count Prime EndFlags NewIndex
		flagmults
		\ ps: Count Prime
	    else
	    \ ps: Count Prime NewIndex
		drop
		\ ps: Count Prime
            then
	    \ ps: Count Prime
	    \ Increment our Count of Primes
            swap 1+ swap
	    \ ps: (NewCount=1+Count) Prime
	then
	\ ps: NewCount Prime
	1+
	\ ps: NewCount (NewPrime=1+Prime)
    loop
    drop \ your pants!
    ;
\ END PRIMES (Returns: Count)

\ BENCHMARK
\ run the test ITER @ times
: benchmark  0 ITER @ 0 do  primes nip loop ;


\ now print count of how many Flags are now "true"
." Count: " benchmark  1 u.r cr


\ PPRIMES
\ for testing, we can print out all the prime numbers
: pprimes ( -- )
    \ from index =  to 
    SIZE 0
    do
	\ add the loop counter to the start address of array Flags
	\ and test if the flag at that address is true
	Flags i + c@
	\ ps: (Flags[i])
	if
	    \ if so, print array index + 2
	    i 2 + .
        then
    loop
    cr
    ;
\ END PPRIMES

\ uncomment the following to print the primes or debug
\ pprimes
\ flags 100 dump

\ th-th-that's all folks!
bye
