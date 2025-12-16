% Пословный перевод с английского на французский
% Факты:
translate(the, le).
translate(cat, chat).
translate(sits, s_assied).
translate(on, sur).
translate(mat, tapis).

% Правило:
translate_sentence([], []).
translate_sentence([E|Es], [F|Fs]) :-
    translate(E, F), !,
    translate_sentence(Es, Fs).
translate_sentence([_|Es], Fs) :-
    translate_sentence(Es, Fs).

%?- translate_sentence([the, cat, sits, on, the, mat], Fr).
