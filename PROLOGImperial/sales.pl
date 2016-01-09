sellsFor('Peter Jones',swan123,28).    %supplier, item price
sellsFor('Peter Jones',electrolux214,27).

sellsFor('Peter Jones',hoover02,60).
sellsFor('Peter Jones',electrolux09,70).

sellsFor('Harrods', electrolux214, 31).
sellsFor('Harrods', swan123, 30).

sellsFor('Harrods', hoover02, 65).
sellsFor('Harrods', electrolux09, 80).

inStock('Peter Jones',electrolux214).  %supplier has item in stock
inStock('Peter Jones',hoover02).
inStock('Peter Jones',electrolux09).

inStock('Harrods',swan123).
inStock('Harrods',electrolux09).

locatedIn('Peter Jones',london).   %supplier located in city
locatedIn('Harrods',london).
	

typeOfItem(swan123,electricKettle).       %type of item
typeOfItem(electrolux214,electricKettle).
typeOfItem(hoover02, vacuum_cleaner).     
typeOfItem(electrolux09, vacuum_cleaner).        

equivalentItems(electrolux214,swan123).          %equivalent
equivalentItems(electrolux09,hoover02).

forall(C1,C2) :- \+ ((C1,\+C2)).


%question 1.
sellsOneForLessThan(T,MP,S,I,P) :- sellsFor(S,I,P),
		 		   typeOfItem(I,T),
				   MP > P.

%question 2.
equivalent(I1,I2) :- equivalentItems(I1,I2); 
		     equivalentItems(I2,I1).

%question 3.
sellsEquivalentItemIn(I,C,EI,S) :- locatedIn(S,C), sellsFor(S,I,P),
				   (inStock(S,I) ;
				    equivalent(I,EI), sellsFor(S,EI,P2), P2>=P).

%question 4.
neverUnderSold(S,C) :- locatedIn(S,C), sellsFor(S,I,P1), 
		       locatedIn(S2,C), sellsFor(S2,I,P2),
		      % S\=S2,
		       forall(sellsFor(S,I,P1), P1<P2).

neverUnderSold2(S,C) :- locatedIn(S,C),
 		        forall(sellsFor(S,I,SP), \+ ((sellsFor(OS,I,OP),OS\=S, OP<SP))).

%Question 5.
listOfSuppliersFor(I,C,L) :- setof((P,S), (sellsFor(S,I,P),inStock(S,I), locatedIn(S,C)), L).






