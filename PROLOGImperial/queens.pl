%member predefined

eightqueens([]).
 
eightqueens([X/Y|Rest]) :- eightqueens(Rest),
 			   member(Y, [1,2,3,4,5,6,7,8]),
 			   safe(X/Y, Rest).
 
safe(_,[]).
 
safe(X/Y,[X1/Y1|Rest]) :- Y =\= Y1,
 			  Y1 - Y =\= X1 - X,
 			  Y1 - Y =\= X - X1,
			  safe(X/Y,Rest).

obrazets([1/Y1,2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).
