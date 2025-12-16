% Слить два упорядоченных списка
merge([], L, L).
merge(L, [], L).
merge([H1|T1], [H2|T2], [H1|Merged]) :-
    H1 =< H2, !,
    merge(T1, [H2|T2], Merged).
merge([H1|T1], [H2|T2], [H2|Merged]) :-
    merge([H1|T1], T2, Merged).

% ?- merge([1,3,5], [2,4,6], R).
