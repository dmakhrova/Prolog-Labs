big(bear).
big(elephant).
small(cat).
brown(bear).
black(cat).
gray(elephant).

dark(X) :-
    black(X) ; brown(X).

%Кто одновpеменно большой и темный?
?- big(X),
?- dark(X).

%Есть ли коpичневые маленькие слоны?
?- small(elephant), brown(elephant).

%Есть ли коpичневые маленькие слоны?
?- big(bear), dark(bear).

%Есть ли чеpный кот?
?- black(cat).
