:- include('character.pl').

load :-
	nl, write('Masukkan game yang ingin diload!'), nl,
	write('>> '), read(File),
	atom_concat(File, '.txt', Filetxt),
	load_status(Filetxt).
load_status(Filetxt):-
	retractall(enemy(_,_,_,_,_,_,_)),
	retractall(player(_,_,_,_,_,_,_)),
	retractall(inventory(_)),
	retractall(currHP(_)),
	retractall(playerLoc(_,_)),
	open(Filetxt, read, Stream),
	repeat,
		read(Stream, In),
		asserta(In),
	at_end_of_stream(Stream),
	close(Stream),
	nl, write('Game berhasil diload!'), nl, !.
load_status(_):-
	nl, write('Tidak ada game dengan nama itu!'), nl, fail.