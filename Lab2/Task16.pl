% Инвертировать список
my_reverse(List, Rev) :-
    rev_acc(List, [], Rev).

rev_acc([], Acc, Acc).
rev_acc([H|T], Acc, Rev) :-
    rev_acc(T, [H|Acc], Rev).

% ?- my_reverse([1,2,3], R).
