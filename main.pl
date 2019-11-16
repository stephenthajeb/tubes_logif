:- include('print.pl').
:- include('map.pl').
:- include('character.pl').
:- include('battle.pl').
:- include('Generate.pl').

/*Untuk menunjukkan apakah pemain pernah menekan command [1]*/
:-dynamic(startStatus/1).

start :-    
    print_Title,
    print_Story,
    help,
    init,
    init_Player,
    init_Enemy,
    enemyGenerator,
    map.
    /*
    repeat,
        write('Your command: '),
        read(Input),nl,
        call(Input),nl,
    (Input==exit; endGame).*/

endGame :- 
    inventory([]),
    print_Lose,!.

endGame :-
    winCondition,
    print_Win,!.

help :- print_Help.
exit :- 
    retractall(playerLoc(_,_)),
    retractall(player(_,_,_,_,_,_,_)),
    retractall(enemy(_,_,_,_,_,_,_)),
    retractall(enemyName(_)),
    retractall(enemyLocX(_)),
    retractall(enemyLocY(_)),
    print_Lose.

run :- runAwayNormalEnemyProbability.

/*Aksi terhadap command*/
/*Ganti init dr map jd init yang player*/
/*
inputCmd(X) :- X=1,init,map,retract(startStatus(0)),asserta(startStatus(1)),gameOnGoing.
inputCmd(X) :- X>0,X<17,X\==6,X\==12,X\==14,X\==15,X\==16,startStatus(0),write('command ini hanya bisa dipakai setelah permainan dimulai'),nl,!.
inputCmd(X) :- X=2,west,!.
inputCmd(X) :- X=3,east,!.
inputCmd(X) :- X=4,north,!.
inputCmd(X) :- X=5,south,!.
inputCmd(X) :- X=6,printArah,!.
inputCmd(X) :- X=11,print_PlayerStatus,!.
inputCmd(X) :- X=12,map,!.
inputCmd(X) :- X=15,help,!.
inputCmd(X) :- X=16,
               write('Yahhh, Hinatanya g jadi diselamatin dong'),nl,
               halt,!.
/*Ini masih aneh*/
/*
inputCmd(X) :- X=2,X=3,X=4,X=5,printCommandInvalid,!.
*/
/* inputCmd(X) :- Sisany */
/*
gameOnGoing :-  repeat,
                    printInputCommand,                
                    read(X),X\==1,inputCmd(X),
                X=16. 
*/
                /*Tambahin syarat jika kalah gama assert startStatus(0)
3,3
10,7
3,9
7,2
5,2
6,4
8,2
4,9
1,6


*/
