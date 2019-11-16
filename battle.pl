/* Attack Mechanism */
/* attack(AttType, PlayerType, EnemyType)
    AttType == 1 : Normal
    AttType == 2 : Skill */
/* PLAYER */

:- dynamic(attackStatus/1).
:- dynamic(healStatus/1).
:- dynamic(skillStatus/1).

/* Strong TYPE */
player_Attack(1) :-
    strong(PlayerType,EnemyType),
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(NDamage + (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

player_Attack(2) :-
    strong(PlayerType,EnemyType),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(SDamage + (SDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* WEAK TYPE */
player_Attack(1) :-
    strong(EnemyType,PlayerType),
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(NDamage - (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

player_Attack(2) :-
    strong(EnemyType,PlayerType),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(SDamage - (SDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* NORMAL TYPE */
player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-NDamage,
    NewHP < 1,
    /*Cek inventory*/
    print_Capture.

player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-NDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

player_Attack(2) :-
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-SDamage,
    NewHP < 1,
    print_Capture.

player_Attack(2) :-
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-SDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.


/* ENEMY */
/* STRONG TYPE */
enemy_Attack(1) :-
    strong(EnemyType,PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(EnemyType, PlayerType),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2) :-
    strong(EnemyType,PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2) :-
    strong(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-(SDamage + (SDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* WEAK TYPE */
enemy_Attack(1) :-
    strong(PlayerType,EnemyType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(1) :-
    strong(PlayerType,EnemyType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2) :-
    strong(PlayerType,EnemyType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2) :-
    strong(PlayerType,EnemyType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-(SDamage - (SDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* NORMAL TYPE */
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-NDamage,
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-NDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    NewHP is PlayerHP-SDamage,
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-SDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.


/* Heal */
heal :- playerLoc(X1,Y1),healLoc(X2,Y2),X1\==X2,Y1\==Y2,printCommandInvalid,!.
heal :- healStatus(0),
        player(Name, Type, X, Y, HP, NDamage, SDamage),
        retract(player(Name, Type, X, Y, HP, NDamage, SDamage)),
        asserta(player(Name, Type, X, Y, 100, NDamage, SDamage)),
        print_PlayerStatus,
        retract(healStatus(0)),
        asserta(healStatus(1)).

printKO :- player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
           write(PlayerName),
           write(' is defeated '),nl,
           write('Aku terlalu lemah untuk menyelamatkan Hinata'),nl.


/* Battle Mechanism */
/*
attack(Allies, Enemy, Kalah).
attack(Allies, Enemy, Menang).
attack(Allies, Enemy, State) :- 
    player(_, PlayerType, _, _, _, _, _, _),
    enemy(_, EnemyType, _, _, EnemyHP, _, _),
    player_Attack(AttType, PlayerType, EnemyType),
    EnemyHP==0,
    attack(Allies, Enemy, StateX),
    State is StateX.
    
attack(Allies, Enemy, State) :-
    player(_, PlayerType, _, _, _, _, _, _),
    enemy(_, EnemyType, _, _, EnemyHP, _, _),
    player_Attack(AttType, PlayerType, EnemyType),
    EnemyHP=\=0,
    enemy_Attack(AttType, EnemyType, PlayerType),
    attack(Allies, Enemy, StateX),
    State is StateX.
battle(Inventory=[], Enemy, Kalah).
battle(Allies, Enemy, State) :-
    select_player,
    attack(Allies, Enemy, Kalah),
    battle(Allies, Enemy, State).
battle(Allies, Enemy, State) :-
    select_player,
    attack(Allies, Enemy, Menang),
    insert(player),
    State is Menang.
*/