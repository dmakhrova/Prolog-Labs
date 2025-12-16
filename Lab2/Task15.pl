% Сумма элементов на нечётных позициях
sum_odd_pos(List, Sum) :-
    sum_odd_pos(List, 1, Sum).

sum_odd_pos([], _, 0).
sum_odd_pos([H|T], Pos, Sum) :-
    1 =:= Pos mod 2, !,
    sum_odd_pos(T, Next, Rest),
    Sum is H + Rest,
    Next is Pos + 1.
sum_odd_pos([_|T], Pos, Sum) :-
    Next is Pos + 1,
    sum_odd_pos(T, Next, Sum).

% ?- sum_odd_pos([10,20,30,40,50], S).
