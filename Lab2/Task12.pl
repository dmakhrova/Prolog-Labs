% Быстрая сортировка
quick_sort([], []).
quick_sort([H|T], Sorted) :-
    partition(H, T, Left, Right),
    quick_sort(Left, SortedLeft),
    quick_sort(Right, SortedRight),
    append(SortedLeft, [H|SortedRight], Sorted).

partition(_, [], [], []).
partition(Pivot, [H|T], [H|L], R) :-
    H =< Pivot, !,
    partition(Pivot, T, L, R).
partition(Pivot, [H|T], L, [H|R]) :-
    partition(Pivot, T, L, R).

% ?- quick_sort([3,1,4,1,5,9], R).
