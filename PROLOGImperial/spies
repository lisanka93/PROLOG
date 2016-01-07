
:- use_module(library(lists)).
:- set_prolog_flag(toplevel_print_options, [max_depth(100)]).

%Question 1.

decode([], []).
decode([H|T], [H1|T1]) :- 
		H = bear, 
		H1 = double, 
		decode(T, T1).
decode([H|T], [H1|T1]) :- 
		H = cub, 
		H1 = agent, 
		decode(T, T1).
decode([H|T], [H|T1]) :- 
		\+ H = cub, 
		\+ H = bear, 
		decode(T, T1).

%Question 2.

agents2(Message, Decoded, Agents) :- %decode(Message,Decoded), 
				    setof(X, (decode(Message,Decoded),doubleAgent(Message,X)), Agents);
				    Agents = [].


doubleAgent([X,is,a,bear,cub|_], X).
doubleAgent([H|T], X) :- doubleAgent(T, X).


%Question 3.
count_word(W,L,N) :- findall(W, member(W,L), D), length(D,N).

%Question 4.
count_agNames(Message,AgNameCounts) :- agents(Message, _, ListA),
			   	       setof((X,N), (member(X,ListA),count_word(X,ListA,N)), AgNameCounts); AgNameCounts=[].


%Question 5.

acclist(M,List) :- findall(X, doubleAgent(M, X), List).

acc_count(M,AC) :- acclist(M,ListOfAcc),
		   setof((N,X), (member(X,ListOfAcc),count_word(X,ListOfAcc,N)), List1),
		   reverse(List1,List2), translate(List2,AC).

reverse2(L,R) :- reverse2(L,[],R).
reverse2([],L,L).
reverse2([H|T], Acc, Reverse) :- reverse2(T,[H|Acc],Reverse).

replace((A,B),(B,A)).
translate([],[]).
translate([H|T], [H1|T1]) :- replace(H, H1), translate(T, T1).







