/*Include
:-include('Generate.pl').
*/

/* Map 10x10, indeks dari 0 dan 11 sebagai border, indeks 1 sampai 10 active Area */
border(0,Y) :- Y>(-1),Y<12.
border(11,Y) :- Y>(-1),Y<12.
border(X,0) :- X>(-1),X<12.
border(X,11) :- X>(-1),X<12.
activeArea(X,Y) :- X>(0),X<11,Y>(0),Y<11.

/* Inisialisasi awal */

/*Masih blm ada posisi enemy dan friend*/
init :- asserta(healLoc(2,1)),asserta(playerLoc(1,1)).

printmap(X,Y) :- playerLoc(X,Y),write('P').
printmap(X,Y) :- border(X,Y),write('X').
printmap(X,Y) :- healLoc(X,Y),write('H').
/*
printmap(X,Y) :- friendLoc(X,Y),write('F').
printmap(X,Y) :- enemyLoc(X,Y),write('E').
*/
printmap(X,Y) :- activeArea(X,Y),write('-').

/*Move*/

east  :- playerLoc(10,_),printInvalidMove,!.
east  :- playerLoc(X,Y),NewX is X+1,retract(playerLoc(X,Y)),asserta(playerLoc(NewX,Y)),msgAfterMove,!.
west  :- playerLoc(1,_),printInvalidMove,!.
west  :- playerLoc(X,Y),NewX is X-1,retract(playerLoc(X,Y)),asserta(playerLoc(NewX,Y)),msgAfterMove,!.
north :- playerLoc(_,1),printInvalidMove,!.
north :- playerLoc(X,Y),NewY is Y-1,retract(playerLoc(X,Y)),asserta(playerLoc(X,NewY)),msgAfterMove,!.
south :- playerLoc(_,10),printInvalidMove,!.
south :- playerLoc(X,Y),NewY is Y+1,retract(playerLoc(X,Y)),asserta(playerLoc(X,NewY)),msgAfterMove,!.

/* Collision terjadi jika ada 2 huruf di satu koordinat peta*/
/* Tambahin aksi setelah collision*/
collision(X,Y)  :- playerLoc(X,Y),healLoc(X,Y),printHealthCenter,!.
collision(X,Y)  :- playerLoc(X,Y),enemyLoc(X,Y),write('Kamu ketemu dengan musuh legendary Clan Akatsuki, lari atau bertanding ?'),nl,!.
collision(X,Y)  :- playerLoc(X,Y),friendLoc(X,Y),write('Kamu ketemu dengan ..... teman baik lamamu,coba meyakinkan dia untuk mengikuti kamu atau hindarin dia?'),nl,!.

/*Logic ketika player ketemu friend, enemy, atau berada di health center */
msgAfterMove :- playerLoc(X,Y),write('Sekarang anda berada pada ('),print(X),write(','),print(Y),write(')'),nl,collision(X,Y).

map:- forall(between(0,11,Y),(forall(between(0,11,X),printmap(X,Y)),nl)).




