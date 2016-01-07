:-use_module(library(lists)).


% child_mother(C, M) means C is a child of mother M.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

child_mother(amy, mary).
child_mother(arthur, mary).
child_mother(angel, jane).
child_mother(anton, rita).
child_mother(alan, anita).
child_mother(axel, susan).
child_mother(ann, beate).    


% age(C, A) means C is of age A.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

age(amy, 6).
age(arthur, 15).
age(angel, 3).
age(anton, 4).
age(alan, 4).
age(axel, 16).
age(ann, 4).

% employed(X) means X is employed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

employed(susan).
employed(rita).



%Question i)

ecb(M) :- child_mother(C,M), age(C,Age), 
	  (Age=<14;
	   \+ employed(M), Age>14, Age=<16).

%Question ii)

mother_of_youngest(Mum):- setof((A,Mum), C^(child_mother(C, Mum), age(C, A)), L), L=[(A,Mum)| Rest].

%note - apparently you can ignore the alphabetical order of mother spec in the question outline - setof also orders is according to second element if first is the same

%Question iii)

mothers_of_young(List):- setof(Mum, C^A^(child_mother(C,Mum), age(C,A),A=<10),  List).

%note - remember to use ^^ twice since we only need mum


merge([], L2, L2).
merge(L1, [], L1).
merge([X|Xs],[Y|Ys], [X|T]):- X=<Y, merge(Xs,[Y|Ys], T).
merge([X|Xs],[Y|Ys], [Y|T]):- X>Y, merge([X|Xs],Ys, T).  


findElement(1, [E|_], E).
findElement(N, [_|L], E) :-
	\+ N < 1,
	length(L, Length),
	\+ N > Length,
	K is N - 1,
	findElement(K, L, E).


