:- dynamic(playerLoc/2).
:- dynamic(enemyLoc/2).
:- dynamic(healStatus/1).

/* Map 10x10, indeks dari 0 dan 11 sebagai border, indeks 1 sampai 10 active Area */
border(0,Y) :- Y>(-1),Y<12.
border(11,Y) :- Y>(-1),Y<12.
border(X,0) :- X>(-1),X<12.
border(X,11) :- X>(-1),X<12.
activeArea(X,Y) :- X>(0),X<11,Y>(0),Y<11.

/* Inisialisasi awal */

/*Masih blm ada posisi enemy dan friend*/

init :- asserta(playerLoc(1,1)),
        asserta(healStatus(0)).

healLoc(2,2).
enemyLoc(2,4).

/* Print Legend Map */
printmap(X,Y) :- playerLoc(X,Y),write('P').
printmap(X,Y) :- border(X,Y),write('X').
printmap(X,Y) :- healLoc(X,Y),write('H').
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

w :- north, move_Player.
a :- west, move_Player.
s :- south, move_Player.
d :- east, move_Player.

/* Collision terjadi jika ada 2 huruf di satu koordinat peta*/
/* Tambahin aksi setelah collision*/
collision(X,Y)  :- playerLoc(X,Y),healLoc(X,Y),print_Heal,!.
collision(X,Y)  :- playerLoc(X,Y),enemyLocX(X1),enemyLocY(Y1),checkKoordinat(X,Y,X1,Y1),print_FoundEnemy,nl,!.
collision(X,Y)  :- !.

heal :- playerLoc(X1,Y1),healLoc(X2,Y2),X1\==X2,Y1\==Y2,printCommandInvalid,!.
heal :- healStatus(0),
        player(Name, Type, X, Y, HP, NDamage, SDamage),
        hp(Name,HPAwal),
        retract(player(Name, Type, X, Y, HP, NDamage, SDamage)),
        asserta(player(Name, Type, X, Y, HPAwal, NDamage, SDamage)),
        print_PlayerStatus,
        retract(healStatus(0)),
        asserta(healStatus(1)).

/*Logic ketika player ketemu friend, enemy, atau berada di health center */
msgAfterMove :- playerLoc(X,Y),write('Sekarang Player berada pada ('),print(X),write(','),print(Y),write(')'),nl,collision(X,Y).

/* Rules Print Map */
map:- forall(between(0,11,Y),(forall(between(0,11,X),printmap(X,Y)),nl)).
