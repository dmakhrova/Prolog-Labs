%Сформировать новый список из всех четных элементов исходного списка
even_elements([], []).
even_elements([H|T], [H|Rest]) :- 
     0 =:= H mod 2, !,
    even_elements(T, Rest).
even_elements([_|T], Rest) :- 
    even_elements(T, Rest).

?- even_elements([1,2,3,4,5,6], Result).
