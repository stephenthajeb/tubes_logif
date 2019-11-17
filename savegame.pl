:- include('character.pl').

save:-
	nl, write('Ingin simpan dengan nama?'), nl,
	write('>> '), read(File),
	atom_concat(File, '.txt', Filetxt),
	open(Filetxt, write, Stream),
	save_status(Stream),
	close(Stream), 	write('Permainan telah disimpan!'), nl.

save_status(Stream) :-
	save_player(Stream).
save_status(Stream) :-
	save_inventory(Stream).
save_status(Stream) :-
	save_currHP(Stream).
save_status(Stream) :-
	save_enemy(Stream).
save_status(_) :- !.

save_player(Stream) :-
	player(Name, Type, X, Y, HP, NDamage, SDamage),
	write(Stream, player(Name, Type, X, Y, HP, NDamage, SDamage)), write(Stream, '.'), nl(Stream),
	fail.

save_enemy(Stream) :-
 	enemy(Name, Type, X, Y, HP, NDamage, SDamage),
	write(Stream, enemy(Name, Type, X, Y, HP, NDamage, SDamage)), write(Stream, '.'), nl(Stream),
	fail.

save_inventory(Stream) :-
	inventory(ListInventory),
	write(Stream, inventory(ListInventory)),  write(Stream, '.'), nl(Stream),
	fail.

save_currHP(Stream) :-
	currHP(ListHP),
	write(Stream, currHP(ListHP)), write(Stream, '.'), nl(Stream),
	fail.