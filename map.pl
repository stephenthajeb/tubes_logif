:- dynamic(playerLoc/2).
:- dynamic(friendLoc/2).
:- dynamic(enemyLoc/2).
:- dynamic(healLoc/2).

/* Map 10x10, indeks dari 0 dan 11 sebagai border, indeks 1 sampai 10 active Area */
border(0,Y) :- Y>(-1),Y<12.
border(11,Y) :- Y>(-1),Y<12.
border(X,0) :- X>(-1),X<12.
border(X,11) :- X>(-1),X<12.
activeArea(X,Y) :- X>(0),X<11,Y>(0),Y<11.

/* Inisialisasi awal */
init :- asserta(playerLoc(1,1)).
init :- asserta(friendLoc(2,2)).
init :- asserta(enemyLoc(10,10)).
init :- asserta(healLoc(6,10)).

printmap(X,Y) :- playerLoc(X,Y),write('P').
printmap(X,Y) :- border(X,Y),write('X').
printmap(X,Y) :- friendLoc(X,Y),write('F').
printmap(X,Y) :- enemyLoc(X,Y),write('E').
printmap(X,Y) :- healLoc(X,Y),write('H').
printmap(X,Y) :- activeArea(X,Y),write('-').

/*Move*/
invalidMove :- write('Invalid Move !! Kamu tidak boleh melewat border cuy'),nl.

east  :- playerLoc(10,_),invalidMove,!.
east  :- playerLoc(X,Y),NewX is X+1,retract(playerLoc(X,Y)),asserta(playerLoc(NewX,Y)),msgAfterMove.
west  :- playerLoc(1,_),invalidMove,!.
west  :- playerLoc(X,Y),NewX is X-1,retract(playerLoc(X,Y)),asserta(playerLoc(NewX,Y)),msgAfterMove.
north :- playerLoc(_,1),invalidMove,!.
north :- playerLoc(X,Y),NewY is Y-1,retract(playerLoc(X,Y)),asserta(playerLoc(X,NewY)),msgAfterMove.
south :- playerLoc(_,10),invalidMove,!.
south :- playerLoc(X,Y),NewY is Y+1,retract(playerLoc(X,Y)),asserta(playerLoc(X,NewY)),msgAfterMove.

/*Logic ketika player ketemu friend, enemy, atau berada di health center */
msgAfterMove :- playerLoc(X,Y),write('Sekarang anda berada pada ('),print(X),write(','),print(Y),write(')'),!.

/*
msgAfterMove :- playerLoc(X,Y),friendLoc(X,Y),write('Kamu ketemu dengan ..... teman baik lamamu,coba meyakinkan dia untuk mengikuti kamu atau hindarin dia?').
msgAfterMove :- playerLoc(X,Y),enemyLoc(X,Y),write('Kamu ketemu dengan musuh legendary Clan Akatsuki, lari atau bertanding ?'),!.
msgAfterMove :- playerLoc(X,Y),healthLoc(X,Y),write('Anda berada di Health Center,Anda boleh menyembuhkan 1 orang di sini, Menyembuhkan siapa ?'),!.
*/

map:- forall(between(0,11,Y),(forall(between(0,11,X),printmap(X,Y)),nl)).