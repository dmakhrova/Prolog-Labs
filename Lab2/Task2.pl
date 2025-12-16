%Определить, является ли один список подсписком другого
sublist(Sub, List) :-
    append(_, Rest, List),
    append(Sub, _, Rest).

%?- sublist([2,3], [1,2,3,4]).
