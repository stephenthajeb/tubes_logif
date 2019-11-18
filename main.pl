:- include('print.pl').
:- include('map.pl').
:- include('character.pl').
:- include('battle.pl').
:- include('Generate.pl').
:- include('savegame.pl').
:- include('loadgame.pl').

/*Untuk menunjukkan apakah pemain pernah menekan command [1]*/
:-dynamic(startStatus/1).

start :-    
    print_Title,
    print_Story,
    help,
    init,
    init_database,
    init_Player,
    enemyGenerator,
    map,
    repeat,
        generate_Akatsuki_Enemy,
        write('Your command: '),
        read(Input),
        print_InvalidCommand(Input),
        (Input==w;Input==a;Input==s;Input==d;Input==status;Input==map;Input==help;Input==exit;Input==save;Input==load;Input==heal;Input==drop),
        nl,
        call(Input),nl,
    (Input==exit; endGame).

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
    retractall(enemy_appear(_)),
    retractall(twoAkatsuki(_)),
    retractall(nbAkatsuki(_)),
    retractall(akatsuki_Appear(_)),
    print_Lose.
