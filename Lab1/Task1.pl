%животные
dog(flash).
dog(rover).
cat(bootsy).
horse(star).

%окрас
red(rover).
black(flash).
brown(bootsy).
white(star).

%домашнее животное - собака или кошка
pet(X) :- dog(X) ; cat(X).
%животное - домашнее животное или лошадь
animal(X) :- pet(X) ; horse(X).
%У Тома есть собака не чеpного цвета. 
belongs_tom(X) :- dog(X) , not(black(X)).
%У Кейта есть лошадь или что-то чеpного цвета.
belongs_keith(X) :- horse(X) ; black(X).

%владельцы
owns(tom, X) :- belongs_tom(X).
owns(keith, X) :- belongs_keith(X).

%Владелец животного небелого цвета.
owner_nonwhite(O, X):- owns(O, X), animal(X), not(white(X)). 

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Запросы:
%Pовеp рыжая?
red(rover).

%Опpеделить клички всех собак.
dog(X).

%Опpеделить владельцев чего-либо
owns(Owner,Smth).

%Опpеделить владельцев животных небелого цвета
owner_nonwhite(Owner,_).
