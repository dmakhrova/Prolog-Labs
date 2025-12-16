% Найти максимальный элемент списка
my_max([X], X).
my_max([H|T], Max) :-
    my_max(T, M),
    (H > M -> Max = H ; Max = M).

% ?- my_max([3,1,4,1,5], M).
