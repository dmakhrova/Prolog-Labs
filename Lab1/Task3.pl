%пол
male(jack).
male(richard).
male(dmitry).
male(yuri).
female(mary).
female(anna).
female(lucy).

%родитель(Родитель, Ребёнок)
parent(dmitry, yuri).
parent(mary, yuri).

parent(dmitry, anna).
parent(mary, anna).

parent(lucy, jack).
parent(richard, jack).

son(Child,Parent) :-
    male(Child) , parent(Parent,Child).

dauther(Child,Parent) :-
    female(Child) , parent(Parent,Child).

father(Parent,Child) :-
    male(Parent) , parent(Parent,Child).

mother(Parent,Child) :-
    female(Parent) , parent(Parent,Child).

childs_of_couple(Child, Father, Mother) :-
    father(Father, Child) ,
    mother(Mother, Child).
    
%Опpеделить всех сыновей опpеделенной матеpи.
?- son(X, mary).

%Опpеделить всех детей опpеделенной паpы pодителей.
?- childs_of_couple(X, dmitry, mary).

%Опpеделить pодителей опpеделенного человека.
?- childs_of_couple(jack, Father, Mother).

%Является ли опpеделенный человек женщиной?
?- female(lucy).
