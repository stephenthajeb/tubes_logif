/*Include */
:-include('character.pl').

/* Map 10x10, indeks dari 0 dan 11 sebagai border, indeks 1 sampai 10 active Area */
border(0,Y) :- Y>(-1),Y<12.
border(11,Y) :- Y>(-1),Y<12.
border(X,0) :- X>(-1),X<12.
border(X,11) :- X>(-1),X<12.
activeArea(X,Y) :- X>(0),X<11,Y>(0),Y<11.

/* Inisialisasi awal */

/*Masih blm ada posisi enemy dan friend*/
init :- asserta(healLoc(2,1)),init_Player.

printmap(X,Y) :- player(_,_,X,Y,_,_,_,_),write('P').
printmap(X,Y) :- border(X,Y),write('X').
printmap(X,Y) :- healLoc(X,Y),write('H').
/*
printmap(X,Y) :- friendLoc(X,Y),write('F').
printmap(X,Y) :- enemyLoc(X,Y),write('E').
*/
printmap(X,Y) :- activeArea(X,Y),write('-').

/*Move*/

east  :- player(_,_,10,_,_,_,_,_),printInvalidMove,!.
east  :- player(_,_,X,Y,_,_,_,_),NewX is X+1,retract(player(_,_,X,Y,_,_,_,_)),asserta(player(_,_,NewX,Y,_,_,_,_)),msgAfterMove,!.
west  :- player(_,_,1,_,_,_,_,_),printInvalidMove,!.
west  :- player(_,_,X,Y,_,_,_,_),NewX is X-1,retract(player(_,_,X,Y,_,_,_,_)),asserta(player(_,_,NewX,Y,_,_,_,_)),msgAfterMove,!.
north :- player(_,_,_,1,_,_,_,_),printInvalidMove,!.
north :- player(_,_,X,Y,_,_,_,_),NewY is Y-1,retract(player(_,_,X,Y,_,_,_,_)),asserta(player(_,_,X,NewY,_,_,_,_)),msgAfterMove,!.
south :- player(_,_,_,10,_,_,_,_),printInvalidMove,!.
south :- player(_,_,X,Y,_,_,_,_),NewY is Y+1,retract(player(_,_,X,Y,_,_,_,_)),asserta(player(_,_,X,NewY,_,_,_,_)),msgAfterMove,!.

/* Collision terjadi jika ada 2 huruf di satu koordinat peta*/
/* Tambahin aksi setelah collision*/
collision(X,Y)  :- player(_,_,X,Y,_,_,_,_),healLoc(X,Y),printHealthCenter,!.
collision(X,Y)  :- player(_,_,X,Y,_,_,_,_),enemyLoc(X,Y),write('Kamu ketemu dengan musuh legendary Clan Akatsuki, lari atau bertanding ?'),nl,!.
collision(X,Y)  :- player(_,_,X,Y,_,_,_,_),friendLoc(X,Y),write('Kamu ketemu dengan ..... teman baik lamamu,coba meyakinkan dia untuk mengikuti kamu atau hindarin dia?'),nl,!.

/*Logic ketika player ketemu friend, enemy, atau berada di health center */
msgAfterMove :- player(_,_,X,Y,_,_,_,_),write('Sekarang anda berada pada ('),print(X),write(','),print(Y),write(')'),nl,collision(X,Y).

map:- forall(between(0,11,Y),(forall(between(0,11,X),printmap(X,Y)),nl)).




