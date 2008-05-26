% ----------------------------------------------------------------------
% The Computer Language Benchmarks Game
% http://shootout.alioth.debian.org/
%
% Contributed by Anthony Borla
% Modified to run with YAP by Glendon Holst
% ----------------------------------------------------------------------

:- yap_flag(unknown,error).

:- use_module(library(readutil)).

:- initialization(main).

main :-
	current_input(Cin),
	current_output(Cout),

	sum_file(Cin, 0, N),
	
	write(Cout, N), nl(Cout).

% ------------------------------- %

sum_file(S, A, N) :- catch(read_integer(S, I), _, fail), A1 is A + I, !, sum_file(S, A1, N).
sum_file(_, A, A).

% ------------------------------- %

read_integer(S, N) :- read_line_to_codes(S, L), catch(number_codes(N, L), _, fail).
read_integer(_, 0).

