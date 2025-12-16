% Удалить два последних элемента
remove_last_two([_,_], []).
remove_last_two([H|T], [H|R]) :-
    remove_last_two(T, R).

% ?- remove_last_two([1,2,3,4,5], R).
