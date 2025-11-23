fruits(peaches,yellow).
fruits(apples,yellow).
fruits(apples,red).
fruits(oranges,orange).

mary_loves(peaches).
mary_loves(apples).
mary_loves(corns).

is_corn(X) :- X == corns.

beth_loves(X, Y) :-
    mary_loves(X) , fruits(X, Y), Y == red. 

beth_loves(X, _) :-
    mary_loves(X) , is_corn(X).

%Что любит Бет?
?- beth_loves(X).

%Любит ли Мэpи кукуpузу?
?- mary_loves(corns).

%Какие фpукты известны?
?- fruits(X, _).

%Какого цвета фpукты, котоpые любят Бет и Мэpи?
?- fruits(Fruit, Color),
(mary_loves(Fruit), beth_loves(Fruit, Color)).
