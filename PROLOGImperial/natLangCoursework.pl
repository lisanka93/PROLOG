sentence(S) :- noun_phrase_better(NP), verb_phrase(VP), append(NP, VP, S).

noun_phrase(NP) :- article(A), noun(N), append(A, N, NP). 

verb_phrase(V) :- verb(V).
verb_phrase(VP):- verb(V), noun_phrase_better(NP), append(V, NP, VP).
verb_phrase(VP):- cadv(C), verb(V), append(C,V,X), noun_phrase_better(N), append(X,N,VP).


article([the]).
article([a]).
article([an]).

noun([grass]).
noun([cow]).
noun([girl]).
noun([boy]).
noun([eagle]).
noun([apple]).
noun([song]).

adverb([slowly]).
adverb([deliberately]).
adverb([merrily]).
adverb([sweetly]).
%adverb([kindly]).
%adverb([horrifyingly]).

verb([eats]).
verb([sings]).
verb([chews]).
verb([kicks]).

conj([and]).



%1 a

count_sentences(L, X) :- count_repetitions([and], L, Count), X is Count + 1.       %counting the "ands" since sentence ground

%%%%%%%%%%%%%%%%%%%%%%%%%%%  helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count_repetitions([_], [], 0).
count_repetitions([Word], [Word|Tail], Count):- count_repetitions([Word], Tail, X), Count is X + 1.
count_repetitions([Word], [Z|Tail], Count):- Word \= Z, count_repetitions([Word], Tail, Count).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%1 b
member2(X,Y) :- member(X,Y),!.    %if a noun comes up in a sentence more than once it would output the list that many times, this removes the unnecesary outcomes

actions(Actor, Full, Actions) :-  noun([Actor]), findall(Act, (append(_, [Actor, Act|_], Full), verb([Act])), Actions),member2(Actor,Full).


%2
thealwayssuitable(_, [the]).

%I believe this is pretty much selfexplanatory
thealwayssuitable(First, A) :- (member(First, [a, e, i, o, u]) -> A=[an]; A=[a]).

noun_phrase_better(NP) :- article(A), noun([N]), atom_chars(N, [First|_]), thealwayssuitable(First, A), append(A, [N], NP).

%3
cadvs(L):- accumulator([],L).  %accumulator with empty adverb list passed to cadvs
  
/*first case: only one adverb, then it is put into accumulator (2nd), then appends adverb in accumulator with "and" and new adverb, if "and"already member commas needed! same procedure */

accumulator(Acc,L):-L=Acc,\+Acc=[]. 
accumulator(Acc1,L):- (length(Acc1,0), adverb(H), append(H,Acc1,Acc2), accumulator(Acc2,L)); 
                      (nonmember(and,Acc1), adverb([H]), nonmember(H,Acc1), append([H],[and],Acc2), append(Acc2,Acc1,Acc3), accumulator(Acc3,L)); 
                      (member(and,Acc1), adverb([H]),nonmember(H,Acc1),append([H],[','],Acc2), append(Acc2,Acc1,Acc3), accumulator(Acc3,L)). 

 % case 1 - verb
verb_phrase_better(Phrase) :- verb(Phrase).
 % case 2 - verb and noun
verb_phrase_better(Phrase) :- verb(Verb), noun_phrase_better(Noun), append(Verb, Noun, Phrase).
 % case 3 - adverbs and verb
verb_phrase_better(Phrase) :- cadvs(Adverbs), verb(Verb), append(Adverbs, Verb, Phrase).
 % case 4 - adverbs, verb, and noun
verb_phrase_better(Phrase) :- verb(Verb), noun_phrase_better(Noun), append(Verb,Noun,Blubb), cadvs(Adverbs), append(Adverbs, Blubb, Phrase).


% sentence_better
sentence_better(Sentence) :- noun_phrase_better(Noun), verb_phrase_better(Verb), append(Noun, Verb, Sentence).






