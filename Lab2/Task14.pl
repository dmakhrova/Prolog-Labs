% Все перестановки списка
my_permutation([], []).
my_permutation([H|T], Perm) :-
    my_permutation(T, PT),
    insert_anywhere(H, PT, Perm).

insert_anywhere(X, [], [X]).
insert_anywhere(X, [H|T], [X,H|T]).
insert_anywhere(X, [H|T], [H|R]) :-
    insert_anywhere(X, T, R).

% ?- my_permutation([1,2,3], P).
