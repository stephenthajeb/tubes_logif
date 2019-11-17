:- dynamic(playerLoc/2).
:- dynamic(enemyLoc/2).

/* Map 10x10, indeks dari 0 dan 11 sebagai border, indeks 1 sampai 10 active Area */
border(0,Y) :- Y>(-1),Y<12.
border(11,Y) :- Y>(-1),Y<12.
border(X,0) :- X>(-1),X<12.
border(X,11) :- X>(-1),X<12.
activeArea(X,Y) :- X>(0),X<11,Y>(0),Y<11.

/*Fakta*/
healLoc(6,4).

/* Inisialisasi awal */
init :- asserta(playerLoc(1,1)),
        asserta(healStatus(0)),
        asserta(currHP([350])),
        asserta(skillStatusE(0)),
        asserta(skillStatusP(0)).

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
collision(X,Y)  :- 
    playerLoc(X,Y),
    healLoc(X,Y),
    print_Heal,!.
collision(X,Y)  :- 
    playerLoc(X,Y),
    enemyLocX(X1),
    enemyLocY(Y1),
    enemyName(ListEnemy),
    checkKoordinat(X,Y,Name,X1,Y1,ListEnemy),
    enemy_appear(ListOfEnemyAppear),
    check(ListOfEnemyAppear,Name),
    assign_Enemy(X,Y,Name),nl,
    print_FoundEnemy,nl,
    enemystatus,nl,
    write('Pilih bertarung atau lari ? (run / attack)'),nl,
    read(Input),call(Input),
    !.
collision(_,_).


/*Logic ketika player ketemu friend, enemy, atau berada di health center */
msgAfterMove :- playerLoc(X,Y),write('Sekarang Player berada pada ('),print(X),write(','),print(Y),write(')'),nl,collision(X,Y).

/* Rules Print Map */
map:- 
    write('----------------MAP-----------------'),nl,
    forall(between(0,11,Y),(forall(between(0,11,X),printmap(X,Y)),nl)),nl.
