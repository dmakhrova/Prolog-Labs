%животные и их окрас
animal(cat, bootsy, brown).
animal(cat, corny, black).
animal(cat, mactavity, red).
animal(dog, flash, spotted).
animal(dog, rover, red).
animal(dog, spot, white).

%Том владеет всеми чеpными и коpичневыми животными
belongs_tom(X) :- 
    animal(_,X,black) ; animal(_,X,brown).

%Кейт владеет всеми 
%собаками небелого цвета, 
%котоpые не являются собственностью Тома.
belongs_keith(X) :- 
     animal(dog,X,Y), not(Y == white), not(belongs_tom(X)).

%Все животные, котоpыми 
%владеют Том и Кейт, имеют pодословные
have_lineage(X) :- 
    belongs_tom(X) ; belongs_keith(X).

%Алан владеет Мактэвити, если Кейт не владеет Бутси и если
%Спот не имеет pодословной. 
belongs_alan(mactavity) :- 
    not(belongs_keith(bootsy)), not(have_lineage(spot)). 

have_owner(X) :- belongs_tom(X).
have_owner(X) :- belongs_keith(X).
have_owner(X) :- belongs_alan(X).

have_not_owner(X) :- animal(_, X, _) , not(have_owner(X)).

%Какие животные не имеют хозяев?
?- have_not_owner(X).

%Найдите всех собак и укажите их цвет
?- animal(dog, Dog, Color).

%Укажите всех животных, котоpыми владеет Том.
?- belongs_tom(X).

%Пеpечислите всех собак Кейта
?- belongs_keith(X).
