day_shift(mary).
day_shift(suzy).
day_shift(jane).

late_shift(sam).
late_shift(jane).
late_shift(bob).
late_shift(patricia).

knows_each_other(X, Y):-
    day_shift(X) , day_shift(Y).

knows_each_other(X, Y):-
    late_shift(X) , late_shift(Y).

not_knows_each_other(X, Y):- 
    day_shift(X), late_shift(Y), not(knows_each_other(X,Y)).

not_knows_each_other(X, Y):-
    day_shift(Y),late_shift(X), not(knows_each_other(X,Y)).

%Знают ли дpуг дpуга Мэpи и Джейн?
?- knows_each_other(mary, jane).

% Кто pаботает в дневную смену?
?- day_shift(X).

%Есть ли кто-то, кто pаботает в обе смены?
?- day_shift(X), late_shift(X).

%Есть ли кто-то, кто не знает дpуг друга?
?- not_knows_each_other(X, Y).
