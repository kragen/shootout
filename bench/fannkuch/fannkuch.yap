% ----------------------------------------------------------------------
% The Computer Language Benchmarks Game
% http://shootout.alioth.debian.org/
%
%   yap -L fannkuch.plog -- 11
%
% Contributed by Anthony Borla
% Modified by Glendon Holst
% ----------------------------------------------------------------------

:- yap_flag(unknown,error).

:- use_module(library(lists)).

:- initialization(main).

main :-
  unix( argv([H|_]) ), number_atom(N,H),

  init_fannkuch,

  f_permutations(N, MaxFlips),
  format('Pfannkuchen(~d) = ~d~n', [N, MaxFlips]).

% ------------------------------- %

init_fannkuch :- setvar(perm_N, 0), setvar(max_flips, 0).

% ------------------------------- %

f_permutations(N, MaxFlips) :-
  numlist(1, N, L),
  f_permutations_(L, N, 0),
  getvar(max_flips, MaxFlips).

% ------------- %

f_permutations_(L, N, I) :-
  (I < N ->
    (N =:= 1 ->
      !, processPerm(L)
    ;
      N1 is N - 1,
      f_permutations_(L, N1, 0),
      split_list(L, N, Lt, Ld),
      rotateLeft(Lt, LtRL), append(LtRL, Ld, La), Ii is I + 1,
      !, f_permutations_(La, N, Ii))
  ;
    !, true).

% ------------------------------- %

flips(L, Flips) :- flips_(L, 0, Flips).

flips_([1|_], Fla, Fla) :- !.

flips_([N|T], Fla, Flips) :-
	take_drop([N|T], N, Lt, Ld), append(Lt, Ld, La),
	Fla1 is Fla + 1, !, flips_(La, Fla1, Flips).

% ------------------------------- %

rotateLeft([H|T], RL) :- append(T, [H], RL).
rotateLeft([], []).

% ------------------------------- %

numlist(N, M, [N|Ls]) :- N < M, !, N1 is N + 1, numlist(N1, M, Ls).
numlist(M, M, [M]).

% ------------------------------- %

printPerm([L|Ls]) :- write(L), printPerm(Ls).
printPerm([]) :- nl.

% ------------------------------- %

processPerm(L) :-
  getvar(max_flips, MaxFlips), getvar(perm_N, PermN),
  flips(L, Flips),
  (Flips > MaxFlips ->
    setvar(max_flips, Flips)
  ;
    true),
  (PermN < 30 ->
    printPerm(L),
    PermN1 is PermN + 1,
    setvar(perm_N, PermN1)
  ;
    true).

% ------------------------------- %

split_list([L|Ls], N, [L|Hs], Ts) :- 
	N > 0, !, N1 is N - 1,
	split_list(Ls, N1, Hs, Ts). 

split_list(Ls, 0, [], Ls) :- !.

% ------------------------------- %

take_drop(L, N, Taken, Rest) :- take_drop_(L, N, 0, [], Taken, Rest).

%
% 'take' list returned in reverse order. If wanting it in order, use:
%
% take_drop_(L, N, N, Ta, Taken, L) :- !, reverse(Ta, Taken).
%

take_drop_(L, N, N, Ta, Ta, L) :- !.

take_drop_([H|T], N, Nc, Ta, Taken, Rest) :-
  Nc1 is Nc + 1, !, take_drop_(T, N, Nc1, [H|Ta], Taken, Rest).

% ------------------------------- %

getvar(Id, Value) :- nb_getval(Id, Value).
setvar(Id, Value) :- nb_setval(Id, Value).

% ------------------------------- %
