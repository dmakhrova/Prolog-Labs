% Последний элемент списка
my_last([X], X).
my_last([_|T], X) :-
    my_last(T, X).

% ?- my_last([1,2,3,4], X).
