% Сортировка вставками
insertion_sort([], []).
insertion_sort([H|T], Sorted) :-
    insertion_sort(T, SortedTail),
    insert_sorted(H, SortedTail, Sorted).

insert_sorted(X, [], [X]).
insert_sorted(X, [H|T], [X,H|T]) :-
    X =< H, !.
insert_sorted(X, [H|T], [H|Rest]) :-
    insert_sorted(X, T, Rest).

% ?- insertion_sort([4,1,3,2], R).
