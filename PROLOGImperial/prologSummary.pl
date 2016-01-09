%Difference between those two sublists:


%This one allows repetitions
subList([], L).
subList([H|Sub], List) :- member(H,List), subList(Sub, List).

%This one doesnt
sublist([],[]).
sublist([First|Rest],[First|Sub]):- sublist(Rest,Sub).    
sublist([_|Rest],Sub):- sublist(Rest,Sub).
%however it disregards the beginning

findall([X,Y], sublist([X,Y],[a,b,c]), S).
%finds all instances with 2 members



subset(Sub, List) :- append(L1,L2,List), append(Sub,_,L2).
%subset 



%sorts but doesnt delete duplicates
merge([], L2, L2).
merge(L1, [], L1).
merge([X|Xs],[Y|Ys], [X|T]):- X=<Y, merge(Xs,[Y|Ys], T).
merge([X|Xs],[Y|Ys], [Y|T]):- X>Y, merge([X|Xs],Ys, T). 



palin([]).
palin([_]).
palin([X|Tail]) :- append(M, [X], Tail),
                   palin(M).
%checks if head appended to the middle is the same as the tail

%%%%%%%%%%%%%%%%  OR  %%%%%%%%%%%%%%%%%%%%%%
palin(X) :- reverse(X,X).

reverse([ ], [ ]).
reverse([H | T], R) :- reverse(T, TR), append(TR, [H], R).

%with accumulator
rev(L, RevL) :- rev(L, [], RevL).
rev([], RevL, RevL).          
rev([Head|Tail], Empty, RevL) :- rev(Tail, [Head|Empty], RevL).



%deletes only one occurence
del(X, [X|Tail], Tail).
del(X, [Y|Tail], [Y|Tail1]) :- del(X, Tail, Tail1).

%deletes all occurences
delMember(_, [], []).
delMember(X, [X|Tail], Y) :- delMember(X, Tail, Y).
delMember(X, [T|Tail], [T|Y]) :- X\=T, delMember(X, Tail, Y).
%one extra step that deletes

add(X, L, [X|L]).

%%%%%%%%%%%%%%%%relationship between insert and delete%%%%%%%%%%%%
insert(X, List, BiggerList) :- del(X, BiggerList,List).

%permutations
perm([], []).
perm([X|L], P) :- perm(L,L1), insert(X, L1, P).

perm2([], []).
perm2(L, [X|P]) :- del(X,L,L1), perm2(L1,P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lengthcount([], 0).  %predefined in sicstus
lengthcount([H|T], N) :- lengthcount(T,N1), N is N1 + 1.

evenlength(X) :- lengthcount(X, P) , 0 is mod(P, 2).
oddlength(X) :- lengthcount(X, P) , 1 is mod(P,2).



%shifts by one
shift([H|T], Shifted) :- append(T, [H], Shifted).
%logical because the head can be more than one element so it will give all the posible solutions with 1,2,3 etc members



means(0, zero).
means(1, one).
means(2, two).
means(3, three).
means(4, four).
means(5, five).

translate([],[]).
translate([H|T], [H1|T1]) :- means(H, H1), translate(T, T1).



%divide list (in a rather weird way, thanks Bratko)
dividelist([], [], []).
dividelist([X,Y|Tail1], [X|Tail2], [Y,Tail3]) :- dividelist(Tail1,Tail2,Tail3).

%divide in the middle
div(L, A, B) :-
    append(A, B, L),
    length(A, N),
    length(B, N).

%anywhere
split(L,N,L1,L2):- append(L1,L2,L),length(L1,N).



%flatten a list
flatten([H|T], Flatlist) :- flatten(H, Flathead), flatten(T, Flattail), append(Flathead,Flattail,Flatlist).
flatten([],[]).
flatten(X, [X]).



%how many occurences of X
occurences([], [], 0).
occurences(X, L, N) :- findall(X, member(X,L), D), length(D,N).

%X occurs on position N in list
position(_, [], 0).
position(X, [X|T], 1).
position(X, [Y|T], N) :- position(X, T, N1), N is N1 + 1.
%or position(X, [Y|T], N) :- N1 is N-1, position(X,T,N1).



%prints range of integers
range(I,I,[I]).
range(I,K,[I|L]) :- I < K, I1 is I + 1, range(I1,K,L).

sumlist([ ], 0). 
sumlist([ N | Ns], Total) :- sumlist(Ns, Sumtail), Total is N+Sumtail. 

%This is not tail-recursive - the query length will expand in 
%proportion to the length of the input list

tr_sum(Ns, Total) :- tr_sum(Ns, 0, Total). 
tr_sum([ ], Total, Total). 
tr_sum([ N | Ns ], Sub, Total) :- NextSub is Sub + N, tr_sum(Ns, NextSub, Total).

%Tail recursive version using an accumulator
%Here the query length never exceeds two calls and each 
%derived query can overwrite its predecessor in memory



max(L,N):-max(L,0,N).
max([],N,N).
max([X|L],S,N):- X>S, max(L,X,N).
max([X|L],S,N):- X=<S, max(L,S,N).   



my_last(X,[X]).
my_last(X,[_|L]) :- my_last(X,L).
%OR lastitem(Item,List) :- append(_,[Item],List).

second_last(X,[X,Y]).
second_last(X,[_|L]) :- second_last(X,L).   %same function just base cases different!

%nthelement(_, [], 0).
nthelement(X, [X|T], 1).
nthelement(X, [H|T], N) :- nthelement(X,T,N1), N is N1 + 1.
%nthelement(X, [H|T], N) :- N1 is N - 1, nthelement(X,T,N1).  also works



cond([],[]).
cond([X|T], [X|Resultinglist]) :- X. %satisfies certain condition, cond(T,Resultinglist).
cond([Throwaway|T], Resultinglist) :- cond(T, Resultinglist).



slice([X|_],1,1,[X]).
slice([X|Xs],1,K,[X|Ys]) :- K > 1,  K1 is K - 1, slice(Xs,1,K1,Ys).
slice([_|Xs],I,K,Ys) :- I > 1,  I1 is I - 1, K1 is K - 1, slice(Xs,I1,K1,Ys).



%duplicates (once,twice...) by added Heads
dupli([],[]).
dupli([H|T], [H,H|Result]) :- dupli(T, Result).

%eliminates consec duplicates
compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs) :- compress([X|Xs],Zs).
compress([X,Y|Ys],[X|Zs]) :- X \= Y, compress([Y|Ys],Zs).

%remove duplicates from list
make_set([],[]).
make_set(X,Y) :- setof(Z, member(Z,X),Y).

%duplicate n times
dupli([],_,[],_).
dupli([_|Xs],N,Ys,0) :- dupli(Xs,N,Ys,N).
dupli([X|Xs],N,[X|Ys],K) :- K > 0, K1 is K - 1, dupli([X|Xs],N,Ys,K1).



%only deletes first nth
delNthFromList(1,[X|L],L).
delNthFromList(N,[X|L1],[X|L2]) :-
N1 is N - 1,
delNthFromList(N1,L1,L2).


% 2 different ways of implementing dropping EVERY nth element from a list
drop(L1,N,L2) :- drop(L1,N,L2,N).
drop([],_,[],_).
drop([_|Xs],N,Ys,1) :- drop(Xs,N,Ys,N).
drop([X|Xs],N,[X|Ys],K) :- K > 1, K1 is K - 1, drop(Xs,N,Ys,K1).


delete_nth(L, N, R) :-
    N > 0, % Added to conform "?‐ delete_nth([a,b,c,d,e,f],0,L). false"
    ( N1 is N - 1, length(Begin, N1), append(Begin, [_|Rest], L) ->
        delete_nth(Rest, N, RestNew), append(Begin, RestNew, R)
    ; R = L).




replace(_, _, [], []).
replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

