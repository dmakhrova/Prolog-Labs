% Являются ли два элемента соседними в списке
adjacent(X, Y, [X,Y|_]).
adjacent(X, Y, [Y,X|_]).
adjacent(X, Y, [_|T]) :-
    adjacent(X, Y, T).

% ?- adjacent(2,3, [1,2,3,4]). 
