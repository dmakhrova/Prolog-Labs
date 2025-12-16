% Количество элементов списка
my_length([], 0).
my_length([_|T], N) :-
    my_length(T, M),
    N is M + 1.
    
%?- my_length([a,b,c], N).
