bubble_sort(List, Sorted) :-
    bubble_pass(List, List1), !,
    bubble_sort(List1, Sorted).
bubble_sort(List, List).

bubble_pass([X, Y|T], [Y|Rest]) :-
    X > Y, !,
    bubble_pass([X|T], Rest).
bubble_pass([X|T], [X|Rest]) :-
    bubble_pass(T, Rest).
bubble_pass([], []).

% ?- bubble_sort([3,1,4,2], R).
