% Добавить элемент в конец списка
append_end([], X, [X]).
append_end([H|T], X, [H|R]) :-
    append_end(T, X, R).

% ?- append_end([1,2,3], 4, R).
