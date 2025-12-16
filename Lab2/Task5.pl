% Дублировать каждый элемент списка
duplicate([], []).
duplicate([H|T], [H,H|Rest]) :-
    duplicate(T, Rest).

% ?- duplicate([a,b,c,1], R).
