% Заменить элемент на заданное значение
replace(_, _, [], []).
replace(Old, New, [Old|T], [New|R]) :-
    !, replace(Old, New, T, R).
replace(Old, New, [H|T], [H|R]) :-
    replace(Old, New, T, R).

% ?- replace(2, x, [1,2,3,2,4], R).
