%Удалить все вхождения заданного элемента из списка
remove_all(_, [], []).
remove_all(X, [X|T], R) :-
    !, remove_all(X, T, R).
remove_all(X, [H|T], [H|R]) :-
    remove_all(X, T, R).

% ?- remove_all(2, [1,2,3,2,4,2], R).
