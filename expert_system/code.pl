% -------------------------------
% Комнатные растения: рекомендательная система
% -------------------------------

:- encoding(utf8).

plant('Сансевиерия', 
    [light-any, water-rare, pet-safe, size-any, care-easy],
    'Также известна как «тёщин язык» — очень выносливая и очищает воздух.',
    'Поливайте только когда земля полностью высохнет. Отлично растёт в тени.',
    'NASA включило её в список лучших очистителей воздуха!').

plant('Хлорофитум', 
    [light-medium, water-moderate, pet-safe, size-medium, care-easy],
    'Быстро растущее растение с изящными листьями и «детками» на усах.',
    'Любит влажную почву и рассеянный свет. Просто обожает ванные комнаты!',
    'Может удалять до 90% вредных веществ из воздуха за 24 часа.').

plant('Орхидея фаленопсис', 
    [light-bright, water-rare, pet-safe, size-small, care-hard],
    'Элегантное цветущее растение, которое может цвести месяцами.',
    'Поливайте раз в неделю, но только в корни — не в розетку! Любит тепло и свет.',
    'Орхидеи — одни из самых древних цветущих растений на Земле (старше динозавров!).').

plant('Фикус лировидный', 
    [light-bright, water-moderate, pet-toxic, size-large, care-medium],
    'Стильное крупное растение с глянцевыми листьями — звезда интерьеров.',
    'Не переносит сквозняков и переувлажнения. Поверните на 90° раз в неделю для симметрии.',
    'В природе может достигать 30 метров в высоту!').

plant('Плющ обыкновенный', 
    [light-low, water-moderate, pet-toxic, size-any, care-easy],
    'Ампельное растение с красивыми листьями — идеален для подвесных кашпо.',
    'Любит прохладу и регулярный полив. Хорошо растёт в ванных комнатах.',
    'В Древней Греции плющ был символом верности и вечной жизни.').

plant('Замиокулькас (долларовое дерево)', 
    [light-any, water-rare, pet-toxic, size-medium, care-easy],
    'Модное и супернеприхотливое растение с блестящими листьями.',
    'Поливайте редко — лучше недолить, чем перелить. Любит тепло и «спячку» зимой.',
    'Считается символом богатства в фэн-шуй — отсюда и название «долларовое дерево»!').

plant('Алоэ вера', 
    [light-bright, water-rare, pet-toxic, size-small, care-easy],
    'Лекарственное суккулентное растение с целебным гелем в листьях.',
    'Нужен яркий свет и редкий полив. Почва должна быть песчаной и хорошо дренированной.',
    'Использовалось в медицине ещё в Древнем Египте — называли «растением бессмертия»!').

plant('Спатифиллум («Женское счастье»)', 
    [light-low, water-moderate, pet-toxic, size-medium, care-medium],
    'Элегантное растение с белыми «цветами» (на самом деле — покрывалами).',
    'Любит высокую влажность и регулярный полив. Опрыскивайте листья!',
    'Считается, что цветение спатифиллума приносит удачу в личной жизни!').


% -------------------------------
% Логика рекомендации
% -------------------------------

rank_plant(Plant, Score) :-
    plant(GradPlant, _, _, _, _), % just to ensure Plant is bound
    plant(Plant, Traits, _, _, _),
    score_traits(Traits, Score).

score_traits(Traits, Score) :-
    include(is_relevant, Traits, Relevant),
    aggregate_all(sum(V), (
        member(T, Relevant),
        trait_value(T, V)
    ), Score).

is_relevant(T) :-
    trait_category(T, Cat),
    (Cat = pet -> ask(pets, Answer), Answer \= dont_care;
     Cat = water -> ask(water, Answer), Answer \= dont_care;
     Cat = light -> ask(light, Answer), Answer \= dont_care;
     Cat = care -> ask(care_level, Answer), Answer \= dont_care;
     true).

trait_category(light-_, light).
trait_category(water-_, water).
trait_category(pet-_, pet).
trait_category(care-_, care).
trait_category(_, other).

trait_value(pet-safe, 100).
trait_value(pet-toxic, -1000).
trait_value(water-rare, 20).
trait_value(water-moderate, 10).
trait_value(water-frequent, -10).
trait_value(care-easy, 15).
trait_value(care-medium, 5).
trait_value(care-hard, -20).
trait_value(light-any, 5).
trait_value(light-bright, 5).
trait_value(light-medium, 5).
trait_value(light-low, 5).
trait_value(_, 0).


compatible(Plant) :-
    plant(Plant, Traits, _, _, _),
    forall(member(T, Traits), allowed(T)).

allowed(light-any).
allowed(light-bright) :- ask(light, L), member(L, [bright, any]).
allowed(light-medium) :- ask(light, L), member(L, [medium, bright, any]).
allowed(light-low) :- ask(light, L), member(L, [low, medium, any]).

allowed(water-rare) :- ask(water, W), member(W, [rare, moderate, any]).
allowed(water-moderate) :- ask(water, W), member(W, [moderate, any]).
allowed(water-frequent) :- ask(water, W), member(W, [frequent, any]).

allowed(pet-safe).
allowed(pet-toxic) :- ask(pets, P), P \= no.

allowed(care-easy).
allowed(care-medium) :- ask(care_level, C), C \= easy.
allowed(care-hard) :- ask(care_level, C), member(C, [hard, any]).

allowed(size-any).
allowed(size-small).
allowed(size-medium).
allowed(size-large) :- ask(space, S), S \= no.


% -------------------------------
% Интерфейс: вопросы и кэширование
% -------------------------------

:- dynamic user_answer/2.

ask(Question, Answer) :-
    user_answer(Question, Answer), !.
ask(Question, Answer) :-
    ask_user(Question, UserInput),
    interpret(Question, UserInput, Answer),
    assertz(user_answer(Question, Answer)), !.

interpret(_, 'не знаю', dont_care) :- !.
interpret(_, 'любой', dont_care) :- !.
interpret(_, 'без разницы', dont_care) :- !.
interpret(light, 'яркий', bright) :- !.
interpret(light, 'средний', medium) :- !.
interpret(light, 'слабый', low) :- !.
interpret(light, 'любой', any) :- !.
interpret(water, 'редко', rare) :- !.
interpret(water, 'умеренно', moderate) :- !.
interpret(water, 'часто', frequent) :- !.
interpret(water, 'любой', any) :- !.
interpret(pets, 'да', yes) :- !.
interpret(pets, 'нет', no) :- !.
interpret(pets, 'без разницы', dont_care) :- !.
interpret(care_level, 'простой', easy) :- !.
interpret(care_level, 'средний', medium) :- !.
interpret(care_level, 'сложный', hard) :- !.
interpret(space, 'да', large) :- !.
interpret(space, 'нет', no) :- !.
interpret(space, 'без разницы', dont_care) :- !.
interpret(_, _, dont_care).


ask_user(light, Input) :-
    format('~nКакое освещение у вас дома?~n'),
    format('Например: яркий (южное окно), средний (восток/запад), слабый (север или тень).~n'),
    format('Или напишите "любой", если не важно: '),
    read_line(Input).
ask_user(water, Input) :-
    format('~nКак часто готовы поливать?~n'),
    format('Варианты: редко (раз в 2 недели), умеренно (еженедельно), часто (почти каждый день).~n'),
    format('Или "любой": '),
    read_line(Input).
ask_user(pets, Input) :-
    format('~nЕсть ли домашние животные, которые могут грызть растения?~n'),
    format('Ответьте: да / нет / без разницы: '),
    read_line(Input).
ask_user(care_level, Input) :-
    format('~nНасколько сложный уход вы готовы обеспечить?~n'),
    format('Варианты: простой / средний / сложный / любой: '),
    read_line(Input).
ask_user(space, Input) :-
    format('~nХватает ли места для большого растения (выше 1 м)?~n'),
    format('Ответьте: да / нет / без разницы: '),
    read_line(Input).

read_line(Input) :-
    flush_output,
    read_line_to_string(current_input, Str),
    string_lower(Str, Lower),
    split_string(Lower, " \t", " \t", Words),
    (   Words = [Word|_]
    ->  atom_string(Input, Word)
    ;   Input = ''
    ), !.
read_line(_) :- read_line(_).


% -------------------------------
% Основная функция
% -------------------------------

show_recommendation(Plant) :-
    plant(Plant, _, Desc, Care, Fact),
    format('~nМОЯ РЕКОМЕНДАЦИЯ: ~w~n', [Plant]),
    format('Описание: ~w~n', [Desc]),
    format('Уход: ~w~n', [Care]),
    format('Интересный факт: ~w~n', [Fact]).

start :-
    format('Добро пожаловать в умного помощника по комнатным растениям!~n'),
    format('Я помогу подобрать идеальное растение под ваши условия.~n'),
    retractall(user_answer(_, _)),
    findall(P, compatible(P), Candidates),
    (   Candidates = []
    ->  format('~nК сожалению, не нашлось растений, подходящих под ваши условия.~n')
    ;   findall(Score-Plant, (
            member(Plant, Candidates),
            rank_plant(Plant, Score)
        ), Scored),
        sort(Scored, Sorted),
        reverse(Sorted, [_BestScore-Best|Rest]),
        show_recommendation(Best),
        (   Rest = []
        ->  true
        ;   format('~nТакже вам могут подойти:~n'),
            forall(member(_-P, Rest), (
                plant(P, _, Desc, _, _),
                format('- ~w: ~w~n', [P, Desc])
            ))
        )
    ),
    format('~nХотите попробовать снова? (да/нет): '),
    read_line(Resp),
    (   member(Resp, ['да', 'yes', 'y', 'д'])
    ->  start
    ;   format('Спасибо, что воспользовались советчиком!~n')
    ).
