load_game :-
	read(X),
    open(X, read, Str),
    file_read(Str,Saved),
    close(Str).

file_read(Stream,[]) :-
    at_end_of_stream(Stream).

file_read(Stream,H|T]) :-
    \+ at_end_of_stream(Saved),
    read(Stream,H),
    file_read(Stream,T).