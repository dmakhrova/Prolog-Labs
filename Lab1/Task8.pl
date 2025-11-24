schedule("Амтрак", "Нью-Йорк", "Бостон", "Ж/д").
schedule("Транзит", "Нью-Йорк", "Принстон", "Ж/д").
schedule("Амтрак", "Бостон", "Портленд", "Ж/д").
schedule("Грейхаунд", "Бостон", "Портленд", "Автобус").
schedule("Амтрак", "Нью-Йорк", "Вашингтон", "Ж/д").
schedule("Пиплз", "Нью-Йорк", "Вашингтон", "Самолет").
schedule("Пиплз", "Бирлингтон", "Нью-Йорк", "Самолет").

are_competitors(Company1, Company2) :-
    not(Company1 == Company2) ,
    schedule(Company1, From, To, _),
    schedule(Company2, From, To, _).

can_travel(From, To) :-
    schedule(_, From, To, _).

can_travel(From, To) :-
    schedule(_, From, Middle, _),
    can_travel(Middle, To).
    

%Являются ли Амтpак и Пиплз конкуpентами?
?- are_competitors("Амтрак", "Пиплз").

%Какие компании дают возможность путешествовать из Hью-Йоpка в Вашингтон?
?- schedule(X, "Нью-Йорк", "Вашингтон").

%Можно ли путешествовать из Биpлингтона в Поpтленд?
?- can_travel("Бирлингтон", "Портленд").

%Опpеделить всех конкуpентов.
?- are_competitors(Company1, Company2),
not(Company1 == Company2).
