\ $Id: ann.ackermann.forth,v 1.1 2004-05-19 18:09:10 bfulgham Exp $
\ http://www.bagley.org/~doug/shootout/

\ note on annotations:
\ "ps:" is what to expect on parameter stack at given point

\ ackermann's function

\ In C:
\ Ack(int M, int N) {
\    if (M == 0) return( N + 1 );
\    if (N == 0) return( Ack(M - 1, 1) );
\    return( Ack(M - 1, Ack(M, (N - 1))) );
\ }


\ ACK
\ (call: N M ack)
: ack ( n n -- n ) recursive
    \ ps: N M
    dup
    \ ps: N M M
    0=
    \ ps: N M (M==0)
    if
    \ ps: N M
	drop
	\ ps: N
        1+
	\ ps: (N'=N+1)
    else
    \ ps: N M
	swap dup
	\ ps: M N N
	0=
	\ ps: M N (N==0)
	if
	\ ps: M N
	    \ we want this: 1 M-1 ack
	    drop
	    \ ps: M
	    1-
	    \ ps: (M'=M-1)
	    1
	    swap
	    \ ps: 1 M'
	    ack
	    \ ps: A'
	else
	\ ps: M N
	    \ we want this: (N-1 M ack) M-1 ack
	    1-
	    \ ps: M (N'=N-1)
	    over
	    \ ps: M N' M
	    1-
	    \ ps: M N' (M'=M-1)
	    rot
	    \ ps: N' M' M
	    rot
	    \ ps: M' M N'
	    swap
	    \ ps: M' N' M
	    ack
	    \ ps: M' A'
	    swap
	    \ ps: A' M'
	    ack
	    \ ps: A''
	then
    then
    ;
\ END ACK

\ run ack(M,N) [-> N M ack] and print result from stack
." Ack: " 8 3 ack 1 u.r cr

\ th-th-that's all folks!
bye
